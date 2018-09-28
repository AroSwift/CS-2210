; nasm -felf64 hello.asm && ld hello.o && ./a.out

        global  _start

section .data
        message: db      "Hello, World", 10      ; note the newline at the end
        msgLen:  equ     $ - message

section .text
  _start:
        ; write(1, message, 13)
        mov     rsi, message   ; address of string to output
        mov     rdx, msgLen    ; number of bytes
        call print

        ; exit(0)
        mov     rax, 60        ; system call 60 is exit
        xor     rdi, rdi       ; exit code 0
        syscall                ; invoke operating system to exit

print:
        ; push/pop saves the registers
        ; So we do not lose that data
        push rax
        push rdi
        mov     rax, 1         ; system call 1 is write
        mov     rdi, 1         ; file handle 1 is stdout
        syscall                ; invoke operating system to do the write
        pop rdi
        pop rax
        ret
