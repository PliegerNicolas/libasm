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
        endbr64                                             ; AMD specific branch prediction hint.
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

        xor         rax, rax                                ; Initialize rax to 0 as it is the return value in case an error occurs.
        xor         rcx, rcx                                ; Initialize rcx to 0 as it is the read index in loops for strings.

    ; Verify arguments.
        test        rdi, rdi                                ; Verify if rdi (s) is 0x0 (null).
        jz          .end                                    ; If rdi (s) is null, jump to .end.
        test        rsi, rsi                                ; Verify if rsi (base) is 0x0 (null).
        jz          .end                                    ; If rsi (s) is null, jump to .end.

        mov         rdi, rsi
        call ft_check_base

    .end:
        pop         rbp                                     ; Restore previous base pointer and remove it from the top of the stack.
        ret                                                 ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.

;;; ; ================================================================ ; ;;;
;;; ;                         ft_check_base                            ; ;;;
;;; ; ================================================================ ; ;;;

section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_check_base

    ; Information on ft_list_split.
        ; Arguments:
        ;   RDI - Contains pointer to string to check (s)
        ; Returns:
        ;   RAX - 0 if valid base. 1 if invalid base.

ft_check_base:
    ; ft_check_base.
        endbr64                                             ; AMD specific branch prediction hint.
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Initialization.
        ; Initialize hashmap to check for duplicates relative to ascii characters.
        sub         rsp, ASCII_LENGTH                       ; allocate 128 bytes on stack. It will be used as a hashmap equivalent. 128 bytes as for 128 ascii characters.

        vpxor       ymm0, ymm0                              ; Set ymm0 to 0x0 throuh XOR operation. This register is of size 32 bytes (256 bits).
        vmovdqu     [rbp - 32], ymm0                         ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp - 64], ymm0                        ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp - 96], ymm0                        ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp - 128], ymm0                        ; Initialize the allocated data on stack to 0x0.

        mov         r8, rdi                                 ; Cpy rdi to r8 to preserve it.

    .loop:
        ; Verify if null byte reached.
        movzx       rdi, byte [r8 + rcx]                    ; Read r8 byte per byte (string). Store it in rdi and pad the extra space of rdi's register with 0s.
        test        dil, dil                                ; Check if dil (8 LSB of rdi) isn't null byte. If it is it means we reached end of string.
        jz          .end                                    ; If end of string reached, jump to .end.

        ; Verify if whitespace char acter found.
        ; ft_isspace: { args: [rdi = character/byte], ret: [rax is 1 if whitespace, else 0.] }   
        call        ft_isspace                              ; Call 'ft_isspace'.
        test        rax, rax                                ; Check output of 'ft_isspace'. If different than 0 it means a whitespace has been found.
        jnz         .base_error                             ; If whitespace found, jump to .end.
        ; RDI isn't modified by ft_isspace. We take that into account so we do not have to restore it.

        ; Verify if duplicate character.
        mov         dl, byte [rsp + rdi]                    ; Retrieve the hashmap's value relative to the character contained in dil (rdi).
        test        dl, dl                                  ; Check if dl (hashmap value relative to character stored in al (rax)) is 0x0 (it means it hasn't been found in string yet).
        jnz         .base_error                             ; If dl != 0, jump to .duplicate_found.
        not         byte [rsp + rdi]                        ; Invert value in hashmap to make it different from 0x0. This marks it as already found once.

        ; Loop.
        inc         rcx                                     ; Increment rcx to read through string.
        jmp         .loop                                   ; Jump to .loop unconditionally.

    .base_error:
        mov         rax, 1                                  ; Set rax to one because duplicate has been found.

    .end:
        mov         rdi, r8                                 ; Restore rdi (original string pointer).
        add         rsp, ASCII_LENGTH                       ; Dellocate memory from stack.
        pop         rbp                                     ; Restore previous base pointer and remove it from the top of the stack.
        ret                                                 ; Return (by default expects the content of rax).

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
            endbr64                                         ; Branch prediction hint (control flow enforcement technology).

        ; Initialization.
        xor         rax, rax                                ; Initialize rax to 1 to indicate byte is not an ascii whitespace.

        ; Check if between 8 and 13 (ascii decimal range for whitespaces)
        cmp         dil, 8                                  ; Compare dil (rdi's 8 LSB) to 8 (lower bound to whitespace ascii characters)
        jb          .end                                    ; If dil (rdi's 8 LSB) lower than 8, jump to .end (return 0 as byte is not a whitespace character).
        cmp         dil, 32                                 ; Compare dil with 32 (dec ascii value for space).
        jz          .whitespace_found                       ; If dil contains space, jump to .whitespace_found.
        cmp         dil, 13                                 ; Compare dil (rdi's 8 LSB) to 13 (upper bound to whitespace ascii characters)
        jg          .end                                    ; If dil (rdi's 8 LSB) bigger than 13, jump to .end (return 0 as byte is not a whitespace character).

    .whitespace_found:
        mov         rax, 1                                  ; Set rax to 1 to indicate the byte is a whitespace.

    .end:
        ret                                                 ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                              data                                ; ;;;
;;; ; ================================================================ ; ;;;

section .data
    ; Heap helpers
    ASCII_LENGTH        equ         128                     ; Bytes necessary to store 128 ascii characters.