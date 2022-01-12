#include "pl0-codeerzeugung.hpp"

using namespace std;

//Mögliche Typen:
// stmt_end = 0
// stmt_assign = 1
// stmt_call = 2
// stmt_read = 3
// stmt_write = 4
// stmt_debug = 5
// stmt_jump_false = 6
// stmt_nop = 7
// stmt_jump = 8


codeerzeugung::codeerzeugung(){}

string filename;

void codeerzeugung::generate(vector<ast_entry> _ast){
    ofstream f(filename , ofstream::out);
    of.open(filename);
    ast = _ast;
    int astSize = ast.size();
    // Für jede neue Funktion
    for (int i = 0; i<astSize; i++) {
        if (ast[i].start != nullptr){
            ast_stmt * dummy = ast[i].start;
            
            //Für alle Funktionen außer Main
            if (i > 0){
                of << "\n";
                string comment = "# " + ast[i].name;
                emit(to_string(i), "nop", "", comment);
            }
            else{
                 
                emit("", "loadc", "0");
                emit("", "dup");
                emit("", "storer", "0");         
            }
            emit("", "loadc", to_string(ast[i].n_var));
            emit("", "call", "RAM_UP");
            bool next_round;
            if(dummy->type != stmt_end){
                next_round = true;
            } 
            else{
                next_round = false;
            }
            while (next_round){
                
                assemble_statement(dummy);
                if (dummy->next->type != stmt_end){
                    dummy = dummy->next;
                }
                else{
                    next_round = false;
                    emit("", "call", "RAM_DOWN");
                }
            }
        }
        emit("", "return");
    }
    
    //Assembler Unterprogramme anlegen 
    ram_up();
    ram_down();

    of.close();
}

void codeerzeugung::assemble_statement(ast_stmt * _stmt){
    ast_stmt * dummy = _stmt;
    string parameter;
    string comment;
    switch(dummy->type){
        case stmt_assign:
            assemble_expression(dummy->expr);
            ram_var_adr(dummy->stl, dummy->val);
            emit("", "stores");
            break;
        case stmt_call:
            emit("", "loadr", "0");
            for(int i = 0; i<dummy->stl; i++){
                emit("", "loads");
            }
            comment = "# " + dummy->id;
            emit("", "call", to_string(dummy->val), comment);
            break;
        case stmt_read:
            emit("", "read");
            ram_var_adr(dummy->stl, dummy->val);
            emit("", "stores");
            break;
        case stmt_write:
            assemble_expression(dummy->expr);
            emit("", "write");
            break;
        case stmt_jump: 
            parameter = to_string(dummy->jump->val);
            emit("", "jump", parameter);
            break;
        case stmt_jump_false:
            assemble_expression(dummy->expr);
            parameter = to_string(dummy->jump->val);      
            emit("", "jumpz", parameter);
            break;
        case stmt_nop:
            emit(to_string(dummy->val), "nop");
            break;
    }
}

void codeerzeugung::assemble_expression(op_tree * _expr, int label){
    exp_postorder(_expr);
}

void codeerzeugung::exp_postorder(op_tree * _op){
    if(_op->links != nullptr){
        codeerzeugung::exp_postorder(_op->links);
    }
    if(_op->rechts != nullptr){
        codeerzeugung::exp_postorder(_op->rechts);
    }

    switch(_op->entry.type){
        case t_plus:
            emit("", "add");
            break;
        case t_minus:
            if(_op->rechts != nullptr){
                emit("", "sub");
            }
            else{
                emit("", "chs");
            }
            break;
        case t_mal:
            emit("", "mult");
            break;
        case t_div:
            emit("", "div");
            break;
        case t_ungleich:
            emit("", "cmpne");
            break;
        case t_kleiner_gleich:
            emit("", "cmple");
            break;
        case t_kleiner:
            emit("", "cmplt");
            break;
        case t_groesser_gleich:
            emit("", "cmpge");
            break;
        case t_groesser:
            emit("", "cmpgt");
            break;
        case t_gleich:
            emit("", "cmpeq");
            break;
        case t_odd:
            emit("", "loadc", "2");
            emit("", "mod");
            break;
        case t_number:
            emit("", "loadc", to_string(_op->entry.val));
            break;
        case t_ident:
            ram_var_adr(_op->entry.stl, _op->entry.val);
            emit("", "loads"); 
            break;
    }
}

void codeerzeugung::ram_var_adr(int stl, int val){
    string comment = "# Adresse von " + to_string(stl) + "/" + to_string(val);
    emit("", "loadr", "0", comment);
    for(int i = 0; i <stl; i++){
        emit("", "loads");
    }
    emit("", "dec", "2");
    emit("", "dec", to_string(val));
}

void codeerzeugung::ram_up(){
    emit("RAM_UP", "loadr", "0");  //alten Top of stack laden
    emit("", "add");        // RAM[0] + n
    emit("", "inc", "2");   // + AR Größe (2)
    emit("", "dup");   // Duplizieren, weil wir SL und DL brauchen
    emit("", "dec", "1");   // für DL -1 machen
    emit("", "loadr", "0"); // RAM[0] TOS laden
    emit("", "swap");       // DL adresse oben und alter tos an zweiter stelle
    emit("", "stores");     // oberster wert ist adresse, zweiter wert, der wert, der an dieser adresse gespeichert werden soll
    emit("", "dup");        
    emit("", "storer", "0");// TOS wird auf SL gesetzt
    emit("", "stores");     // alten SL in neuen SL schreiben
    emit("", "return");
    of << "\n";
}

void codeerzeugung::ram_down(){
    emit("RAM_DOWN", "loadr", "0"); // TOS auf stack
    emit("", "dec", "1");
    emit("", "loads");          // Wert, der in RAM[DL] drin steht
    emit("", "storer", "0");    // RAM[DL] in TOS schreiben
    emit("", "return");
    of << "\n";
}

void codeerzeugung::emit(string label, string cmd, string parameter, string kommentar){
    of << label << "\t" << cmd << "\t" << parameter << "\t" << kommentar << "\n";
}

