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
        ;   RAX - The converted value as an integer (32bits (eax)). On error, return 0.

ft_atoi_base:
    ; ft_atoi_base initialization.
        endbr64                                             ; AMD specific branch prediction hint.
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Allocate space in stack for local variables.
        sub         rsp, ALLOC_ATOI_BASE                    ; Allocate bytes in stack.
        mov         [rsp + STRING_PTR], rdi                 ; Store rdi as string_ptr in stack.
        mov         [rsp + BASE_PTR], rsi                   ; Store rsi as base_ptr in stack.

    ; Check base.
        ; ft_check_base: { args: [rdi = Pointer to base string], ret: [rax is set to base length if valid base. Else 0.] }
        mov         rdi, rsi                                ; Set rdi to pointer to base string as requested by 'ft_check_base'.
        call        ft_check_base                           ; Call 'ft_check_base'.
        test        rax, rax                                ; Check output of 'ft_check_base'. If it's 0 it means the base is valid, else it isn't.
        jz          .end                                    ; If rax is 0 (invalid base), jump to .end. Return 0 to indicate an error.

    ; Store base's length.
        mov         r8, rax                                 ; Store rax in r8 as it now represents base length.

    ; Restore necessary registers after function call.
        mov         rdi, [rsp + STRING_PTR]                 ; Restore rdi from stack.
        mov         rsi, [rsp + BASE_PTR]                   ; Restore rsi from stack.

    ; check if string to convert is NULL.
        test        rdi, rdi                                ; Check if rdi is 0x0 (null).
        jz          .end                                    ; If zero flag is set thus rdi is null, jump to .end.

    ; Set rax to 0 to get set it has default value.
        xor         rax, rax                                ; Set rax to 0 through XOR operation.

    ; Skip whitespaces in string.
    .skip_whitespaces:
        mov         dl, byte [rdi]                          ; Retrieve current byte/char from rdi.
    ; Check for end of string.
        test        dl, dl                                  ; Check if dl is 0x0 (null) to signify end of string.
        jz          .end                                    ; Jump to .end. Rax is already set to 0 as there would be nothing to convert to int.
    ; Check if current byte is a whitespace character (" \b\t\n\v\f\r").
        cmp         dl, 32                                  ; Check if dl is decimal representation of ascii character ' '.
        jz          .get_sign                               ; If char == ' ', jump to .get_sign. The next step.
        cmp         dl, 8                                   ; Check if dl is < to ascii's table lower bound of whitespace characters.
        jb          .get_sign                               ; If dl is < to '\b' (8), jump to .get_sign. The next step.
        cmp         dl, 13                                  ; Check if dl is > to ascii's table lower bound of whitespace characters.
        jg          .get_sign                               ; If dl is > to '\r' (13), jump to .get_sign. The next step.
    ; Move to next loop iteration.
        inc         rdi                                     ; Increment rdi by one byte, to go to next character.
        jmp         .skip_whitespaces                       ; Jump unconditionally to .skip_whitespaces.

    .get_sign:
        mov         dl, byte [rdi]                          ; Retrieve current byte/char from rdi.
    ; Check for end of string.
        test        dl, dl                                  ; Check if dl is 0x0 (null) to signify end of string.
        jz          .end                                    ; Jump to .end. Rax is already set to 0 as there would be nothing to convert to int.
    ; Check if current byte is a sign character ("+-") and update sign accordingly.
        cmp         dl, 43                                  ; Check if dl is decimal representation of ascii character '-'.
        jz          .minus_sign                             ; If dl == '-', jump to .minus_sign.
        cmp         dl, 45                                  ; Check if dl is decimal representation of ascii character '+'.
        jnz         .convert_to_dec                         ; If not '+' (nor '+'), jump to .convert_to_dec.
    .minus_sign:
        neg         eax                                     ; EAX MAYBE ??????????????
    ; Nove to next loop iteration.
        inc         rdi
        jmp         .get_sign

    .convert_to_dec:
        ; ???

    .end:
        mov         rdi, [rsp + STRING_PTR]                 ; Restore string to scan pointer.
        mov         rsi, [rsp + BASE_PTR]                   ; Restore base string pointer.
        add         rsp, ALLOC_ATOI_BASE                    ; Deallocate memory from stack.
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
        ;   RAX - Length of base if valid. 0 if invalid base.

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

        mov         rax, 0                                  ; Initialize rax to 0 (indicating an error). This way, if we return prematurely the right value is set.

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
        movzx       rdx, byte [rdi + rax]                   ; Store in rdx (dl) the first/current character of rdi. We use movzx so we can use rdx later on as offset for our hashmap.
                                                            ;   It permits copying a smaller register to a bigger one, completing the extra bits with 0.
        test        dl, dl                                  ; Verify if null byte hasn't been reached (dl == 0x0).
        jz          .end                                    ; Jump to .end if null byte reached and no errors found before.
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
        not         byte [rsp + rdx]                        ; Invert bits to make it different than 0x0, indicating the character has been found.
        inc         rax                                     ; Increment rax once, to move through it (as string index), rdi one byte forward.
        jmp         .char_checker                           ; Jump unconditionally to .char_checker to loop it.

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

    ; Stack memory allocation for local variables.
    ALLOC_ATOI_BASE             equ         16              ; Number of bytes to allocate to 'ft_atoi_base' function in stack.

    ; ft_atoi_base
    STRING_PTR                  equ         8
    BASE_PTR                    equ         16
