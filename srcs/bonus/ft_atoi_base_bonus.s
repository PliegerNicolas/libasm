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
        ;       Prefix whitespaces are skipped. If an odd number of "-" signs are present the value will be negative. It then evaluates the string until a null-byte found or character not in base.
        ;       No checks for overflow or underflow are done (check max_int: 2147483647 and min_int: -2147483648).
        ;   RSI - Pointer to string (base) representing the base to convert to (0123456789ABCDEF for hex for example).
        ; Returns:
        ;   RAX - The converted value as an integer (32bits (eax)). On error, return 0.

ft_atoi_base:
    ; ft_atoi_base initialization.
        endbr64                                             ; AMD specific branch prediction hint.
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Initialize regisers.
        xor         rax, rax                                ; Initialize rax to 0 through XOR operation. We will use eax because we are expected to return an integer (32bit). Rax is (64bit).
        pxor        xmm0, xmm0                              ; Initialize xmm0 to 0 through XOR operation. xmm registers do not support precise bitwise shifting. We'll have to split our 128 bitmask into 2 64bit registers (r8, r9).

    ; Initialize stack values.
        sub         rsp, ALLOC_ATOI_BASE                    ; Allocate memory to stack.
        mov         [rbp - STRING_PTR], rdi                 ; Store rdi in stack as string_ptr.
        mov         [rbp - BASE_PTR], rsi                   ; Store rsi in stack as base_ptr.
        movdqu      [rbp - LEFT_BITMASK], xmm0              ; Store xmm0 in stack as bitmask for ascii characters.

    ; Check if rdi (string to convert) is 0x0 (null).
        test        rdi, rdi                                ; check if rdi is 0x0 (null).
        jz          .end                                    ; If zero flag set, jump to .end. It means an invalid string has been passed.

    ; Call 'ft_check_base'.
        ; ft_check_base: { args: [rdi = char *base, rsi = void *bitmask (as XMM register), rdx = ptr/addr of 'cmp' function], ret: [rax is set to length of base or 0 for error] }.
        mov         rdi, rsi                                ; Move base (rsi) to rdi, as requested by 'ft_check_base'.
        lea         rsi, [rbp - LEFT_BITMASK]               ; Load effective address in stack of bitmask (ptr to xmm0).
        call        ft_check_base                           ; Call 'ft_check_base'.

    ; Check output of 'ft_check_base'
        test        rax, rax                                ; Verify if rax != 0x0 (null). 1 Means valid base, 0 means invalid base.
        jz          .end                                    ; If zero flag set, it means the base is invalid.

    ; Restore registers after function call.
        movdqu      xmm0, [rsi]                             ; Update the bitmask stored in xmm0. This maps with it's bits the found characters in the base relative to their position in the ascii table.
        mov         rsi, rdi                                ; Restore rsi from rdi. 'ft_check_base' doesn't modify rdi.
        mov         rdi, [rbp - STRING_PTR]                 ; Restore rdi to string pointer from stack.
        mov         r8, rax                                 ; Store the base's length in r8.
        xor         rax, rax                                ; Set rax to 0 through XOR operation.
        xor         r9, r9                                  ; Initialize r9 to 0 through XOR operation. It will be used as '-' counter.

    ; Skip prepending whitespace characters.
    .skip_whitespace_chars:
    ; Check for null-byte.
        mov         dl, [rdi]                               ; Read the first byte pointer to by rdi.
        test        dl, dl                                  ; Verify if dl is 0x0 (null), meaning that null byte has been found and end of string has been reached.
        jz          .end                                    ; If it's the case, jump to .end. Returns 0 (as nothing has been converted).
    ; Check if current byte is a whitespace character (" \b\t\n\v\f\r").
        cmp         dl, 32                                  ; Check if dl is decimal representation of ascii character ' '.
        jz          .skip_whitespace_chars_next_iter        ; If ' ' found, jump to .skip_whitespace_chars_next_iter to continue looping.
        cmp         dl, 8                                   ; Check if dl is < to ascii's table lower bound of whitespace characters.
        jb          .get_sign                               ; If dl is < to '\b' (8), we know it's not a whitespace character thus jump to .get_sign.
        cmp         dl, 13                                  ; Check if dl is > to ascii's table higher bound of whitespace characters.
        jg          .get_sign                               ; If dl is > to '\r' (13), we know it's not a whitespace character thus jump to .get_sign.
    .skip_whitespace_chars_next_iter:
        inc         rdi                                     ; Increment rdi pointer to get to the next byte.
        jmp         .skip_whitespace_chars                  ; Jump unconditionally to .skip_whitespace_chars

    .get_sign:
    ; Check if null null-byte found.
        mov         dl, [rdi]                               ; Read the first byte pointer to by rdi.
        test        dl, dl                                  ; Verify if dl is 0x0 (null), meaning that null byte has been found and end of string has been reached.
        jz          .end                                    ; If it's the case, jump to .end. Returns 0 (as nothing has been converted).
    ; check if current byte is a sign character ("+-"). If it's a -, increment the '-' sign count. We can later check if it is pair or not.
        cmp         dl, 43                                  ; Check if dl is decimal representation of ascii character '+' (43).
        jz          .get_sign_next_iter                     ; Verify if zero flag set (dl == 45). If it is a +, jump to .get_sign_next_iter.
        cmp         dl, 45                                  ; Check if dl is decimal representation of ascii character '-' (45).
        jnz         .convert_to_integer                     ; If it's neither a + or a -, jump to .convert_to_integer.
        inc         r9                                      ; Increment r9 by one, to account for the found '-' signs.
    .get_sign_next_iter:
        inc         rdi
        jmp         .get_sign                               ; Jump to .get_sign unconditionally.

    ; I SHOULD CHECK SOMEWHERE FOR OUT OF BOUND

    .convert_to_integer:
        movq        r10, xmm0                               ; Store 64 LSB of bitmask in r10.
        psrldq      xmm0, 8                                 ; Bitshift xmm0 by 8 bytes.
        movq        r11, xmm0                               ; Store 64 MSB (LSB but byte shifted) of bitmask in r11.

    .conversion_loop:
    ; Check for null-byte.
        mov         dl, [rdi]                               ; Read the first byte pointer to by rdi.
        test        dl, dl
        jz          .update_conversion_sign                 ; If null-byte found, jump to .end. We return the current calculated value in rax.
    ; Check if character is part of base (check bits set to 1 in bitmask).
        cmp         dl, HALF_ASCII_TABLE_LENGTH              ; Compare with the value of half ascii table's length because our bitmask is separated in two 64bit registers.
        jg          .right_half_ascii_bitmask               ; If dl (ascii char) is part of the right half of the ascii table, jump to .right_half_ascii_bitmask
    .left_half_ascii_bitmask:
        bts         r10, rdx                                ; Check bit and set the bit at rdx'th position. If bit was set on test, cf flag is set.
        jnc         .update_conversion_sign                 ; If CF not flag set, that means char is not part of bitmask/base. We end conversion here. Jump to .update_conversion_sign.
        jmp         .convert_char                           ; Jump unconditionally to convert_char.
    .right_half_ascii_bitmask:
        sub         dl, HALF_ASCII_TABLE_LENGTH             ; Substract from dl (char) 64 to accomodate for the split of the bitmask into 2 64bit registers.
        bts         r11, rdx                                ; Check bit and set the bit at rdx'th position. If bit was set on test, cf flag is set.
        jnc         .update_conversion_sign                 ; If CF not flag set, that means char is not part of bitmask/base. We end conversion here. Jump to .update_conversion_sign.
        add         dl, HALF_ASCII_TABLE_LENGTH             ; Restore the value of dl.
    .convert_char:
        imul        eax, r8d                                ; Multiply the current value by size of base (r8's 32bit representation is r8d). We target eax cause an integer is a 32bit value.
        xor         rcx, rcx                                ; Set rcx to 0. This will store the base-index/value of a specific byte relative to the base string.
    .get_char_value_in_base:
        cmp         dl, [rsi + rcx]                         ; Compare the current rdi byte (dl) with the rcx'th byte of rsi.
        jz          .add_converted_char_to_retval           ; If equal, jump to .add_converted_char_to_retval.
        inc         rcx                                     ; Else, increment rcx by one to read next byte of base.
        jmp         .get_char_value_in_base                 ; Jump unconditionally to .get_char_value_in_base
    .add_converted_char_to_retval:
        add         eax, ecx                                ; Add index of relative byte in base to eax (rax).
        inc         rdi                                     ; increment rdi to get to next byte.
        jmp         .conversion_loop                        ; jump unconditionally to .conversion_loop to loop the conversion process.

    .update_conversion_sign:
        test        r9, 1                                   ; Compare r9 (number of found - as prefix) and compare it with 1. This checks if LSB of r9 is set or not.
        jz          .end                                    ; If zero flag is set, it means that the number of '-' is pair. That means the value is positive. Jump to .end.
        neg         eax                                     ; Else, negative eax (set sign bit to 1).

    .end:
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
    ; local  ft_check_base

    ; Information on ft_list_split.
        ; Arguments:
        ;   RDI - Contains pointer to base (str).
        ;   RSI - Pointer to XMM bitmask for duplicate bytes/characters.
        ; Returns:
        ;   RAX - Length of base if valid. 0 if invalid base.

ft_check_base:
    ; ft_check_base.
        endbr64                                             ; AMD specific branch prediction hint.
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Initialize regisers.
        xor         rax, rax                                ; Initialize rax to 0 through XOR operation. If we return prematurely, we return eax (rax) as 0 to indicate an error.
        movdqu      xmm0, [rsi]                             ; Set xmm0 to the ascii bitmask stored in stack.
        movq        r8, xmm0                                ; Store 64 LSB of bitmask in r8.
        psrldq      xmm0, 8                                 ; Bitshift xmm0 by 8 bytes.
        movq        r9, xmm0                                ; Store 64 MSB (LSB but byte shifted) of bitmask in r9.

    ; Verify size of base (rdi == null || rdi[0] == null || rdi[1] == null).
        test        rdi, rdi                                ; Check if rdi (ptr) is 0x0 (null).
        jz          .end                                    ; If zero flag set (rdi == null), jump to .end.
        mov         dl, byte [rdi + 0]                      ; Store in dl (8 LSB of rdx) the first byte pointer of base.
        test        dl, dl                                  ; Check if [rdi + 0] (first base byte/char) is 0x0 (null).
        jz          .end                                    ; If zero flag set (rdi[0] == null), jump to .end.
        mov         dl, byte [rdi + 1]                      ; Store in dl (8 LSB of rdx) the second byte pointer of base.
        test        dl, dl                                  ; Check if [rdi + 1] (first base byte/char) is 0x0 (null).
        jz          .end                                    ; If zero flag set (rdi[1] == null), jump to .end.

    ; Scan byte/byte base string. If there is a duplicate character, a whitespace (" \b\t\n\v\f\r") or a sign ("+-"), return 0.
    .loop:
        movzx       rdx, byte [rdi + rax]                   ; Store in rdx (dl) the first/current character of rdi. We use movzx so we can use rdx later on as offset for our hashmap.
                                                            ;   It permits copying a smaller register to a bigger one, completing the extra bits with 0.
        test        dl, dl                                  ; Verify if null byte hasn't been reached (dl == 0x0).
        jz          .end                                    ; Jump to .end if null byte reached and no errors found before.
    ; Check if current byte is a sign ("+-").
        cmp         dl, 43                                  ; Check if dl is decimal representation of ascii character '+' (43).
        jz          .error_found                            ; Verify if zero flag set (dl == 43). If it is a +, jump to .error_found.
        cmp         dl, 45                                  ; Check if dl is decimal representation of ascii character '-' (45).
        jz          .error_found                            ; Verify if zero flag set (dl == 45). If it is a -, jump to .error_found.
    ; Check if current byte is a whitespace character (" \b\t\n\v\f\r").
        cmp         dl, 32                                  ; Check if dl is decimal representation of ascii character ' '.
        jz          .error_found                            ; Verify if zero flag set (dl == 32). If it is, jump to .error_found.
        cmp         dl, 8                                   ; Check if dl is < to ascii's table lower bound of whitespace characters.
        jb          .check_duplicates                       ; If dl is < to '\b' (8), we know it's not a whitespace character thus jump to .check_duplicates.
        cmp         dl, 13                                  ; Check if dl is > to ascii's table higher bound of whitespace characters.
        jg          .check_duplicates                       ; If dl is > to '\r' (13), we know it's not a whitespace character thus jump to .check_duplicates.
        jmp         .error_found                            ; Jump unconditionally to .end, because a whitespace has been found.
    ; Check if current byte has already been found.
    .check_duplicates:
        cmp         dl, HALF_ASCII_TABLE_LENGTH             ; Verify if ascii character is part of the left (first) or right (last) 64 characters of the ascii table.
        jg          .right_half_ascii_bitmask               ; If dl (ascii char) is part of the right half of the ascii table, jump to .right_half_ascii_bitmask

    .left_half_ascii_bitmask:
        bts         r8, rdx                                 ; Check bit and set the bit at rdx'th position. If bit was set on test, cf flag is set.
        jc          .error_found                            ; If CF flag set, that means a duplicate character has been found. Jump to .duplicate_found.
        jmp         .prepare_next_loop_iter                 ; Jump to .prepare_next_loop_iteration unconditionally.

    .right_half_ascii_bitmask:
        sub         dl, HALF_ASCII_TABLE_LENGTH             ; Substract from dl (char) 64 to accomodate for the split of the bitmask into 2 64bit registers.
        bts         r9, rdx                                 ; Check bit and set the bit at rdx'th position. If bit was set on test, cf flag is set.
        jc          .error_found                            ; If CF flag set, that means a duplicate character has been found. Jump to .duplicate_found.

    ; Prepare and jump to next loop iteration.
    .prepare_next_loop_iter:
        inc         rax                                     ; Increment rax once, to move through it (as string index), rdi one byte forward.
        jmp         .loop                                   ; Jump unconditionally to .loop.

    .error_found:
        xor         rax, rax                                ; Set rax to 0 through XOR operation on error.

    .end:
        mov         [rsi + 0], r8                           ; Join the values of r8 and r9 in the stack through the pointer passed in rsi (it's the size of a xmm register (128bits: 8 bytes * 2)).
        mov         [rsi + 8], r9                           ; Join the values of r8 and r9 in the stack through the pointer passed in rsi (it's the size of a xmm register (128bits: 8 bytes * 2)).
        pop         rbp                                     ; Restore previous base pointer and remove it from the top of the stack.
        ret                                                 ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                              data                                ; ;;;
;;; ; ================================================================ ; ;;;

section .data
    ; List helpers.
    ASCII_TABLE_LENGTH          equ         128             ; Number of characters found in the ascii table. (Same length as XMM register :D Let's take that into account).
    HALF_ASCII_TABLE_LENGTH     equ         64              ; Half of number of characters found in the ascii table. (Same length as traditionnal 64bit register :D Let's take that into account).

    ; ft_atoi_base
    ALLOC_ATOI_BASE             equ         32              ; 16 (128bit bitmask with xmm register) + 8 (ptr to rdi 64bit register).
    STRING_PTR                  equ         8               ; Stack shift for pointer of string to convert.
    BASE_PTR                    equ         16              ; Stack shift for base string pointer.
    LEFT_BITMASK                equ         24              ; Stack shift for pointer to duplicate byte/char bitmask in stack. We use 2 64 registers to represent our bitmask as xmm registers do not support precise bitwise shifting.
    RIGHT_BITMASK               equ         32              ; Stack shift for pointer to duplicate byte/char bitmask in stack. We use 2 64 registers to represent our bitmask as xmm registers do not support precise bitwise shifting.