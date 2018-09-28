; Author: Aaron Barlow
; Date: 12/2/2016
; Purpose: Calculate the miles per gallon
;          Given miles and gallons.
; How to compile, link, and run:
;  nasm -felf64 miles_per_gallon.asm && gcc miles_per_gallon.o && ./a.out

extern printf
extern scanf

; Usage: GET_INPUT how_read, where_read
%macro GET_INPUT 2
  mov rdi, %1 ; How to read input
  mov rsi, %2 ; Where to put input
  mov al, 0
  call scanf ; Read input and store it in %2
%endmacro

; Usage: PRINT_MSG what_to_print, format_1
%macro PRINT_MSG 2
  mov rsi, %2
  PRINT_MSG %1
%endmacro

; Usage: PRINT_MSG what_to_print
%macro PRINT_MSG 1
  mov rdi, %1
  mov al, 0
  call printf
%endmacro

; Usage: PRINT_NEWLINE
%macro PRINT_NEWLINE 0
  mov rdi, newline ; Print '\n'
  mov al, 0
  call printf
%endmacro

section .data
  newline: dd 10
  welcome_msg: dd "Welcome to The Miles per Gallon Calculator!", 10, 0
  miles_msg: dd "Enter miles: ", 10, 0
  gallons_msg: dd "Enter gallons: ", 10, 0
  mpg_msg: dd "Your approximate MPG = %.2f", 10, 0
  no_gallons: dd "If you had no gas, how could you go anywhere? Please try again.", 10, 0
  float_input: dd "%f", 0

section .bss
  miles: resd 1
  gallons: resd 1
  mpg: resd 1

section .text

get_miles:
  ; Get miles
  PRINT_MSG miles_msg
  GET_INPUT float_input, miles
  ret

get_gallons:
  ; Get gallons
  PRINT_MSG gallons_msg
  GET_INPUT float_input, gallons
  mov rax, [gallons]
  ; When no gallons
  cmp rax, 0
    je zero_gallons_error
  ret

zero_gallons_error:
  ; We need a non-zero number because we will divide this later
  PRINT_MSG no_gallons
  PRINT_NEWLINE
  ; No ask for gallons again
  jmp get_gallons
  ret

calculate_mpg:
  ; MPG = miles/gallons
  finit ; Reset fpu stack
  ; Move floating point miles and gallons to designated operand
  movss	xmm0, dword [miles]
  movss	xmm1, dword [gallons]
  ; No we can divide and put result into xmm0
  divss	xmm0, xmm1
  ret

display_mpg:
  ; Convert single-precision to double-precision float
  cvtps2pd	xmm0, xmm0
  ; Now print the mpg with the mpg result stored in xmm0
  mov	rdi, mpg_msg
  mov	rax, 1
  call	printf
  PRINT_NEWLINE
  ret

run_mpg_calculator:
  ; Set stack
  push rbp
  ; Inform user what program is about
  PRINT_MSG welcome_msg
  PRINT_NEWLINE
  ; Run the functions to get miles, gallons, calculate, and display results
  call get_miles
  call get_gallons
  call calculate_mpg
  call display_mpg
  ; Reset stack
  pop	rbp
  mov rax, 0
  ret

  global main
  main:
    ; Run the entire mpg calculator program then exist
    call run_mpg_calculator
