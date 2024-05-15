section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_push_front

    ; Information on ft_list_push_front.
        ; Arguments:
        ;
        ; Returns:
        ;   RAX -

ft_list_push_front:

    ; ft_list_push_front initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_list_push_front start.

    .end:
        add         rax, rcx                    ; Add the remaining read bytes contained in rcx/cx to rax.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.