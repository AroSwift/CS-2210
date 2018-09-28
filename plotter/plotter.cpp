#include <iostream>
#include <fstream>
#include <vector>
#include <cstring>

#include <map>
#include <sstream>
#include <string>

#include "plotter.h"
using namespace std;

extern "C" { int setSize (int x, int y); }
extern "C" { int clear(); }
extern "C" { int setBkgndColor (int red, int green, int blue); }
extern "C" { int setDrawColor(int red, int green, int blue); }
extern "C" { int penUp(); }
extern "C" { int penDown(); }
extern "C" { int moveTo (int x, int y); }


// The initial plotter driver routines are available in
// plotterDriver.o (in D2L). Link with this object file to
// access the plotter driver routines.
// Create the following programs:
//
// plotter.cpp - program that runs the interface
// plotterGlue.asm - subroutines that manipulate the
// calling parameters into the correct form for plotterDriver.o
// Also create a makefile for the project and include this
// file (for a total of 3) in the dropbox for this assignment.
//
// I also updated the instructions for the assignment to
// note that all routines return a status (an int) of 1
// if all went well or 0 if the routine could not process
// the parameters passed in. Be sure to set up the size of
// the surface before issuing other commands. This isn't
// enforced in the initial version of the library, but
// will be in the "real" library used to draw.



int main() {
  ifstream input;

  // Show main menu
  main_menu(input);

  vector <Command*> commands;

  char input_char;
  string line = "";
  bool getting_command = true;
  while(input.get(input_char)) {
    if(input_char != ' ' && input_char != ',' && input_char != '\n') {
      line += input_char;
    } else if(getting_command) {
      Command * command = new Command(line);
      commands.push_back(command);
      getting_command = false;
      cout << "Command: |" << line << "|" << endl;
      line = "";
    } else if(line != "") {
      // command->add_argument(line);
      commands.back()->add_argument(line);
      cout << "Arg: |" << line << "|" << endl;
      line = "";
    }

    if(input_char == '\n') {
      getting_command = true;
      line = "";
    }

  }


  // for(int i = 0; !input.eof(); i++) {
  //   string function_name;
  //   string entire_function_call;
  //   input >> ws;
  //   getline(input, entire_function_call, '\n');
  //
  //
  //   cout << "Function: |" << function_name << "|" << endl;
  //   Command * command = new Command(function_name);
  //
  //   for(int k = 1; k <= command->num_commands(); k++) {
  //     cout << "called" << endl;
  //     string arg;
  //     char stop_char = (k == command->num_commands()) ? '\n' : ',';
  //     input >> ws;
  //     getline(input, arg, stop_char);
  //
  //     cout << arg << endl;
  //     command->add_argument(arg);
  //
  //   }
  // }

  // stringstream input_content;
  // input_content << input.rdbuf(); //read the file
  // // holds the content of the file
  // const char * input_commands = input_content.str().c_str();
  //
  // char input_commands_with_newline[strlen(input_commands) + 1];
  // strcpy(input_commands_with_newline, input_commands);
  //
  // char *p = strtok(input_commands_with_newline, " ");
  // while (p) {
  //   printf ("Token: %s\n", p);
  //   p = strtok(NULL, " \n");
  //   // p.erasep.strchr(',');
  //   // p.replace
  //   // p = strtok(NULL, ",");
  // }


  input.close();

  return 0;
}


//
// main_menu
// Present a menu with options that
// correspond to functions. Continue to
// display menu until user decides to exit.
//
void main_menu(ifstream& input) {
  bool should_exit = false;
  char choice;

  // Display a menu
  do {

    // Give user choices
    cout << "Plotter Main Menu" << endl
    << "----------------------" << endl
    << "1.) Load File" << endl
    << "2.) Enter Command" << endl
    << "3.) Exit" << endl
    << "Choice: ";
    cin >> choice;

    // Associate choice with an action
    switch(choice) {
      case '1': // Load File
        cout << endl;
        get_file(input);
        cout << endl;
        break;

      case '2': // Enter Command
        cout << endl;
        command_main_menu();
        cout << endl;
        break;

      case '3': // Exit program
        should_exit = true;
        break;

      default: // Error occured
        cout << "Please enter a valid option." << endl;
        break;
    }

  } while(!should_exit);
}

void command_main_menu() {
  bool should_exit = false;
  char choice;

  // Display a menu
  do {

    // Give user choices
    cout << "Command Menu" << endl
    << "----------------------" << endl
    << "1.) Load File" << endl
    << "2.) Enter Command" << endl
    << "3.) Exit" << endl
    << "Choice: ";
    cin >> choice;

    // Associate choice with an action
    switch(choice) {
      case '1': // Load File
        cout << endl;
        // get_file(input);
        cout << endl;
        break;

      case '2': // Enter Command
        cout << endl;
        cout << endl;
        break;

      case '3': // Exit program
        should_exit = true;
        break;

      default: // Error occured
        cout << "Please enter a valid option." << endl;
        break;
    }

  } while(!should_exit);
}


void get_file( ifstream& input ) {
  char filename[MAX_FILE_LENGTH];
  bool file_errors;

  do { // Find a file that exists
    file_errors = false;

    // Prompt for file and read it in
    cout << "Enter file name: ";
    // Clear buffer so we can read
    cin.ignore();
    cin.getline( filename, MAX_FILE_LENGTH );

    input.open( filename );

    // When file could not be found
    if( input.fail() ) {
      cout << "Input file " << filename << " does not exist. \n";
      file_errors = true;

    // When file is empty
    } else if( input.peek() == EOF ) {
      cout << "Input file " << filename << " is empty. \n";
      file_errors = true;
    }

  } while( file_errors );

}


Command::Command(string function_name) {
  this->function_name = function_name;

  map<string, int>::iterator c = command_map.find(this->function_name);

  if( c == command_map.end() ) {
    // cout << this->function_name << " is an invalid command." << endl;
    this->valid_command = false;
    this->num_parameters = 0;
  } else {
    this->num_parameters = c->second;
    this->valid_command = true;
  }
}

void Command::add_argument(string argument) {
  this->arguments.push_back(argument);
}

int Command::num_commands() {
  return this->num_parameters;
}

void Command::call_command() {

}
