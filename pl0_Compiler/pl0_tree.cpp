#include "pl0_tree.hpp"
#include <iostream>
#include <string>

using namespace std;

tree::tree() {}

ast_stmt * predecessor = NULL;
int labelNr = 1000;

ast_stmt * tree::new_ast_stmt(int type, string id, int stl, int val, ast_stmt * next, ast_stmt * jump) 
{
    ast_stmt * stmt = new ast_stmt;
    stmt->type = type;
    stmt->id = id;
    stmt->stl = stl;
    stmt->val = val;
    stmt->next = next;
    stmt->jump = jump;
    stmt->expr = nullptr;
    return stmt;
}

void tree::new_ast_level(string name) 
{
    ast_entry new_level;
    new_level.start = NULL;
    new_level.name = name;
    new_level.n_var = 0;
    ast_list.push_back(new_level);
    levels.push_back(ast_list.size() - 1);
    predecessor = NULL;
}

void tree::new_assign(string id, op_tree * ex, int stl, int val) 
{
    ast_stmt * stmt = new_ast_stmt(stmt_assign, "ASSIGN " + id, stl, val);
    stmt->expr = ex;
    add_to_ast_list(stmt);
}

void tree::new_call(string id, int stl, int val) 
{
    ast_stmt * stmt = new_ast_stmt(stmt_call, "CALL " + id, stl, val);
    add_to_ast_list(stmt);
}

void tree::new_read(string id, int stl, int val) 
{
    ast_stmt * stmt = new_ast_stmt(stmt_read, "READ " + id, stl, val);
    add_to_ast_list(stmt);
}

void tree::new_write(op_tree * expr) 
{
    ast_stmt * stmt = new_ast_stmt(stmt_write, "WRITE");
    stmt->expr = expr;
    add_to_ast_list(stmt);
}

void tree::new_if(op_tree * op) 
{
    int label = labelNr++;
    ast_stmt * nop = new_ast_stmt(stmt_nop, "NOP " + to_string(label), -1, label);
    ast_stmt * stmt = new_ast_stmt(stmt_jump_false, "IF", label);
    stmt->jump = nop;
    stmt->expr = op;
    nops.push_back(nop);
    add_to_ast_list(stmt);
}

void tree::end_if()
{
    ast_stmt * nop = nops.back();
    add_to_ast_list(nop);
    nops.pop_back();
}

void tree::new_while(op_tree * op) 
{
    int label1 = labelNr++, label2 = labelNr++;
    ast_stmt * nop1 = new_ast_stmt(stmt_nop, "NOP " + to_string(label1), -1, label1);
    ast_stmt * nop2 = new_ast_stmt(stmt_nop, "NOP " + to_string(label2), -1, label2);
    ast_stmt * stmt = new_ast_stmt(stmt_jump_false, "WHILE");
    stmt->jump = nop1;
    stmt->expr = op;
    ast_stmt * jump = new_ast_stmt(stmt_jump, "JUMP");
    jump->jump = nop2;
    jump->next = nop1;
    nops.push_back(jump);
    add_to_ast_list(nop2);
    add_to_ast_list(stmt);
}

void tree::end_while() 
{
    ast_stmt * nop = nops.back();
    add_to_ast_list(nop);
    nops.pop_back();
    predecessor = predecessor->next;
}

void tree::new_end() 
{
    ast_stmt * stmt = new_ast_stmt(stmt_end, "END");
    add_to_ast_list(stmt);
    level_down();
}

void tree::add_to_ast_list(ast_stmt * stmt) 
{
    if (predecessor != NULL)
        predecessor->next = stmt;
    else
        ast_list[levels.back()].start = stmt;
    
    predecessor = stmt;
}

void tree::level_down() 
{
    levels.pop_back();
    int level = levels.back();
    if (ast_list[level].start == nullptr)
        predecessor = NULL;
    else 
    {
        predecessor = ast_list[level].start;
        while (predecessor->next != nullptr)
            predecessor = predecessor->next;
    }
}

void tree::add_var() 
{
    ast_list[levels.back()].n_var++;
}

vector<ast_entry> tree::get_ast_list() 
{
    vector<ast_entry> current_ast = ast_list;
    return current_ast;
}

void tree::print() {
    cerr << "############### A S T ###############\n";
    for (int i = 0; i < ast_list.size(); i++) {
        if (ast_list[i].start != nullptr){
            cerr << "-------------------------------------\n";
            cerr << "level " << i << ": " << ast_list[i].name << " with " << ast_list[i].n_var << " variables.\n";
            cerr << "-------------------------------------\n";

            ast_stmt * stmt = ast_list[i].start;

            cerr << ">> Node: " << stmt->id << "\n";
            if (stmt->jump != nullptr)
                cerr << "   >> JUMP TO " << stmt->jump->id;
            if (stmt->expr != nullptr)
            {
                cerr << "   >> EXPRESSION\n";
                cerr << "      ------ OP TREE ------\n";
                op_tree * expr = stmt->expr;
                postorder(expr);
                cerr << "      ---------------------\n";
            }
            cerr << "\n";

            while (stmt->next != nullptr)
            {
                stmt = stmt->next;
                cerr << "--> Node: " << stmt->id << "\n"; 
                if (stmt->jump != nullptr){
                    cerr << "   >> JUMP TO " << stmt->jump->id;
                }
                if (stmt->expr != nullptr){
                    cerr << "   >> EXPRESSION\n";
                    cerr << "      ------ OP TREE ------\n";
                    op_tree * expr = stmt->expr;
                    postorder(expr);
                    cerr << "      ---------------------\n";
                }
                cerr << "\n";
            }
        }
    } 
    cerr << "#####################################\n";   
}

void tree::postorder (op_tree * node)
{
    if(node->left != nullptr)
        tree::postorder(node->left);
        
    if(node->right != nullptr) 
        tree::postorder(node->right);

    cerr << "      " << node->entry.id << "\n";
}

/********************************************************/

optree::optree() {}

op_tree * optree::new_op_tree(ast_expr expr, op_tree * l, op_tree * r) 
{
    op_tree * new_op_tree = new op_tree;
    new_op_tree->entry = expr;
    new_op_tree->left = l;
    new_op_tree->right = r;
    return new_op_tree;
}

ast_expr optree::new_ast_expr(int type, string id, int stl, int val) 
{
    ast_expr expr;
    expr.type = type;
    expr.id = id;
    expr.stl = stl;
    expr.val = val;
    return expr;
}

