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

        xor         rax, rax                    ; Initialize rax to 0 as it is the return value in case an error occurs.
        xor         rcx, rcx                    ; Initialize rcx to 0 as it is the read index in loops for strings.

    ; Verify arguments.
        test        rdi, rdi                    ; Verify if rdi (s) is 0x0 (null).
        jz          .end                        ; If rdi (s) is null, jump to .end.
        test        rsi, rsi                    ; Verify if rsi (base) is 0x0 (null).
        jz          .end                        ; If rsi (s) is null, jump to .end.

    .end:
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.

;;; ; ================================================================ ; ;;;
;;; ;                            ft_isspace                            ; ;;;
;;; ; ================================================================ ; ;;;

section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_isspace

    ; Information on ft_list_split.
        ; Arguments:
        ;   RDI - Contains byte/char to check.
        ; Returns:
        ;   RAX - 1 if it is a whitespace. Else a 0.

ft_isspace:
    ; ft_isspace initialization.
        endbr64                                             ; Branch prediction hint (control flow enforcement technology).

        ; Initialization.
        mov         rax, 1                                  ; Initialize rax to 1 to indicate a whitespace has been found.
        mov         rcx, rdi                                ; Copy rdi in rcx so cl can be used (8 LSB).

        cmp         cl, 8                                   ; Compare cl to 8 (lower bound to whitespace ascii characters)
        jb          .end                                    ; If cl lower than 8, jump to .end (return 0).
        cmp         cl, 13                                  ; Compare cl to 13 (upper bound to whitespace ascii characters)
        jg          .end                                    ; If cl bigger than 13, jump to .end (return 0).

        xor         rax, rax                                ; Set rax to 0 through XOR operation to indicate the byte is not a whitespace.

    .end:
        ret                                                 ; Return (by default expects the content of rax).
