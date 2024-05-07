section .data
    hello_msg db 'Hello world!', 10
	len equ $ - hello_msg

section .text
    global hello_world

hello_world:
    ; Use relative addressing for accessing hello_msg
    mov rax, 1              ; syscall number for sys_write
    mov rdi, 1              ; file descriptor STDOUT
    lea rsi, [rel hello_msg]		; relative address of hello_msg
    mov rdx, len            ; length of the message
    syscall

    ; Exit the program
    mov rax, 60             ; syscall number for sys_exit
    xor rdi, rdi            ; error code 0 (success)
    syscall
