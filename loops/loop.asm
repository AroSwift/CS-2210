; Name: Aaron Barlow
; Date: 10/22/2016

section	.text
   global _start ; Must declare '_start' so we can use it

_start: ; This is the entry point (Code area)
  ; Initialize the incrementer number to 1
  mov	byte [current_num], 1

  increment_to_9:
    ; Convert current number to ASCII
    add	byte [current_num], '0'
    ; Use current number as output
    mov	ecx, current_num
    ; Print the number with a new line
    call print
    call print_new_line
    ; Change back to a number
    sub	byte [current_num], '0'
    ; Check if the current number is equal to 9
    cmp byte [current_num], byte 9
      ; If we incremet to 10 then we would add '0' to 10
      ; which would give us a non-number. Therefore,
      ; we cannot increment again, so we must jump.
      je display_10
      ; Otherwise, increment the number
      inc byte [current_num]
      ; Repeat when comparison is not 9
      jne increment_to_9

  display_10:
    ; Set the current number to 1
    mov	byte [current_num], 1
    ; Convert current number to ASCII
    add byte [current_num], '0'
    ; Put current number into output location
    mov	ecx, current_num
    ; Only print 1 (no new line yet)
    call print

    ; Set the current number to 0
    mov	byte [current_num], 0
    ; Convert current number to ASCII
    add byte [current_num], '0'
    ; Put current number into output location
    mov	ecx, current_num
    ; Print 0 with a new line to make 10
    call print
    call print_new_line

  ; Properly exit program
  mov	eax, 1	; System call: sys_exit
  int	0x80	  ; call kernel

print:
  mov	edx, 1  ; Length of output
  mov	ebx, 1	; System call: stdout
  mov	eax, 4	; System call: sys_write
  int	0x80	  ; Call kernel
  ret

print_new_line:
  mov ecx, end_line ; Use end_line constant
  mov	edx, 1  ; Length of output
  mov	ebx, 1	; System call: stdout
  mov	eax, 4	; System call: sys_write
  int	0x80	  ; Call kernel
  ret

section .bss ; Statically-allocated variables
  current_num resb 1

section .data ; Constants
  end_line db  10
