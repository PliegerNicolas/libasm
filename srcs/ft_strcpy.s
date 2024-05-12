align 16
global ft_strcpy                            ; Entry-point for linker.

    ft_strcpy:
        ; Arguments:
        ;   rdi (s1) - Destination buffer. Should be of sufficiant size to contain s2 and be null terminated.
        ;   rsi (s2) - Source string. Should be null terminated.
        ; Returns:
        ;   rax - Pointer to the destination string (s1).

        mov     rax, rdi                ; Store RDI (s1 pointer adr) in RAX so it can get returned.
        xor     rcx, rcx                ; Set RCX to 0 through XOR operation. Will be used as common string index.
        pxor    xmm0, xmm0              ; Set XMM0 to 0. Upper 8 bytes should be set to 0 because we only use quadwords.

    .qword_loop:
        movq        xmm0, [rsi + rcx]   ; Move quadword (8bytes) to lower 8 bytes of XMM0.
        pxor        xmm1, xmm1          ; Set XMM1 to 0.
        pcmpeqb     xmm1, xmm0          ; Compare byte/byte XMM0 with XMM1 (null). Common values are set to 0xFF (1), else 0x00 (0).
                                        ;   XMM1 now contains positions of XMM0's null bytes (as 1/0xFF).
        pmovmskb    ebx, xmm1           ; Store per byte MSB of XMM0 in EBX's 16 lowest bits.
        test        bl, bl              ; Check if BL (2 lowest bytes of RBX) is 0. This means no null bytes are found.
        jnz         .byte_loop          ; If false. Jump to .null_byte_found. This is explicit.

        movq        [rdi + rcx], xmm0   ; Move stored 8 bytes in RDI to copy characters.
        add         rcx, 8              ; Increment RCX by 8 bytes.
        jmp         .qword_loop         ; Jump to .loop unciditonally.

    .byte_loop:
        mov     bl, byte [rsi + rcx]    ; Store first char/byte of [rsi] with offset RCX in BL.
        mov     byte [rdi + rcx], bl    ; Copy character in RDI at relative position.
        inc     rcx                     ; Increment RCX (common index).
        test    bl, bl                  ; Verify if null byte not reached (BL).
        jnz     .byte_loop              ; If no jump byte found, jump to .null_byte_found.

    .end:
        ret

; Using qword for bulk data copying. Could use SSE. Easy to implement. This is slower than the origian strcpy the longer the strings are.