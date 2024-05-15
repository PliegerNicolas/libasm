section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    extern  ft_strlen
    extern  malloc
    extern  ft_strcpy
    extern  __errno_location
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_strdup

    ; Information on ft_strdup.
        ; Arguments:
        ;   RDI - Pointer/Address targeting null-terminated string (s) in memory that we want to duplicate.
        ; Returns:
        ;   RAX - New pointer/address containing the same data as rdi points to.

ft_strdup:

    ; ft_strdup initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_strdup start.

        push        rdi                         ; Store rdi (pointer of string to copy) on top of the stack to preserve it.

    ; ft_strlen { args: [RDI contains ptr to str], ret: [rax is set to length of string, null-byte excluded] }
        mov         rdi, rdi                    ; Useless instruction. Just to specify that rdi is set as requested by strlen.
        call        ft_strlen                   ; Call ft_strlen.
        inc         rax                         ; Increment rax to account for the null-byte.

    ; malloc: { args: [RDI contains size in bytes to allocate], ret: [rax is set to new ptr/addr] }
        mov         rdi, rax                    ; Store the result of strlen (rax) in rdi as requested by malloc.
        call        malloc wrt ..plt            ; Call malloc.
        test        rax, rax                    ; Check malloc's return value.
        jz          .error                      ; If 0x0, jump to .error

    ; ft_strcpy: { args: [rdi contains ptr to dest str (to copy to), rsi contains ptr of source str (to copy from)], ret: [ptr/addr of rdi] }
        mov         rdi, rax                    ; Move the ptr/addr of the target to rdi.
        pop         rsi                         ; Restore the ptr/addr of the source string we want to copy from that was pushed previously to the stack in rsi as requested by strcpy.
        call        ft_strcpy wrt ..plt                  ; Call ft_strcpy.

    .end:
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

    .error:
        mov     rdi, ENOMEM                     ; Move error code to rdi. _errno_location will need rax.
        call    __errno_location wrt ..plt      ; Call __errno_location, returns the memory address of the errno variable.
        mov     [rax], rdi                      ; Set errno value by dereferencing it and giving it the rdi value.
        mov     rax, 0x0                        ; Set return value (rax) to -1.
        jmp     .end                            ; Jump to .end unconditionally.

section .data
    ENOMEM equ  12                  ; Err code for POSIX-compliant systems: 'Not Enough Memory'

; This implementation of strdup is significantly slower to the original clib strdup, even when calling the original functions.
; I don't know how to optimize it more without reinventing the wheel.
; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.