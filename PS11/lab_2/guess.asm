extern scanf
extern printf
extern srand
extern time
extern rand

section .data
  welcome_msg: db "***** Welcome to GuessIT *****", 10, 10, 0
  guess_msg: db "Guess the number Im thinking of (between %d and %d): ", 0
  exit_msg: db 10, "***** Thank you for playing GuessIT *****", 10, 0

section .bss
  current_num: resb 2

section .text
global main
main:

  ; print welcome message
  mov  rdi, welcome_msg
  mov  al, 0
  call printf


  ; print exit message
  mov  rdi, exit_msg
  mov  al, 0
  call printf

  ; Exit program
  mov rax, 0
  ret
