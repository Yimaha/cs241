#include <iostream>
#include <fstream>
#include <map>
#include <vector>
#include <string>
#include <sstream>
#include <iterator>
#include <stack>


typedef std::vector<std::string> Signature;
typedef std::map<std::string, std::pair<std::string, int>> VariableTable;
typedef std::map<std::string, std::pair<Signature, VariableTable>> ProcedureTable;


class Tree
{
private:
    std::string cacheType;

public:
    std::string rule;
    std::string lhs, kind;
    std::string rhs, lexeme;
    std::vector<std::string> tokens;
    std::vector<Tree> children;
    Tree &child(const std::string &name, int occurrence = 1);
    std::string getType(); // get the type of the
};

class SymbolTable
{
private:
    ProcedureTable procedureTable;
public:
    bool isAccessibleVariable(const std::string &name);
    bool isAccessibleProcedure(const std::string &name);
    void addVariable(Tree &tree);
    void addProcedure(Tree &tree);
    std::string lookupVariable(const std::string &name);
    int lookupVariableOffset(const std::string &name);
    Signature lookupProcedure(const std::string &name);
    VariableTable lookupVariableTable(const std::string &name);
    void printProcedure(const std::string &name);
    void printTable();
};
