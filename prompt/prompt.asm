print:
	mov ebx, 1
	mov eax, 4
	int 0x80
	ret

section	.data
	str: times 100 db 0
	prompt db 'Enter dem Digits!'
	output equ $ - prompt
	msg	
	strLen equ $ - 

section .bss
	strLen resb 4

section .text
    global _start   ;must be declared for linker (ld)
_start:	            ;tells linker entry point
	; PROMPT!
	mov edx, 3  
	mov ebx, 0
	mov ecx, str
	mov edx, 100
	int 0x80
	
	; Do Dat Reading Tho
	mov eax, 3
	mov ebx, 0
	mov ecx, max
	mov edx, 5
	int 0x80 

	; OUTPUT Dat Text!  
	mov eax, 4
	mov ebx, 1
	call print

	; Before creating an infinitive loop..
	; make eax and ebx same
	mov eax, str
	mov ebx, eax

	increment:
		cmp [byte ebx], byte 0
		je done
		inc ebx
		; Compare upon equal then jump upon equality
		jmp done

	done:
		# Print this stuff out
		dec eax
		sub ebx, eax
		
		mov edx, ebx
		mov ecx, str

		; EXIT!
		mov edx, 1
		mov ecx, endl
		call print
int 0x80


