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

        mov         rdi, rsi
        call ft_check_for_duplicates

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

        ; Check if between 8 and 13 (ascii decimal range for whitespaces)
        cmp         cl, 8                                   ; Compare cl to 8 (lower bound to whitespace ascii characters)
        jb          .end                                    ; If cl lower than 8, jump to .end (return 0).
        cmp         cl, 13                                  ; Compare cl to 13 (upper bound to whitespace ascii characters)
        jg          .end                                    ; If cl bigger than 13, jump to .end (return 0).

        ; Update return value if tests passed.
        xor         rax, rax                                ; Set rax to 0 through XOR operation to indicate the byte is not a whitespace.

    .end:
        ret                                                 ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                     ft_check_for_duplicates                      ; ;;;
;;; ; ================================================================ ; ;;;

section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_check_for_duplicates

    ; Information on ft_list_split.
        ; Arguments:
        ;   RDI - Contains pointer to string to check (s)
        ; Returns:
        ;   RAX - 0 if no duplicates, 1 if duplicates found.

ft_check_for_duplicates:
    ; ft_check_for_duplicates.
        endbr64                                             ; Branch prediction hint (control flow enforcement technology).
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Initialization.
        ; Initialize hashmap to check for duplicates relative to ascii characters.
        vpxor       ymm0, ymm0                              ; Set ymm0 to 0x0 throuh XOR operation. This register is of size 32 bytes (256 bits).
        sub         rsp, ASCII_LENGTH                       ; allocate 128 bytes on stack. It will be used as a hashmap equivalent. 128 bytes as for 128 ascii characters.
        vmovdqu     [rbp + 0], ymm0                         ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp + 32], ymm0                        ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp + 64], ymm0                        ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp + 96], ymm0                        ; Initialize the allocated data on stack to 0x0.

        xor         rcx, rcx                                ; Initialize rcx to 0 through XOR operation. It will be the index used to read through the string (rdi).

    .loop:
        movzx       rax, byte [rdi + rcx]                   ; Read byte per byte the string contained in rdi. Store it in rax and pad the extra space of rax's register with 0s.
        test        al, al                                  ; Check if al isn't null byte. If it is it means we reached end of string.
        jz          .end                                    ; If end of string reached, jump to .end.
        mov         dl, byte [rbp + rax]                    ; Retrieve the hashmap's value relative to the character contained in al (rax).
        test        dl, dl                                  ; Check if dl (hashmap value relative to character stored in al (rax)) is 0x0 (it means it hasn't been found in string yet).
        jnz         .duplicate_found                        ; If dl != 0, jump to .duplicate_found.
        not         byte [rbp + rax]                        ; Invert value in hashmap to make it different from 0x0. This marks it as already found once.
        inc         rcx                                     ; Increment rcx to read through string.
        jmp         .loop                                   ; Jump to .loop unconditionally.

    .duplicate_found:
        mov         rax, 1                                  ; Set rax to one because duplicate has been found.

    .end:
        add         rsp, ASCII_LENGTH                       ; Dellocate memory from stack.
        pop         rbp                                     ; Restore previous base pointer and remove it from the top of the stack.
        ret                                                 ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                              data                                ; ;;;
;;; ; ================================================================ ; ;;;

section .data
    ; Heap helpers
    ASCII_LENGTH        equ         128                     ; Bytes necessary to store 128 ascii characters.

    ; ft_list_merge specific