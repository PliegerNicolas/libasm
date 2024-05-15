section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    extern  __errno_location
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_write

    ; Information on ft_write.
        ; Arguments:
        ;   RDI - File discriptor to write to.
        ;   RSI - Pointer/address of buffer to write to.
        ;   RDX - Number of bytes to write.
        ; Returns:
        ;   RAX - Read bytes or -1 on error (errno is set).

ft_write:

    ; ft_write initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_write start.
        mov         rdi, rdi                    ; rdi is already set by passed argument.
        mov         rsi, rsi                    ; rsi is already set by passed argument.
        mov         rdx, rdx                    ; rdx is already set by passed argument.
        mov         rax, 1                      ; Set syscall value (1: sys_write).
        syscall                                 ; Trigger the syscall.
        test        rax, rax                    ; Verify return value of syscall.
        js          .error                      ; If sign flag is negative, jump to .error.

    .end:
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of RAX).

    .error:
        neg         rax                         ; Invert the negative error code returned by syscall.
        mov         rdi, rax                    ; Move rax to rdi to preserve it's value. Call __errno_location would overwrite rax.
        call        __errno_location wrt ..plt  ; Call __errno_location. It will return the pointer/address to errno.
        mov         [rax], rdi                  ; Move the error code from rdi to the memory location pointer by rax (errno).
        mov         rax, -1                     ; Set error code to -1.
        jmp         .end                        ; Jump unconditionally to .end.

; This implementation of ft_strlen has similar performances to the original clib strlen.
; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.