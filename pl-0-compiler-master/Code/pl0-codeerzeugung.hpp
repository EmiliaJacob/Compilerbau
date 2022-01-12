#ifndef CODEERZEUGUNG_H
#define CODEERZEUGUNG_H
#include "pl0-zwischencode.hpp"
#include "y.tab.hpp"
#include <vector>
#include <string>
#include <memory>
#include <iostream>
#include <fstream>
using namespace std;

class codeerzeugung{
    public:
        codeerzeugung();
        void generate(vector<ast_entry> _ast);
        void assemble_statement(ast_stmt * _stmt);
        void assemble_expression(op_tree * _expr, int label = 0);
        void exp_postorder(op_tree * _op);
        void ram_up();
        void ram_down();
        void ram_var_adr(int stl, int val);
        void emit(string label, string cmd, string parameter = "", string kommentar = "");

    private:
        zwischencode zc;
        vector<ast_entry> ast;
        ofstream of;
        
};
#endif