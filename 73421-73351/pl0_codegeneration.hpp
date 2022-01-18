#include <iostream>
#include <string>
#include <vector>
#include <fstream>

#include "pl0_tree.hpp"
#include "y.tab.hpp"

using namespace std;

class codegeneration 
{
    private:
        tree T;
        vector<ast_entry> ast;
        ofstream of;

    public:
        codegeneration();
        void generate(vector<ast_entry> _ast);
        void aassemble_stmt(ast_stmt * _stmt);
        void aassemble_expr(op_tree * _expr, int nr = 0);
        void expr_postorder(op_tree * op);
        void ram_up();
        void ram_down();
        void ram_var_adr(string id, int stl, int val);
        void emit(string _nr, string cmd, string arg = "", string comment = "");
};