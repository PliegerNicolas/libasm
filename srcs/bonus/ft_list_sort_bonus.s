section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_sort

    ; Information on ft_list_sort.
        ; Arguments:
        ;
        ; Returns:
        ;   RAX -

ft_list_sort:

    ; ft_list_sort initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_list_sort start.

    .end:
        add         rax, rcx                    ; Add the remaining read bytes contained in rcx/cx to rax.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.