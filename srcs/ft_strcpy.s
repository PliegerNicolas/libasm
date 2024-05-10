global ft_strcpy                            ; Entry-point for linker.

    ft_strcpy:
        ; Arguments:
        ;   rdi (s1) - Destination buffer. Should be of sufficiant size to contain s2 and be null terminated.
        ;   rsi (s2) - Source string. Should be null terminated.
        ; Returns:
        ;   rax - Pointer to the destination string (s1).

        xor rcx, rcx                        ; Initialize rcx counter to 0 via XOR operation.
                                            ;   It will be used as a common incrementor.

                                            ; rdi is set through variable (s1). 64-bit.
                                            ; rsi is set through variable (s2). 64-bit.

    .loop:
        mov rax, qword [rsi + rcx]          ; Load 8 bytes from source into RAX. RCX is used as common index.
        mov qword [rdi + rcx], rax          ; Store loaded bytes in destination. RCX is used as common index.
        test rax, rax                       ; Check if null-byte (end of string) reached.
        je .end                             ; If null-byte found, jump to .end.
        cmp byte [rsi + rcx + 7], 0         ; Verify if last byte of chunk is zero (this means null-byte is found).
        je  .end                            ; If yes, jump to .end.
        add rcx, 8                          ; Move index 8 bits forward.
        jmp .loop                           ; Jump to .loop unconditionaly              

    .end:
        mov rax, rdi                        ; Move destination pointer to rax.
        ret                                 ; Return length stored in rax (default).