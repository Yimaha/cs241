#include <iostream>
#include <fstream>
#include <map>
#include <vector>
#include <string>
#include <sstream>
#include <iterator>
#include <stack>
#include <set>

#include "wlp4gen.h"

SymbolTable symbolTable;
std::string currentProcedure = "";
int currentVariableCounter = 0;
int whileCounter = 0;
int ifCounter = 0;
int deleteCounter = 0;
std::string r_0 = "$0";
std::string r_param_1 = "$1";
std::string r_param_2 = "$2";
std::string r_output = "$3";
std::string r_4 = "$4";
std::string r_intermediate = "$5";
std::string r_temp_1 = "$6";
std::string r_temp_2 = "$7";
std::string r_new = "$8";
std::string r_delete = "$9";
std::string r_print = "$10";
std::string r_1 = "$11";
std::string r_frame_pointer = "$29";
std::string r_stack_pointer = "$30";
std::string r_return_address = "$31";
/*
    determine if the current symbol is a terminal symbol
*/
bool isTerminal(std::string &symbol)
{
    if ('A' <= symbol[0] && symbol[0] <= 'Z')
    {
        return true;
    }
    else
    {
        return false;
    }
}

/**
     * utiliy function
     */
bool contains(const std::vector<std::string> &array, const std::string &target)
{
    for (int i = 1; i < array.size(); i++)
    {
        if (array[i] == target)
        {
            return true;
        }
    }
    return false;
}

// code generation utilities

void printAdd(const std::string &result, const std::string &a, const std::string &b)
{
    std::cout << "add " << result << ", " << a << ", " << b << std::endl;
}

void printSub(const std::string &result, const std::string &a, const std::string &b)
{
    std::cout << "sub " << result << ", " << a << ", " << b << std::endl;
}

void printSw(const std::string &reg, int offset, const std::string &address)
{
    std::cout << "sw " << reg << ", " << offset << "(" << address << ")" << std::endl;
}

void printLw(const std::string &reg, int offset, const std::string &address)
{
    std::cout << "lw " << reg << ", " << offset << "(" << address << ")" << std::endl;
}

void printMult(const std::string &a, const std::string &b)
{
    std::cout << "mult " << a << ", " << b << std::endl;
}
void printMultu(const std::string &a, const std::string &b)
{
    std::cout << "multu " << a << ", " << b << std::endl;
}
void printDiv(const std::string &a, const std::string &b)
{
    std::cout << "div " << a << ", " << b << std::endl;
}
void printMfhi(const std::string &reg)
{
    std::cout << "mfhi " << reg << std::endl;
}
void printMflo(const std::string &reg)
{
    std::cout << "mflo " << reg << std::endl;
}

void printSlt(const std::string &d, const std::string &s, const std::string &t)
{
    std::cout << "slt " << d << ", " << s << ", " << t << std::endl;
}
void printSltu(const std::string &d, const std::string &s, const std::string &t)
{
    std::cout << "sltu " << d << ", " << s << ", " << t << std::endl;
}

void printBeq(const std::string &s, const std::string &t, const std::string &i)
{
    std::cout << "beq " << s << ", " << t << ", " << i << std::endl;
}

void printBne(const std::string &s, const std::string &t, const std::string &i)
{
    std::cout << "bne " << s << ", " << t << ", " << i << std::endl;
}

void printLis(const std::string &reg, const std::string &content)
{
    std::cout << "lis " << reg << std::endl;
    std::cout << ".word " << content << std::endl;
}
void printImport(const std::string &libName)
{
    std::cout << ".import " << libName << std::endl;
}

void printLabel(const std::string &label)
{
    std::cout << label << ":" << std::endl;
}

void printReturn()
{
    std::cout << "jr " << r_return_address << std::endl;
}

void printJalr(const std::string &reg)
{
    std::cout << "jalr " << reg << std::endl;
}

void code(const std::string &id)
{
    int n = symbolTable.lookupVariableOffset(id);
    printLw(r_output, n, r_frame_pointer);
}

void push(std::string &reg = r_output)
{
    printSw(reg, -4, r_stack_pointer);
    printSub(r_stack_pointer, r_stack_pointer, r_4);
}

void pop(std::string &reg = r_intermediate)
{
    printAdd(r_stack_pointer, r_stack_pointer, r_4);
    printLw(reg, -4, r_stack_pointer);
}

void call(const std::string &functionName)
{
    push(r_return_address);
    printLis(r_return_address, functionName);
    printJalr(r_return_address);
    pop(r_return_address);
}

void init()
{
    if (symbolTable.lookupProcedure("wain")[0] == "int")
    {
        printLis(r_param_2, "0");
    }
    call("init");
    printLis(r_output, "wain");
    std::cout << "jr " << r_output << std::endl;
}

void initialVariables()
{
    push(r_param_1);
    push(r_param_2);
    init();
}

void printPrologue()
{
    printImport("print");
    printImport("init");
    printImport("new");
    printImport("delete");
    printLis(r_4, "4");
    printLis(r_print, "print");
    printLis(r_1, "1");
    printLis(r_new, "new");
    printLis(r_delete, "delete");
    printSub(r_frame_pointer, r_stack_pointer, r_4);
    initialVariables();
}

void printEpilogue()
{
    printAdd(r_stack_pointer, r_frame_pointer, r_4);
    printReturn();
}
// save all used register into the stack
void pushRegister()
{
    push(r_intermediate);
    push(r_temp_1);
    push(r_temp_2);
}
// restore all used register from stack;
void restoreRegister()
{
    pop(r_temp_2);
    pop(r_temp_1);
    pop(r_intermediate);
}

Tree &Tree::child(const std::string &name, int occurrence)
{
    int counter = occurrence;
    for (Tree &child : children)
    {
        if (child.lhs == name && counter == 1)
        {
            return child;
        }
        if (child.lhs == name)
        {
            counter--;
        }
    }
    throw std::string("ERROR, children " + name + " with occurence " + std::to_string(occurrence) + " don't exist");
}

std::string Tree::getType()
{
    if (cacheType != "")
    {
        return cacheType;
    }
    else
    {
        std::string type = "none";
        if (rule == "dcl type ID")
        {
            type = child("type").getType();
        }
        else if (rule == "type INT")
        {
            type = "int";
        }
        else if (rule == "type INT STAR")
        {
            type = "int*";
        }
        else if (lhs == "ID")
        {
            type = symbolTable.lookupVariable(rhs);
        }
        else if (lhs == "NUM")
        {
            type = "int";
        }
        else if (lhs == "NULL")
        {
            type = "int*";
        }
        else if (lhs == "factor" && (rhs == "ID" || rhs == "NUM" || rhs == "NULL"))
        {
            type = children[0].getType();
        }
        else if (lhs == "lvalue" && rhs == "ID")
        {
            type = child("ID").getType();
        }
        else if (lhs == "factor" && (rhs == "LPAREN expr RPAREN"))
        {
            type = child("expr").getType();
        }
        else if (lhs == "lvalue" && rhs == "LPAREN lvalue RPAREN")
        {
            type = child("lvalue").getType();
        }
        else if (lhs == "factor" && rhs == "AMP lvalue")
        {
            if (child("lvalue").getType() != "int")
            {
                throw std::string("ERROR, invalid derivation of AMP lvalue");
            }
            type = "int*";
        }
        else if ((lhs == "factor" || lhs == "lvalue") && rhs == "STAR factor")
        {
            type = "int";
            if (child("factor").getType() != "int*")
            {
                throw std::string("ERROR, invalid derivation of STAR lvalue");
            }
        }
        else if (lhs == "factor" && rhs == "NEW INT LBRACK expr RBRACK")
        {
            if (child("expr").getType() != "int")
            {
                throw std::string("ERROR, invalid derivation of NEW INT LBRACK expr RBRACK");
            }
            type = "int*";
        }
        else if (lhs == "factor" && rhs == "ID LPAREN RPAREN")
        {
            type = "int";
            if (symbolTable.lookupProcedure(child("ID").rhs).size() != 0)
            {
                throw std::string("ERROR, non empty signature");
            }
        }
        else if (lhs == "factor" && rhs == "ID LPAREN arglist RPAREN")
        {
            Signature signature = symbolTable.lookupProcedure(child("ID").rhs);
            Tree arglist;
            auto i = 0;
            while (i < signature.size())
            {
                if (i == 0)
                {
                    arglist = child("arglist");
                }
                else
                {
                    arglist = arglist.child("arglist");
                }
                if (!contains(arglist.tokens, "arglist") && i + 1 != signature.size())
                {
                    throw std::string("ERROR, not enought parameter passed");
                }
                std::string argtype = arglist.child("expr").getType();
                std::string argtypeReal = signature[i];
                if (argtype != argtypeReal)
                {
                    throw std::string("ERROR, non matching parameter found");
                }
                i++;
            }
            if (contains(arglist.tokens, "arglist"))
            {
                throw std::string("ERROR, too many parameter passed");
            }
            type = "int";
        }
        else if (lhs == "term" && rhs == "factor")
        {
            type = child("factor").getType();
        }
        else if (lhs == "term")
        {
            type = "int";
            if (child("term").getType() != "int" || child("factor").getType() != "int")
            {
                throw std::string("ERROR, term and factor dervied is not int");
            }
        }
        else if (lhs == "expr" && rhs == "term")
        {
            type = child("term").getType();
        }
        else if (rule == "expr expr PLUS term")
        {
            if (child("expr").getType() == "int" && child("term").getType() == "int")
            {
                type = "int";
            }
            else if (child("expr").getType() == "int" && child("term").getType() == "int*")
            {
                type = "int*";
            }
            else if (child("expr").getType() == "int*" && child("term").getType() == "int")
            {
                type = "int*";
            }
            else
            {
                throw std::string("ERROR, invalid use of PLUS");
            }
        }
        else if (rule == "expr expr MINUS term")
        {
            if (child("expr").getType() == "int" && child("term").getType() == "int")
            {
                type = "int";
            }
            else if (child("expr").getType() == "int*" && child("term").getType() == "int")
            {
                type = "int*";
            }
            else if (child("expr").getType() == "int*" && child("term").getType() == "int*")
            {
                type = "int";
            }
            else
            {
                throw std::string("ERROR, invalid use of MINUS");
            }
        }
        cacheType = type;
        return type;
    }
}

bool SymbolTable::isAccessibleVariable(const std::string &name)
{
    return procedureTable[currentProcedure].second.count(name) == 1;
}

bool SymbolTable::isAccessibleProcedure(const std::string &name)
{
    return procedureTable[currentProcedure].second.count(name) != 1 && procedureTable.count(name) == 1;
}

void SymbolTable::addVariable(Tree &tree)
{
    if (isAccessibleVariable(tree.child("ID").rhs))
    {
        throw std::string("ERROR, variable with ID: " + tree.rhs + " has already been declared");
    }
    procedureTable[currentProcedure].second[tree.child("ID").rhs].first = tree.getType();
    int variable_offset = currentVariableCounter * 4;
    if (currentProcedure != "wain")
    {
        variable_offset += procedureTable[currentProcedure].first.size() * 4;
    }
    procedureTable[currentProcedure].second[tree.child("ID").rhs].second = variable_offset;
    currentVariableCounter--;
}

void SymbolTable::addProcedure(Tree &tree)
{
    currentVariableCounter = 0;
    if (tree.lhs == "main")
    {
        currentProcedure = "wain";
    }
    else
    {
        currentProcedure = tree.child("ID").rhs;
    }

    if (procedureTable.count(currentProcedure) == 1)
    {
        throw std::string("ERROR, procedure " + currentProcedure + " has already been declared");
    }
    Signature new_signature;
    VariableTable new_variable_table;
    procedureTable[currentProcedure] = std::make_pair(new_signature, new_variable_table);
    if (tree.lhs == "main")
    {
        procedureTable[currentProcedure].first.push_back(tree.child("dcl").getType());
        procedureTable[currentProcedure].first.push_back(tree.child("dcl", 2).getType());
    }
    else
    {
        Tree params = tree.child("params");
        if (contains(params.tokens, "paramlist"))
        {
            Tree paramlist = params.child("paramlist");
            while (contains(paramlist.tokens, "paramlist"))
            {
                procedureTable[currentProcedure].first.push_back(paramlist.child("dcl").getType());
                paramlist = paramlist.child("paramlist");
            }
            procedureTable[currentProcedure].first.push_back(paramlist.child("dcl").getType());
        }
    }
}

std::string SymbolTable::lookupVariable(const std::string &name)
{
    if (procedureTable[currentProcedure].second.count(name) == 1)
    {
        return procedureTable[currentProcedure].second[name].first;
    }
    else
    {
        return "";
    }
}

int SymbolTable::lookupVariableOffset(const std::string &name)
{
    int offset = procedureTable[currentProcedure].second[name].second;
    return offset;
}

Signature SymbolTable::lookupProcedure(const std::string &name)
{
    return procedureTable[name].first;
}

VariableTable SymbolTable::lookupVariableTable(const std::string &name)
{
    return procedureTable[name].second;
}

void SymbolTable::printProcedure(const std::string &name)
{
    std::cerr << name << " ";
    for (int i = 0; i < procedureTable[name].first.size(); i++)
    {
        std::cerr << procedureTable[name].first[i];
        if (i != procedureTable[name].first.size() - 1)
        {
            std::cerr << " ";
        }
    }
    std::cerr << std::endl;
    for (auto variable : procedureTable[name].second)
    {
        std::cerr << variable.first << " " << variable.second.first << " " << variable.second.second << std::endl;
    }
    std::cerr << std::endl;
}

void SymbolTable::printTable()
{
    for (auto procedure : procedureTable)
    {
        printProcedure(procedure.first);
    }
}

Tree recursiveConstructTree()
{
    Tree tree;
    std::string word;
    std::getline(std::cin, tree.rule);

    std::istringstream stream(tree.rule);
    stream >> word; // while reading the left hand side
    tree.lhs = word;
    tree.tokens.push_back(word);

    while (stream >> word)
    {
        tree.rhs += word;
        if (!stream.eof())
            tree.rhs += " ";
        tree.tokens.push_back(word);
        if (!isTerminal(tree.lhs))
        {
            tree.children.push_back(recursiveConstructTree());
        }
    }
    return tree;
}

void recursiveConstructSymbolTable(Tree &tree)
{
    if (tree.lhs == "main")
    {
        symbolTable.addProcedure(tree);
    }
    else if (tree.lhs == "procedure")
    {
        symbolTable.addProcedure(tree);
    }
    else if (tree.rule == "dcl type ID")
    {
        symbolTable.addVariable(tree);
    }
    else if (tree.rule == "factor ID" || tree.rule == "lvalue ID")
    {
        Tree &id = tree.child("ID");
        if (!symbolTable.isAccessibleVariable(id.rhs))
        {
            throw std::string("ERROR, unaccessable variable: " + id.rhs);
        }
    }
    else if (tree.rule == "factor ID LPAREN RPAREN" || tree.rule == "factor ID LPAREN arglist RPAREN")
    {
        Tree &procedureId = tree.child("ID");
        if (!symbolTable.isAccessibleProcedure(procedureId.rhs))
        {
            throw std::string("ERROR, unaccessable procedure " + procedureId.rhs);
        }
    }
    for (auto &child : tree.children)
    {
        recursiveConstructSymbolTable(child);
    }
}

// given a valid symbol table and a valid tree
void recursiveTraverseTree(Tree &tree)
{
    if (tree.lhs == "start")
    {
        recursiveTraverseTree(tree.child("procedures"));
    }
    else if (tree.lhs == "procedures" || tree.lhs == "statements")
    {
        for (auto &child : tree.children)
        {
            recursiveTraverseTree(child);
        }
    }
    else if (tree.lhs == "main")
    {
        currentProcedure = "wain";
        if (tree.child("dcl", 2).getType() != "int")
        {
            throw std::string("ERROR, parameter b is not an int");
        }
        if (tree.child("expr").getType() != "int")
        {
            throw std::string("ERROR, the expression doesn return an int from wain");
        }
        recursiveTraverseTree(tree.child("dcls"));
        recursiveTraverseTree(tree.child("statements"));
    }
    else if (tree.lhs == "procedure")
    {
        currentProcedure = tree.child("ID").rhs;
        if (tree.child("expr").getType() != "int")
        {
            throw std::string("ERROR, the expression doesn return an int");
        }
        recursiveTraverseTree(tree.child("dcls"));
        recursiveTraverseTree(tree.child("statements"));
    }
    else if (tree.rule == "statement lvalue BECOMES expr SEMI")
    {
        if (tree.child("lvalue").getType() != tree.child("expr").getType())
        {
            throw std::string("ERROR, invalid assignment");
        }
    }
    else if (tree.rule == "statement PRINTLN LPAREN expr RPAREN SEMI")
    {
        if (tree.child("expr").getType() != "int")
        {
            throw std::string("ERROR, invalid print usage");
        }
    }
    else if (tree.rule == "statement DELETE LBRACK RBRACK expr SEMI")
    {
        if (tree.child("expr").getType() != "int*")
        {
            throw std::string("ERROR, invalid delete[] usage");
        }
    }
    else if (tree.rule == "statement IF LPAREN test RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE")
    {
        recursiveTraverseTree(tree.child("test"));
        recursiveTraverseTree(tree.child("statements"));
        recursiveTraverseTree(tree.child("statements", 2));
    }
    else if (tree.rule == "statement WHILE LPAREN test RPAREN LBRACE statements RBRACE")
    {
        recursiveTraverseTree(tree.child("test"));
        recursiveTraverseTree(tree.child("statements"));;
    }
    else if (tree.lhs == "test")
    {
        if (tree.child("expr", 1).getType() != tree.child("expr", 2).getType())
        {
            throw std::string("ERROR, invalid comparison usage");
        }
    }
    else if (tree.rule == "dcls dcls dcl BECOMES NUM SEMI")
    {
        if (tree.child("dcl").getType() != "int")
        {
            throw std::string("ERROR, assigning NUM to inavlid datatype");
        }
        recursiveTraverseTree(tree.child("dcls"));
    }
    else if (tree.rule == "dcls dcls dcl BECOMES NULL SEMI")
    {
        if (tree.child("dcl").getType() != "int*")
        {
            throw std::string("ERROR, assigning NULL to inavlid datatype");
        }
        recursiveTraverseTree(tree.child("dcls"));
    }
}

void recursiveGenerateCode(Tree &tree)
{
    if (tree.rule == "start BOF procedures EOF")
    {
        recursiveGenerateCode(tree.child("procedures"));
    }
    else if (tree.rule == "procedures procedure procedures")
    {
        recursiveGenerateCode(tree.child("procedure"));
        recursiveGenerateCode(tree.child("procedures"));
    }
    else if (tree.rule == "procedure INT ID LPAREN params RPAREN LBRACE dcls statements RETURN expr SEMI RBRACE")
    {
        currentProcedure = tree.child("ID").rhs;
        std::string id = "F" + tree.child("ID").rhs;
        printLabel(id);
        printSub(r_frame_pointer, r_stack_pointer, r_4);
        recursiveGenerateCode(tree.child("dcls"));
        pushRegister();
        recursiveGenerateCode(tree.child("statements"));
        recursiveGenerateCode(tree.child("expr"));
        restoreRegister();
        printAdd(r_stack_pointer, r_frame_pointer, r_4);
        printReturn();
    }
    else if (tree.rule == "factor ID LPAREN RPAREN")
    {
        push(r_frame_pointer);
        call("F" + tree.child("ID").rhs);
        pop(r_frame_pointer);
    }
    else if (tree.rule == "factor ID LPAREN arglist RPAREN")
    {
        push(r_frame_pointer);
        push(r_return_address);
        Tree arglist = tree.child("arglist");
        size_t pushCounter = 1;
        while (arglist.rule != "arglist expr")
        {
            recursiveGenerateCode(arglist.child("expr"));
            push();
            arglist = arglist.child("arglist");
            pushCounter++;
        }
        recursiveGenerateCode(arglist.child("expr"));
        push();
        printLis(r_return_address, "F" + tree.child("ID").rhs);
        printJalr(r_return_address);
        for (size_t i = 0; i < pushCounter; i++)
        {
            pop();
        }
        pop(r_return_address);
        pop(r_frame_pointer);
    }
    else if (tree.rule == "procedures main")
    {
        recursiveGenerateCode(tree.child("main"));
    }
    else if (tree.rule == "main INT WAIN LPAREN dcl COMMA dcl RPAREN LBRACE dcls statements RETURN expr SEMI RBRACE")
    {
        currentProcedure = "wain";
        printLabel("wain");
        recursiveGenerateCode(tree.child("dcls"));
        recursiveGenerateCode(tree.child("statements"));
        recursiveGenerateCode(tree.child("expr"));
    }
    else if (tree.rule == "expr term")
    {
        recursiveGenerateCode(tree.child("term"));
    }
    else if (tree.rule == "term factor")
    {
        recursiveGenerateCode(tree.child("factor"));
    }
    else if (tree.rule == "factor ID")
    {
        std::string id = tree.child("ID").rhs;
        code(id);
    }
    else if (tree.rule == "factor LPAREN expr RPAREN")
    {
        recursiveGenerateCode(tree.child("expr"));
    }
    else if (tree.rule == "expr expr PLUS term")
    {
        std::string exprType = tree.child("expr").getType();
        std::string termType = tree.child("term").getType();
        if (exprType == "int" && termType == "int")
        {
            recursiveGenerateCode(tree.child("expr"));
            push();
            recursiveGenerateCode(tree.child("term"));
            pop();
            printAdd(r_output, r_intermediate, r_output);
        }
        else if (exprType == "int*" && termType == "int")
        {
            recursiveGenerateCode(tree.child("expr"));
            push();
            recursiveGenerateCode(tree.child("term"));
            printMult(r_output, r_4);
            printMflo(r_output);
            pop();
            printAdd(r_output, r_intermediate, r_output);
        }
        else if (exprType == "int" && termType == "int*")
        {
            recursiveGenerateCode(tree.child("expr"));
            printMult(r_output, r_4);
            printMflo(r_output);
            push();
            recursiveGenerateCode(tree.child("term"));
            pop();
            printAdd(r_output, r_intermediate, r_output);
        }
    }
    else if (tree.rule == "expr expr MINUS term")
    {
        std::string exprType = tree.child("expr").getType();
        std::string termType = tree.child("term").getType();
        if (exprType == "int" && termType == "int")
        {
            recursiveGenerateCode(tree.child("expr"));
            push();
            recursiveGenerateCode(tree.child("term"));
            pop();
            printSub(r_output, r_intermediate, r_output);
        }
        else if (exprType == "int*" && termType == "int")
        {
            recursiveGenerateCode(tree.child("expr"));
            push();
            recursiveGenerateCode(tree.child("term"));
            printMult(r_output, r_4);
            printMflo(r_output);
            pop();
            printSub(r_output, r_intermediate, r_output);
        }
        else if (exprType == "int*" && termType == "int*")
        {
            recursiveGenerateCode(tree.child("expr"));
            push();
            recursiveGenerateCode(tree.child("term"));
            pop();
            printSub(r_output, r_intermediate, r_output);
            printDiv(r_output, r_4);
            printMflo(r_output);
        }
    }
    else if (tree.rule == "term term STAR factor")
    {
        recursiveGenerateCode(tree.child("term"));
        push();
        recursiveGenerateCode(tree.child("factor"));
        pop();
        printMult(r_output, r_intermediate);
        printMflo(r_output);
    }
    else if (tree.rule == "term term SLASH factor")
    {
        recursiveGenerateCode(tree.child("term"));
        push();
        recursiveGenerateCode(tree.child("factor"));
        pop();
        printDiv(r_intermediate, r_output);
        printMflo(r_output);
    }
    else if (tree.rule == "term term PCT factor")
    {
        recursiveGenerateCode(tree.child("term"));
        push();
        recursiveGenerateCode(tree.child("factor"));
        pop();
        printDiv(r_intermediate, r_output);
        printMfhi(r_output);
    }
    else if (tree.rule == "factor NUM")
    {
        std::string number = tree.child("NUM").rhs;
        printLis(r_output, number);
    }
    else if (tree.rule == "statements statements statement")
    {
        recursiveGenerateCode(tree.child("statements"));
        recursiveGenerateCode(tree.child("statement"));
    }
    else if (tree.rule == "statement PRINTLN LPAREN expr RPAREN SEMI")
    {
        push(r_param_1);
        recursiveGenerateCode(tree.child("expr"));
        printAdd(r_param_1, r_output, r_0);
        push(r_return_address);
        printJalr(r_print);
        pop(r_return_address);
        pop(r_param_1);
    }
    else if (tree.rule == "dcls dcls dcl BECOMES NUM SEMI")
    {
        recursiveGenerateCode(tree.child("dcls"));
        std::string id = tree.child("NUM").rhs;
        printLis(r_output, id);
        push();
    }
    else if (tree.rule == "dcls dcls dcl BECOMES NULL SEMI")
    {
        recursiveGenerateCode(tree.child("dcls"));
        printLis(r_output, "1");
        push();
    }
    else if (tree.rule == "statement lvalue BECOMES expr SEMI")
    {
        recursiveGenerateCode(tree.child("expr"));
        Tree lvalue = tree.child("lvalue");
        while (lvalue.rule == "lvalue LPAREN lvalue RPAREN")
        {
            lvalue = lvalue.child("lvalue");
        }
        if (lvalue.rule == "lvalue ID")
        {
            std::string id = lvalue.child("ID").rhs;
            int offset = symbolTable.lookupVariableOffset(id);
            printSw(r_output, offset, r_frame_pointer);
        }
        if (lvalue.rule == "lvalue STAR factor")
        {
            push();
            recursiveGenerateCode(lvalue.child("factor"));
            pop();
            printSw(r_intermediate, 0, r_output);
        }
    }
    else if (tree.lhs == "test")
    {
        std::string type = tree.child("expr").getType();
        recursiveGenerateCode(tree.child("expr"));
        push();
        recursiveGenerateCode(tree.child("expr", 2));
        pop();
        if (tree.rule == "test expr LT expr" || tree.rule == "test expr GE expr")
        {
            if (type == "int")
            {
                printSlt(r_output, r_intermediate, r_output);
            }
            else
            {
                printSltu(r_output, r_intermediate, r_output);
            }
            if (tree.rule == "test expr GE expr")
            {
                printSub(r_output, r_1, r_output);
            }
        }
        if (tree.rule == "test expr EQ expr" || tree.rule == "test expr NE expr")
        {
            if (type == "int")
            {
                printSlt(r_temp_1, r_output, r_intermediate);
                printSlt(r_temp_2, r_intermediate, r_output);
            }
            else
            {
                printSltu(r_temp_1, r_output, r_intermediate);
                printSltu(r_temp_2, r_intermediate, r_output);
            }

            printAdd(r_output, r_temp_1, r_temp_2);
            if (tree.rule == "test expr EQ expr")
            {
                printSub(r_output, r_1, r_output);
            }
        }
        if (tree.rule == "test expr LE expr" || tree.rule == "test expr GT expr")
        {
            if (type == "int")
            {
                printSlt(r_output, r_output, r_intermediate);
            }
            else
            {
                printSltu(r_output, r_output, r_intermediate);
            }
            if (tree.rule == "test expr LE expr")
            {
                printSub(r_output, r_1, r_output);
            }
        }
    }
    else if (tree.rule == "statement WHILE LPAREN test RPAREN LBRACE statements RBRACE")
    {
        int currentWhileCounter = whileCounter;
        whileCounter = whileCounter + 1;
        std::string label_top = "loop" + std::to_string(currentWhileCounter);
        std::string label_bottom = "endWhile" + std::to_string(currentWhileCounter);
        printLabel(label_top);
        recursiveGenerateCode(tree.child("test"));
        printBeq(r_output, r_0, label_bottom);
        recursiveGenerateCode(tree.child("statements"));
        printBeq(r_0, r_0, label_top);
        printLabel(label_bottom);
    }
    else if (tree.rule == "statement IF LPAREN test RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE")
    {
        int currentIfCounter = ifCounter;
        ifCounter = ifCounter + 1;
        std::string elseLabel = "else" + std::to_string(currentIfCounter);
        std::string endifLable = "endif" + std::to_string(currentIfCounter);
        recursiveGenerateCode(tree.child("test"));
        printBeq(r_output, r_0, elseLabel);
        recursiveGenerateCode(tree.child("statements"));
        printBeq(r_0, r_0, endifLable);
        printLabel(elseLabel);
        recursiveGenerateCode(tree.child("statements", 2));
        printLabel(endifLable);
    }
    else if (tree.rule == "factor NULL")
    {
        printAdd(r_output, r_0, r_1);
    }
    else if (tree.rule == "factor AMP lvalue")
    {
        Tree lvalue = tree.child("lvalue");
        while (lvalue.rule == "lvalue LPAREN lvalue RPAREN")
        {
            lvalue = lvalue.child("lvalue");
        }
        if (lvalue.rhs == "ID")
        {
            std::string id = lvalue.child("ID").rhs;
            int offset = symbolTable.lookupVariableOffset(id);
            printLis(r_output, std::to_string(offset));
            printAdd(r_output, r_output, r_frame_pointer);
        }
        else if (lvalue.rhs == "STAR factor")
        {
            recursiveGenerateCode(lvalue.child("factor"));
        }
    }
    else if (tree.rule == "factor STAR factor")
    {
        recursiveGenerateCode(tree.child("factor"));
        printLw(r_output, 0, r_output);
    }
    else if (tree.rule == "factor NEW INT LBRACK expr RBRACK")
    {
        recursiveGenerateCode(tree.child("expr"));
        printAdd(r_param_1, r_output, r_0);
        push(r_return_address);
        printJalr(r_new);
        pop(r_return_address);
        printBne(r_output, r_0, "1");
        printAdd(r_output, r_1, r_0);
    }
    else if (tree.rule == "statement DELETE LBRACK RBRACK expr SEMI")
    {
        int currentDeleteCounter = deleteCounter;
        deleteCounter = deleteCounter + 1;
        std::string deleteLabel = "skipDelete" + std::to_string(currentDeleteCounter);
        recursiveGenerateCode(tree.child("expr"));
        printBeq(r_output, r_1, deleteLabel);
        printAdd(r_param_1, r_output, r_0);
        push(r_return_address);
        printJalr(r_delete);
        pop(r_return_address);
        printLabel(deleteLabel);
    }
}

int main()
{
    try
    {
        Tree tree = recursiveConstructTree();
        recursiveConstructSymbolTable(tree);
        recursiveTraverseTree(tree);
        printPrologue();
        recursiveGenerateCode(tree);
        printEpilogue();
    }
    catch (const std::string &ERROR)
    {
        std::cerr << ERROR << std::endl;
    }
}
