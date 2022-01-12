#ifndef ZWISCHENCODE_H
#define ZWISCHENCODE_H
#include <vector>
#include <string>
#include <memory>
using namespace std;

enum {stmt_end, stmt_assign, stmt_call, stmt_read, stmt_write,
    stmt_debug, stmt_jump_false, stmt_nop, stmt_jump};

typedef struct{
    int type;
    string id;
    int stl;
    int val;
} op_entry;

struct op_tree{
    op_entry entry;
    op_tree * links;
    op_tree * rechts;
};

struct ast_stmt{
    int type;
    string id;
    int stl;
    int val;
    op_tree * expr;
    ast_stmt * next;
    ast_stmt * jump;
};

typedef struct {
    ast_stmt * start;
    string name;
    int n_var;
} ast_entry;


class zwischencode {
    public:
        zwischencode();
        vector<ast_entry> ast;
        vector<int> returnLayers;
        vector<ast_stmt *> Nops;
        ast_stmt * new_ast_stmt(int type, string id = NULL, int stl = -1, int val = -1, ast_stmt * next = NULL, ast_stmt * jump = NULL);
        void new_ast_layer(string name);
        void new_Call_Node(string id = NULL, int stl = -1, int val = -1);
        void new_Eingabe_Node(string id = NULL, int stl = -1, int val = -1);
        void new_Ausgabe_Node(op_tree * _expr);
        void new_Assign_Node(string id, op_tree * _expr, int stl = -1, int val = -1);
        void new_End_Node();
        void new_If_Stmt(op_tree * op); 
        void end_If();
        void new_While_Stmt(op_tree * op); 
        void end_While();
        void to_List(ast_stmt *);
        void layer_Down();
        void add_Var();
        void print();
        void print_op(ast_stmt * dummy);
        void postorder (op_tree * node);
        vector<ast_entry> get_ast();
};

class operatorbaum {
    public:
        operatorbaum();
        op_tree * new_op_tree(op_entry entry, op_tree * l = NULL, op_tree * r = NULL);
        op_entry new_op_entry(int type, string id, int stl = -1, int val = -1);
};

#endif