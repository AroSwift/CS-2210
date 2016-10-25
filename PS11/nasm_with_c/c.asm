; nasm -felf64 c.asm && g++ c.o && ./a.out

global  main
extern  printf

section .data
  ; Note strings must be terminated with 0 in C
  ; 10 = newline
  format: db "Number: %d", 10, 0
  number: db 23

section .text
  ; This is called by the C library startup code
  main:
    ; Set '%d'
    mov rsi, [number] ; or 0x17
    ; Before setting the message
    mov rdi, format
    mov al, 0
    ; Then print message (using C call)
    call printf

    ; Exit this program
    mov rax, 60
    xor rdi, rdi
    syscall
