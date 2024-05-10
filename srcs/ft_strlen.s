global ft_strlen                    ; entry-point for linker.

    ft_strlen:
        ; Arguments:
        ;   rdi - Pointer to start of null-terminated string.
        ; Returns:
        ;   rax - Length of the string excluding null terminator.

        ; Initialize counter
        xor     rax, rax            ; Initialize return value to 0 through XOR operation,
                                    ;   who is sometimes more efficient than mov.

    .loop:                          ; Loop through string.
        movzx   rcx, byte [rdi + rax]
        test    rcx, rcx            ; Dereference and compare the first 
                                    ;   rdi byte with null terminator.
        jz      .end
        add     rax, 1
        jmp     .loop
    
    .end:
        ret                         ; Return length stored in rax (default).