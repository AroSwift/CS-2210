; nasm -felf64 scanf.asm && g++ scanf.o && ./a.out

global  main
extern  scanf
extern  printf


section .bss
  number: resb 64

section .data
  ; Note strings must be terminated with 0 in C
  ; 10 = newline
  ask:     db "Number: ", 10, 0
  show:    db "Number = %d", 10, 0
  get:     db "%d", 0

section .text
  ; This is called by the C library startup code
  global main
  main:
    ; Ask question
    mov rdi, ask
    mov al, 0
    call printf

    ; Now print
    mov [number], rsi
    ; ask for variables
    mov rdi, get
    mov al, 0
    ; Then print message (using C call)
    call scanf

    ; Ask question
    mov rsi, number
    mov rdi, show
    mov al, 0
    call printf

    ; ; Exit this program
    ; mov rax, 60
    ; xor rdi, rdi
    ; syscall

    ; NEW WAY TO END!!! YAY!!!
    mov rax, 0
    ret
