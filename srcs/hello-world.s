section .data
	; Constants

section .bss
	; Variables

section .text
	global _start	; Entry point for linker

	_start:			; Code start here.

	; End program
	mov	rax, 60		; sys_exit
	mov	rdi, 0		; error code 0 (success)
	syscall