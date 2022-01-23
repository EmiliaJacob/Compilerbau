#include "pl0_codegeneration.hpp"

using namespace std;

string file;

codegeneration::codegeneration(){}

void codegeneration::generate(vector<ast_entry> _ast) 
{
    ofstream f(file, ofstream::out);
    of.open(file);
    ast = _ast;
    int astSize = ast.size();

    // go through every function ast
    for (int i = 0; i < astSize; i++) 
    {
        // check if ast is not empty
        if (ast[i].start != nullptr) 
        {
            ast_stmt * stmt = ast[i].start;

            // for every ast besides main
            if (i > 0) 
            {
                of << "\n";
                emit(to_string(i), "nop", "", "# " + ast[i].name);
            }
            // for main
            else
            {
                emit("", "loadc", "0");
                emit("", "dup");
                emit("", "storer", "0");
            }
            // load how many var in function and call RAM_UP
            emit("", "loadc", to_string(ast[i].n_var));
            emit("", "call", "RAM_UP");

            bool go_on;
            if (stmt->type != stmt_end)
                go_on = true;
            else 
                go_on = false;
            
            while(go_on) 
            {
                // go through every statement of ast
                aassemble_stmt(stmt);
                if (stmt->next->type != stmt_end) 
                    stmt = stmt->next;
                else 
                {
                    go_on = false;
                    emit("", "call", "RAM_DOWN");
                }
                    
            }

        }
        emit("", "return");
        of << "\n";
    }

    ram_up();
    ram_down();

    of.close();
}

void codegeneration::aassemble_stmt(ast_stmt * _stmt)
{
    ast_stmt * stmt = _stmt;
    switch(stmt->type)
    {
        case stmt_assign:
            aassemble_expr(stmt->expr);
            ram_var_adr(stmt->id, stmt->stl, stmt->val);
            emit("", "stores");
            break;
        case stmt_call:
            emit("", "loadr", "0");
            for (int i = 0; i < stmt->stl; i++)
                emit("", "loads");
            emit("", "call", to_string(stmt->val), "# " + stmt->id);
            break;
        case stmt_read:
            emit("", "read");
            ram_var_adr(stmt->id, stmt->stl, stmt->val);
            emit("", "stores");
            break;
        case stmt_write:
            aassemble_expr(stmt->expr);
            emit("", "write");
            break;
        case stmt_jump_false:
            aassemble_expr(stmt->expr);
            emit("", "jumpz", to_string(stmt->jump->val));
            break;
        case stmt_jump:
            emit("", "jump", to_string(stmt->jump->val));
            break;
        case stmt_nop:
            emit(to_string(stmt->val), "nop");
            break;
    }
}

void codegeneration::aassemble_expr(op_tree * _expr, int nr)
{
    expr_postorder(_expr);
}

void codegeneration::expr_postorder(op_tree * op)
{
    if (op->left != nullptr)
        codegeneration::expr_postorder(op->left);
    if (op->right != nullptr)
        codegeneration::expr_postorder(op->right);
    
    switch (op->entry.type)
    {
    case t_PLUS:
        emit("", "add");
        break;
    case t_MINUS:
        if(op->right != nullptr)
            emit("", "sub");
        else
            emit("", "chs");
        break;
    case t_MULT:
        emit("", "mult");
        break;
    case t_DIV:
        emit("", "div");
        break;
    case t_N_EQUAL:
        emit("", "cmpne");
        break;
    case t_EQUAL:
        emit("", "cmpeq");
        break;
    case t_LT:
        emit("", "cmplt");
        break;
    case t_LTE:
        emit("", "cmple");
        break;
    case t_GT:
        emit("", "cmpgt");
        break;
    case t_GTE:
        emit("", "cmpge");
        break;
    case t_ODD:
        emit("", "loadc", "2");
        emit("", "mod");
        break;
    case t_NUMBER:
        emit("", "loadc", to_string(op->entry.val));
        break;
    case t_IDENT:
        ram_var_adr(op->entry.id, op->entry.stl, op->entry.val);
        emit("", "loads");
        break;
    }
}

void codegeneration::ram_var_adr(string id, int stl, int val)
{
    string comment = "# adr var " + id + ": sym " + to_string(stl) + "|" + to_string(val);
    emit("", "loadr", "0", comment);
    
    for (int i = 0; i < stl; i++)   // load register on stack if stl > 0
        emit("", "loads");
    
    emit("", "loadc", "2");         // go down for DL and SL   
    emit("", "sub");
    if (val > 0) 
    {
        emit("", "loadc", to_string(val));  // go down for val
        emit("", "sub");
    }
    
}

void codegeneration::ram_up()
{
    emit("RAM_UP", "loadr", "0");   // load register TOS
    emit("", "add");                // add var count of fuction
    emit("", "loadc", "2");         // add DL and SL
    emit("", "add");
    emit("", "dup");                // dup to have register for DL and SL
    emit("", "loadc", "1");         // one down for DL
    emit("", "sub");
    emit("", "loadr", "0");         // load TOS
    emit("", "swap");
    emit("", "stores");             // store TOS in DL
    emit("", "dup");
    emit("", "storer", "0");        // store SL in TOS
    emit("", "stores");             // store old TOS in SL
    emit("", "return");
    of << "\n";
}

void codegeneration::ram_down()
{
    emit("RAM_DOWN", "loadr", "0"); // load TOS
    emit("", "loadc", "1");
    emit("", "sub");
    emit("", "loads");              // load DL
    emit("", "storer", "0");        // store DL in TOS
    emit("", "return");
    of << "\n";
}

void codegeneration::emit(string nr, string cmd, string arg, string comment)
{
    of << nr << "\t" << cmd << "\t" << arg << "\t" << comment << "\n";
}