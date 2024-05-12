align 16
global ft_strlen                    ; entry-point for linker.

    ft_strlen:
        ; Arguments:
        ;   rdi - Pointer to start of null-terminated string.
        ; Returns:
        ;   rax - Length of the string excluding null terminator.

    .initialization:
        xor         rax, rax            ; Set RAX to 0 through XOR operation.
        xor         rcx, rcx            ; Set ECX to 0 through XOR operation.

    .loop:
        movdqu      xmm0, [rdi]         ; Move 16-bytes (128-bits) of dereferenced RSI to XMM0.
        add         rdi, 16             ; Move RDI 16 bytes forward for next loop.

        pxor        xmm1, xmm1          ; Set XMM1 to 0 through XOR operation.
        pcmpeqb     xmm1, xmm0          ; Compare XMM0 with XMM1, byte/byte. If equal XMM1 is filled with 0xFF, else 0x00
        
        pmovmskb    ecx, xmm1           ; Move the MSB of each byte to ECX. ECX is 32bytes so only the 16 LSB are affected, the rest is set to 0.
        or          ecx, 0xFFFF0000     ; Set the MSB of each byte of ECX to 1 to ensure only 16 0 can be found per read later on by TZCNT.

        tzcnt       ecx, ecx            ; Count 0 from LSB to MSB.
        add         rax, rcx            ; Add ECX (through RCX) to RAX

        sub         rcx, 16             ; Substract 16 from rcx. It no null bytes have been found it sets RCX to 0.
        jz          .loop               ; If RCX is 0, jump to .loop

    .end:
        ret