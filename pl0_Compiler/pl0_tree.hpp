#include <iostream>
#include <string>
#include <vector>

using namespace std;

enum {stmt_end, stmt_assign, stmt_call, stmt_read, stmt_write,
        stmt_debug, stmt_jump_false, stmt_nop, stmt_jump};

typedef struct 
{
    int type;
    string id;
    int stl;
    int val;
} ast_expr;

struct op_tree 
{
    ast_expr entry;
    op_tree * left;
    op_tree * right;
};

struct ast_stmt 
{
    int type;
    string id;
    int stl;
    int val;
    op_tree * expr;
    ast_stmt * next;
    ast_stmt * jump; 
};

typedef struct 
{
    ast_stmt *start;
    string name;
    int n_var;
} ast_entry;

class tree 
{
    public:
        tree();
        vector<ast_entry> ast_list;
        vector<int> levels;
        vector<ast_stmt *> nops;
        ast_stmt * new_ast_stmt(int type, string id = NULL, int stl = -1, int val = -1, ast_stmt * next = NULL, ast_stmt * jump = NULL);
        void new_ast_level(string name);
        void new_assign(string id, op_tree * expr, int stl = -1, int val = -1);
        void new_call(string id = NULL, int stl = -1, int val = -1);
        void new_read(string id = NULL, int stl = -1, int val = -1);
        void new_write(op_tree * expr);
        void new_if(op_tree * op);
        void end_if();
        void new_while(op_tree * op);
        void end_while();
        void new_end();
        void add_to_ast_list(ast_stmt *);
        void level_down();
        void add_var();
        vector<ast_entry> get_ast_list();
        void print();
        void print_op(ast_stmt * dummy);
        void postorder (op_tree * node);
};

class optree 
{
    public:
        optree();
        op_tree * new_op_tree(ast_expr entry, op_tree * l = NULL, op_tree * r = NULL);
        ast_expr new_ast_expr(int type, string id, int stl = -1, int val = -1);
};