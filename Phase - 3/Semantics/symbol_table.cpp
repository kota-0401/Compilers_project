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
