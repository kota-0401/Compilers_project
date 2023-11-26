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
