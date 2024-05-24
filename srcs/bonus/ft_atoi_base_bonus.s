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

    ; Check base.
        ; ft_check_base: { args: [rdi = Pointer to base string], ret: [rax is set to 0 if valid base. Else 1.] }
        mov         rdi, rsi                                ; Set rdi to pointer to base string as requested by 'ft_check_base'.
        call        ft_check_base                           ; Call 'ft_check_base'.

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
        ;   RDI - Contains pointer to string to check (base)
        ; Returns:
        ;   RAX - 0 if valid base. 1 if invalid base.

ft_check_base:
    ; ft_check_base.
        endbr64                                             ; AMD specific branch prediction hint.
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Initialization.
        sub         rsp, ASCII_TABLE_LENGTH                 ; Allocate on stack 128 bytes. We will use those bytes to check if a character has already been found or not as if it was a hashmap equivalent.
        vpxor       ymm0, ymm0                              ; Set ymm0 to 0x0 throuh XOR operation. This register is of size 32 bytes (256 bits).
        vmovdqu     [rbp - 32], ymm0                        ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp - 64], ymm0                        ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp - 96], ymm0                        ; Initialize the allocated data on stack to 0x0.
        vmovdqu     [rbp - 128], ymm0                       ; Initialize the allocated data on stack to 0x0.

        mov         rax, 1                                  ; Initialize rax to 1 (indicating an error). This way, if we return prematurely the right value is set.

    ; Verify if rdi (base) is set to 0x0 (null).
        test        rdi, rdi                                ; Verify if rdi is not null (0x0). If it is, return an error.
        jz          .end                                    ; If zero flag set (rdi == 0x0), return an error.

    ; Verify length of base. If <= 1, error.
        mov         dl, byte [rdi]                          ; Set dl (8bit register) to first character/byte of rdi.
        test        dl, dl                                  ; Check if dl is null byte (0x0), indicating end of string.
        jz          .end                                    ; If zero flag set (dl == 0x0), return an error.
        mov         dl, byte [rdi + 1]                      ; Set dl (8bit register) to second character/byte of rdi.
        test        dl, dl                                  ; Check if dl is null byte (0x0), indicating end of string.
        jz          .end                                    ; If zero flag set (dl == 0x0), return an error.

    ; Scan byte/byte the base. If there is a duplicate character, a whitespace (" \b\t\n\v\f\r") or a sign ("+-"), return an error.
    .char_checker:
        movzx       rdx, byte [rdi]                         ; Store in rdx (dl) the first/current character of rdi. We use movzx so we can use rdx later on as offset for our hashmap.
                                                            ;   It permits copying a smaller register to a bigger one, completing the extra bits with 0.
        test        dl, dl                                  ; Verify if null byte hasn't been reached (dl == 0x0).
        jz          .base_valid                             ; Jump to .base_valid if null byte reached and no errors found before.
    ; Check if current byte is a sign ("+-").
        cmp         dl, 43                                  ; Check if dl is decimal representation of ascii character '-'.
        jz          .end                                    ; Verify if zero flag set (dl == 43). If it is, jump to .end.
        cmp         dl, 45                                  ; Check if dl is decimal representation of ascii character '+'.
        jz          .end                                    ; Verify if zero flag set (dl == 45). If it is, jump to .end.
    ; Check if current byte is a whitespace character (" \b\t\n\v\f\r").
        cmp         dl, 32                                  ; Check if dl is decimal representation of ascii character ' '.
        jz          .end                                    ; Verify if zero flag set (dl == 32). If it is, jump to .end.
        cmp         dl, 8                                   ; Check if dl is < to ascii's table lower bound of whitespace characters.
        jb          .not_a_whitespace                       ; If dl is < to '\b' (8), jump to .not_a_whitespace.
        cmp         dl, 13                                  ; Check if dl is > to ascii's table lower bound of whitespace characters.
        jg          .not_a_whitespace                       ; If dl is > to '\r' (13), jump to .not_a_whitespace.
        jmp         .end                                    ; Jump unconditionally to .end, because a whitespace has been found.

    .not_a_whitespace:
        mov         cl, byte [rsp + rdx]                    ; Store in cl the hashmap's byte representing if character has already been found or not. The byte is found in stack with offset of dl (rdx) bytes).
        test        cl, cl                                  ; Verify if cl is 0x0 (null). If it's null, it means the character hasn't been found yet.
        jnz         .end                                    ; If zero flag is set (cl != 0x0), a duplicate character has been found. Jump to .end.
        mov         byte [rsp + rdx], 1                     ; Invert bits to make it different than 0x0, indicating the character has been found.
        inc         rdi                                     ; Increment rdi by once, to move it one byte forward.
        jmp         .char_checker                           ; Jump unconditionally to .char_checker to loop it.

    .base_valid:
        xor             rax, rax

    .end:
        add         rsp, ASCII_TABLE_LENGTH                 ; Deallocate data from stack for ascii table hashmap equivalent.
        pop         rbp                                     ; Restore previous base pointer and remove it from the top of the stack.
        ret                                                 ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                              data                                ; ;;;
;;; ; ================================================================ ; ;;;

section .data
    ; List helpers.
    ASCII_TABLE_LENGTH          equ         128             ; Number of characters found in the ascii table.