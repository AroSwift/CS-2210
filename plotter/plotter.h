#pragma once
#include <iostream>
using namespace std;

// Max file length on linux is 255
const int MAX_FILE_LENGTH = 256;
class Command {
  public:
    Command(string function_name);
    void add_argument(string argument);
    int num_commands();
    void call_command();
  private:
    string function_name;
    bool valid_command;
    int num_parameters;
    vector <string> arguments;
};

// Key = name of function
// value = number of arguments for function
map<string, int> command_map = {
  { "size", 2 },
  { "color", 3 },
  { "bkgndColor", 3 },
  { "clear", 0 },
  { "line", 4 },
  { "rect", 4 },
  { "circle", 3 },
  { "triangle", 6 }
};


void main_menu(ifstream& input);
void command_main_menu();
void command_list_menu();
void command_manual_menu();
void get_file(ifstream& input );
