#include "pl0-zwischencode.hpp"
#include <string>
#include <iostream>
#include <memory>
using namespace std;

zwischencode::zwischencode() {
}

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

ast_stmt * predecessor = NULL;
int label_nr = 1000; 

ast_stmt * zwischencode::new_ast_stmt(int type, string id, int stl, int val, ast_stmt * next, ast_stmt * jump) {
    ast_stmt* stmt = new ast_stmt;
    stmt->type = type;
    stmt->id = id;
    stmt->stl = stl;
    stmt->val = val;
    stmt->next = next;
    stmt->jump = jump;
    stmt->expr = nullptr;
    return stmt;
}

void zwischencode::new_ast_layer(string name) {
    ast_entry tmp;
    tmp.name = name;
    tmp.n_var = 0;
    tmp.start = NULL;
    ast.push_back(tmp);
    cerr << "Zwischencode Layer " << name << " angelegt auf Ebene" << ast.size()-1 << "\n"; 
    returnLayers.push_back(ast.size()-1);
    predecessor = NULL;
}

void zwischencode::new_Call_Node(string id, int stl, int val){
    string nId = "Call " + id;
    ast_stmt * stmt = new_ast_stmt(stmt_call, nId, stl, val);
    to_List(stmt);
}

void zwischencode::new_Eingabe_Node(string id, int stl, int val){
    string nId = "Read " + id;
    ast_stmt * stmt = new_ast_stmt(stmt_read, nId, stl, val);
    to_List(stmt);
}

void zwischencode::new_Ausgabe_Node(op_tree * _expr){
    ast_stmt * stmt = new_ast_stmt(stmt_write, "Write");
    stmt->expr = _expr;
    to_List(stmt);
}

void zwischencode::new_Assign_Node(string id, op_tree * _expr, int stl, int val){
    string nId = "Assign " + id;
    ast_stmt * stmt = new_ast_stmt(stmt_assign, nId, stl, val);
    stmt->expr = _expr;
    to_List(stmt);
}

void zwischencode::new_End_Node() {
    string nId = "End";
    ast_stmt * stmt = new_ast_stmt(stmt_end, nId);
    to_List(stmt);
    layer_Down();
}

void zwischencode::new_If_Stmt(op_tree * op) { 
    int label = label_nr++;
    string id = "NOP " + to_string(label);
    ast_stmt * nop = new_ast_stmt(stmt_nop, id, -1, label); 
    ast_stmt * n_if = new_ast_stmt(stmt_jump_false, "IF", label); 
    n_if->jump = nop;
    n_if->expr = op;
    Nops.push_back(nop);
    to_List(n_if);
}

void zwischencode::end_If() {
    ast_stmt * nop = Nops.back();
    to_List(nop);
    Nops.pop_back();
}

void zwischencode::new_While_Stmt(op_tree * op) {
    int label = label_nr++;
    int label2 = label_nr++;
    string id = "NOP " + to_string(label);
    string id2 = "NOP " + to_string(label2);
    ast_stmt * nop = new_ast_stmt(stmt_nop, id, -1, label); 
    ast_stmt * nop2 = new_ast_stmt(stmt_nop, id2, -1, label2);
    ast_stmt * jmp_f = new_ast_stmt(stmt_jump_false, "WHILE"); 
    jmp_f->jump = nop;
    jmp_f->expr = op;
    ast_stmt * jmp = new_ast_stmt(stmt_jump, "LOOP");
    jmp->jump = nop2;
    jmp->next = nop;
    Nops.push_back(jmp);
    to_List(nop2);
    to_List(jmp_f); 
}

void zwischencode::end_While() {
    ast_stmt * nop = Nops.back();
    to_List(nop);
    Nops.pop_back();
    predecessor = predecessor->next;
}

void zwischencode::to_List(ast_stmt* stmt){
    if(predecessor!=NULL) {
        predecessor->next = stmt;
    } 
    else {
        ast[returnLayers.back()].start = stmt;
    }
    predecessor = stmt;
}

void zwischencode::layer_Down(){
    returnLayers.pop_back();
    int layer = returnLayers.back();
    cerr << layer << " Layer bei layer Down Funktion \n";
    if (ast[layer].start == nullptr){
        predecessor = NULL;
    }
    else{
        predecessor = ast[layer].start;
        while (predecessor->next != nullptr){
            predecessor = predecessor->next;
        }
    }
}

void zwischencode::add_Var(){
    ast[returnLayers.back()].n_var++;
}

vector<ast_entry> zwischencode::get_ast(){
    vector<ast_entry> rt = ast;
    return rt;
}

void zwischencode::print() {
    int astSize = ast.size();
    cerr << "------------- A S T --------------\n";
    for (int i = 0; i<astSize; i++) {
        cerr << " . . . . . . . . . . . . . . . \n";
        cerr << "Layer " << i << ": " << ast[i].name << " mit " << ast[i].n_var << " Variablen\n";
        if (ast[i].start != nullptr){
            ast_stmt * dummy = ast[i].start;
            cerr << "--> Knoten: " << dummy->id;
            if (dummy->jump != nullptr){
                cerr << "\n   >> JUMP TO " << dummy->jump->id;
            }
            if (dummy->expr != nullptr){
                cerr << "\n   >> EXPRESSION\n";
                print_op(dummy);
            }
            cerr << "\n";
            while (dummy->next != nullptr){
                dummy = dummy->next;
                cerr << "--> Knoten: " << dummy->id; 
                if (dummy->jump != nullptr){
                    cerr << "\n   >> JUMP TO " << dummy->jump->id;
                }
                if (dummy->expr != nullptr){
                    cerr << "\n   >> EXPRESSION\n";
                    print_op(dummy);
                }
                cerr << "\n";
            }
        }
    } 
    cerr << "----------------------------------\n";   
}

void zwischencode::print_op(ast_stmt * dummy){
    op_tree * expr = dummy->expr;
    cerr << "# # # # # # # OP TREE # # # # # # # \n";
    zwischencode::postorder(expr);
    cerr << "# # # # # # # # # # # # # # # # # # \n";
}

void zwischencode::postorder (op_tree * node){
    if(node->links != nullptr){
        zwischencode::postorder(node->links);
    }
    if(node->rechts != nullptr){
        zwischencode::postorder(node->rechts);
    }
    cerr << node->entry.id << "\n";
}

operatorbaum::operatorbaum(){}

op_tree * operatorbaum::new_op_tree(op_entry entry, op_tree * l, op_tree * r){
    op_tree * new_op = new op_tree;
    new_op->entry = entry;
    new_op->links = l;
    new_op->rechts = r;

    return new_op;
}

op_entry operatorbaum::new_op_entry(int type, string id, int stl, int val){
    op_entry entry;
    entry.type = type;
    entry.id = id;
    entry.stl = stl;
    entry.val = val;

    return entry;
}