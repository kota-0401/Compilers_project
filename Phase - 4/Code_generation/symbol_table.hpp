#include <bits/stdc++.h>
using namespace std;

extern char* yytext;

struct typerec {
    string name;
    int scope;
    string type;
    string eletype;
    int no_of_dim;
};

struct param {
    string name;
    string eletype;
};

struct f_unique {
    string name;
    vector<param> param_list;
    string return_type;
    string return_eletype;
    bool is_defined;
};

vector<f_unique> function_table;
vector<vector<typerec>> local_symbol_table(1);

vector<param> param_list;
vector<string> call_arg_list;
int scope = 0;
int add_function_value = 0;
int no_of_dim = 0;
string eletype = "";
string type = "simple";

void create_symbol_table() {
    vector<typerec> new_table;  // Create a new empty symbol table
    local_symbol_table.push_back(new_table);  // Add the new symbol table to the vector
    scope++;
}

void delete_symbol_table() {
    local_symbol_table.pop_back();  // Remove the last symbol table
    scope--;
}

string check_type_eletype(string name) {
    for (int i = 0; i < function_table.size(); i++) {
        if (function_table[i].name == name) {
            if(function_table[i].param_list.size() == call_arg_list.size()) {
                for (int j = 0; j < call_arg_list.size(); j++) {
                    if (function_table[i].param_list[j].eletype != call_arg_list[j]) {
                        break;
                    }
                }
                return function_table[i].return_eletype;
            }
        }
    }
    return "not_found";
}

bool type_checking(string from_type, string to_type) {
    // Define a set of valid type conversions for each type
    unordered_set<string> valid_conversions;

    if (from_type == "int") {
        valid_conversions = {"int", "float", "bool","char"};
    } 
    else if (from_type == "float") {
        valid_conversions = {"float", "int", "bool", "char"};
    } 
    else if (from_type == "string") {
        valid_conversions = {"string"};
    } 
    else if (from_type == "bool") {
        valid_conversions = {"bool", "int", "float", "char"};
    }
    else if (from_type == "char") {
        valid_conversions = {"char", "bool", "int", "float"};
    }
    else if (from_type == "point") {
        valid_conversions = {"point"};
    }
    else if (from_type == "line") {
        valid_conversions = {"line", "line_circle"};
    }
    else if (from_type == "circle") {
        valid_conversions = {"circle", "line_circle"};
    }
    else if (from_type == "parabola") {
        valid_conversions = {"parabola"};
    }
    else if (from_type == "ellipse") {
        valid_conversions = {"ellipse", "ellipse_hyperbola"};
    }
    else if (from_type == "hyperbola") {
        valid_conversions = {"hyperbola", "ellipse_hyperbola"};
    } 
    return valid_conversions.find(to_type) != valid_conversions.end();
}

char* string_to_char(string str){
    char* c = new char(str.length() + 1);
    strcpy(c,str.c_str());
    return c;
}

string charptr_to_string(const char* charPointer) {
    if (charPointer) {
        return string(charPointer);
    } else {
        // Handle the case where charPointer is nullptr
        return string();
    }
}
