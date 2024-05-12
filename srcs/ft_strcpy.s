align 16
global ft_strcpy                            ; Entry-point for linker.

    ft_strcpy:
        ; Arguments:
        ;   rdi (s1) - Destination buffer. Should be of sufficiant size to contain s2 and be null terminated.
        ;   rsi (s2) - Source string. Should be null terminated.
        ; Returns:
        ;   rax - Pointer to the destination string (s1).

        mov         rax, rdi                ; Store RDI's pointer address in RAX. It will get returned.
        xor         rbx, rbx                ; Set RBX to 0 through XOR operation. Common index to s1 and s2.

    .ft_strcpy_loop:
        movdqu      xmm0, [rsi + rbx]       ; Load 16 bytes from RSI (source string) offsetted by RBX.

        pxor        xmm1, xmm1              ; Set XMM1 to 0 through XOR operation.
        pcmpeqb     xmm1, xmm0              ; Compare byte/byte XMM0 with XMM1. Common bytes are set to 0xFF (1), else 0x00 (0).
                                            ;   XMM1 now contains position of XMM0's null bytes (as 1/0xFF).
        pmovmskb    ecx, xmm1               ; Store per byte MSB of XMM1 in ECX's 16 lowest bits.
        test        ecx, 0xFFFF
        jz          .copy_16_bytes          ; If there is a null byte in ECX/XMM1/XMM0, jump to .1.

    .copy_remaining_bytes:
        mov         dl, [rsi + rbx]
        mov         [rdi + rbx], dl
        inc         rbx
        test        dl, dl
        jnz         .copy_remaining_bytes
        ret

    .copy_16_bytes:
        movdqu      [rdi + rbx], xmm0       ; Copy XMM0 in RDI, offsetted by RBX.
        add         rbx, 16                 ; Increment RBX by 16.
        jmp         .ft_strcpy_loop         ; Jump unconditionaly to .ft_strcpy_loop.

; The real strcpy is just a bit faster. The difference grows the bigger the string. Even with SMID instructions.