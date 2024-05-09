global ft_strcmp                            ; Entry-point for linker.

    ft_strcmp:
        ; Arguments:
        ;   rdi (s1) - First string to compare with. Not aligned by default.
        ;   rsi (s2) - Second string to compare with. Not aligned by default.
        ; Returns:
        ;   rax - An negative integer is s1 is less than s2. 0 if equal. A positive integer if s1 is more than s2.

        ; Initialize counter
        xor rax, rax                        ; Initialize return value to 0 through XOR operation,
                                            ;   who is sometimes more efficient than mov.
        xor rcx, rcx                        ; Set rcx to 0 via XOR operation.
                                            ;   It will be used as a common incrementor.

                                            ; rdi is set through variable (s1). 64-bit.
                                            ; rsi is set through variable (s2). 64-bit.

        .loop:
            mov al, [rdi + rcx]                 ; Store the character into a 8-bit register (al)
            mov bl, [rsi + rcx]                 ; Store the character into a 8-bit register (bl)
            cmp al, bl                          ; Compare the first characters of rdi and rsi, stored in al and bl.
            jne .end                            ; If not equal, jump to .end.
            cmp al, 0                           ; Verify if rdi's current (al) character is 0 (null byte).
                                                ;   We check if al and bl are equal so it technically also tests bl.
            je .end                             ; If equal, jump to end.
            inc rcx                             ; Increment the common incrementor value (rdi++ & rsi++)
            jmp .loop                           ; Jump to .loop unconditionaly

    .end:
        sub al, bl                              ; Substitute bl from al.
        movsx   rax, al                         ; Move with sign extension 'padding'. It moves from a smaller to a bigger
                                                ;   register (8-bit to 64-bit) without altering the original value or it's sign.
        ret                                     ; Return length stored in rax (default).