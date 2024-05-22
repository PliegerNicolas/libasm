section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_atoi_base

    ; Information on ft_atoi_base.
        ; Arguments:
        ;   RDI - Pointer to string (s) to convert to integer.
        ;   RSI - Pointer to string (base) representing the base to convert to (0123456789ABCDEF for hex for example).
        ; Returns:
        ;   RAX - The converted value as an integer (32bits (eax)).

ft_atoi_base:

    ; ft_atoi_base initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_atoi_base start.

    .end:
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.