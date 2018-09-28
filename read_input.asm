
section	.text
   global _start     ;must be declared for linker (ld)

_start:	              ;tells linker entry point
   mov	edx,promptLen ;message length
   mov	ecx,prompt    ;message to write
   call print

    mov eax, 3         ; Read user input into str
    mov ebx, 0         ; |
    mov ecx, str       ; | <- destination
    mov edx, 100       ; | <- length
    int 0x80           ; \

   mov	edx,msgLen   ;message length
   mov	ecx,msg      ;message to write
   call print

   mov eax, str      ;starting address of str
   mov ebx, str      ;will increment to find '\0'

 loop:                      ;strlen main loop
 	cmp [byte ebx], byte 0  ;end of string?
    je  next                ;jump on end of string
    inc ebx                 ;go to next character
    jmp loop                ;end of main loop

 next:               ;end of string found
    dec ebx          ;remove '\n' from end
    sub ebx, eax     ;calculate str len

    mov	edx,ebx      ;message length
    mov	ecx,str      ;message to write
    call print

   mov	edx,1        ;message length
   mov	ecx,endl     ;message to write
   call print

mov	eax,1       ;system call number (sys_exit)
    int	0x80    ;call kernel

print:
   mov	ebx,1        ;file descriptor (stdout)
   mov	eax,4        ;system call number (sys_write)
   int	0x80         ;call kernel
   ret

section	.data
str: 	  times 100 db 0
prompt    db  'Enter a number: '  ;string to be printed
promptLen equ $ - prompt          ;length of the string
msg       db  'You entered '  ;string to be printed
msgLen    equ $ - msg          ;length of the string
endl      db  10

section .bss
strLen		resb	4
