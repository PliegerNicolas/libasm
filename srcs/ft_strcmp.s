align 16
global ft_strcmp                            ; Entry-point for linker.

    ft_strcmp:
        ; Arguments:
        ;   rdi (s1) - First string to compare with. Not aligned by default.
        ;   rsi (s2) - Second string to compare with. Not aligned by default.
        ; Returns:
        ;   rax - An negative integer is s1 is less than s2. 0 if equal. A positive integer if s1 is more than s2.

    .initialize:
        xor         rbx, rbx                            ; Set RBX to 0 through XOR operation. Common string reading index.
        xor         rcx, rcx                            ; Set RCX to 0 through XOR operation. Temporary storage for discrepency index.

    .loop:
        movdqu      xmm0, [rdi + rbx]                   ; Store 16bytes (128bits) of RDI in XMM0. RBX is offset.
        movdqu      xmm1, [rsi + rbx]                   ; Store 16bytes (128bits) of RSI in XMM1. RBX is offset.
        movdqu      xmm2, xmm0                          ; Copy XMM0 in XMM2.
        movdqu      xmm3, xmm1                          ; Copy XMM1 in XMM3.
        pxor        xmm4, xmm4                          ; Set XMM4 to 0 through XOR operation.

        pcmpeqb     xmm0, xmm1                          ; Compare byte/byte XMM0 with XMM2. Common bytes are set to 0xFF (1), else 0x00 (0).
                                                        ;   XMM0 now contains position of common bytes (as 1/0xFF) between XMM0 and XMM1.

        pcmpeqb     xmm2, xmm4                          ; Compare byte/byte XMM2 (XMM0's copy) with XMM4 (null). Common values are set to 0xFF (1), else 0x00 (0).
                                                        ;   XMM2 now contains positions of XMM0's null bytes (as 1/0xFF).
        pcmpeqb     xmm3, xmm4                          ; Compare byte/byte XMM3 (XMM1's copy) with XMM4 (null). Common values are set to 0xFF (1), else 0x00 (0).
                                                        ;   XMM3 now contains positions of XMM0's null bytes (as 1/0xFF).
        por         xmm2, xmm3                          ; Mix XMM2 and XMM3's 1/0xFF store them in XMM2 through OR operation.
                                                        ;   XMM2 now contains the position of the null bytes of XMM0 and XMM1 (as 1/0xFF).

        ; Execute XMM equivalent of NOT operation on XMM2.
        pcmpeqb     xmm4, xmm4                          ; Fill XMM4 with 1 by comparison with itself.
        pxor        xmm2, xmm4                          ; Perform NOT operation through XOR on a XMM4 (1 filled XMM).
                                                        ;   xmm2 now contains the position of the valid characters, excluding null bytes,
                                                        ;   of XMM0 and XMM1 (as 1/0xFF).

        pand        xmm0, xmm2                          ; AND operation on XMM0 and XMM2. Remove null bytes from XMM0.
                                                        ;   XMM0 now contains the position of valid common bytes (as 1/0xFF) between original XMM0 and XMM1.

        pmovmskb    ecx, xmm0                           ; Store per byte MSB of XMM0 in ECX's 16 lowest bits.
        not         ecx                                 ; Invert ECX's bits for usage with BSF.
        bsf         ecx, ecx                            ; Bit scan ECX forward until 1 is found. This retrieve the index on the 16 bytes of the discrepent character.

        add         rbx, rcx                            ; Add ECX (through RCX) to RGB.
        cmp         ecx, 16                             ; Compare ECX to 16.
        je          .loop                               ; Jump to .loop if equal.

    .calc_output:
        movzx       rax, byte [rdi + rbx]               ; Set in RAX target byte's value, padded with 0s.
        movzx       rbx, byte [rsi + rbx]               ; Set in RBX target byte's value, padded with 0s.
        sub         rax, rbx                            ; Substitute RAX with RBX.

    .normalize_output:
        test        rax, rax                            ; Check if RAX is 0.
        jz          .end                                ; If RAX is 0, jump to .end.
        mov         rax, 1                              ; Set RAX to 1.
        jns         .end                                ; If not signed, jump to .end
        neg         rax                                 ; Negate RAX.

    .end:
        ret                                             ; Return RAX.