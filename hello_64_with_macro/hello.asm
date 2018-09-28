; nasm -felf64 hello.asm && ld hello.o && ./a.out

        global  _start

%macro print 2
        push %1
        push %2
        mov     %1, 1         ; system call 1 is write
        mov     %2, 1         ; file handle 1 is stdout
        syscall                ; invoke operating system to do the write
        pop %2
        pop %1
        int 0x80
%endmacro

section .data
        message: db      "Hello, World", 10      ; note the newline at the end
        msgLen:  equ     $ - message

section .text
  _start:
        ; write(1, message, 13)
        mov     rsi, message   ; address of string to output
        mov     rdx, msgLen    ; number of bytes
        print   rax, rdi

        ; exit(0)
        mov     rax, 60        ; system call 60 is exit
        xor     rdi, rdi       ; exit code 0
        syscall                ; invoke operating system to exit
