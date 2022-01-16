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

    for (int i = 0; i < astSize; i++) 
    {
        if (ast[i].start != nullptr) 
        {
            ast_stmt * stmt = ast[i].start;

            if (i > 0) 
            {
                of << "\n";
                emit(to_string(i), "nop", "", "# " + ast[i].name);
            }
            else
            {
                emit("", "loadc", "0");
                emit("", "dup");
                emit("", "storer", "0");
            }
            emit("", "loadc", to_string(ast[i].n_var));
            emit("", "call", "RAM_UP");

            bool go_on;
            if (stmt->type != stmt_end)
                go_on = true;
            else 
                go_on = false;
            
            while(go_on) 
            {
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
    string comment;
    switch(stmt->type)
    {
        case stmt_assign:
            aassemble_expr(stmt->expr);
            ram_var_adr(stmt->stl, stmt->val);
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
            ram_var_adr(stmt->stl, stmt->val);
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
        ram_var_adr(op->entry.stl, op->entry.val);
        emit("", "loads");
        break;
    }
}

void codegeneration::ram_var_adr(int stl, int val)
{
    string comment = "# adr of " + to_string(stl) + "|" + to_string(val);
    emit("", "loadr", "0", comment);
    for (int i = 0; i < stl; i++)
        emit("", "loads");
    emit("", "dec", "2");
    emit("", "dec", to_string(val));
}

void codegeneration::ram_up()
{
    emit("RAM_UP", "loadr", "0");   
    emit("", "add");
    emit("", "inc", "2");
    emit("", "dup");
    emit("", "dec", "1");
    emit("", "loadr", "0");
    emit("", "swap");
    emit("", "stores");
    emit("", "dup");
    emit("", "storer", "0");
    emit("", "stores");
    emit("", "return");
    of << "\n";
}

void codegeneration::ram_down()
{
    emit("RAM_DOWN", "loadr", "0");
    emit("", "dec", "1");
    emit("", "loads");
    emit("", "storer", "0");
    emit("", "return");
    of << "\n";
}

void codegeneration::emit(string nr, string cmd, string arg, string comment)
{
    of << nr << "\t" << cmd << "\t" << arg << "\t" << comment << "\n";
}