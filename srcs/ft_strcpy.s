align   16
global  ft_strcpy   ; Entry-point for linker.

    ft_strcpy:

        xor         rbx, rbx                ; Set RBX to 0 through XOR operation. Used as common string offset index.

    .sse_loop:
        movdqu      xmm0, [rsi + rbx]       ; Move 16 bytes (128 bits) of data from RSI + offset RBX to XMM0.
        pxor        xmm1, xmm1              ; Set XMM1 to 0 through XOR operation. Will be used to check 0x0 in XMM0.
        pcmpeqb     xmm1, xmm0              ; Compare byte/byte XMM0 with XMM1 and store result in XMM1. 0xFF is set if common character found, else 0x0.
                                            ;   Now, XMM1 represents the null bytes of XMM0 at respective byte positions. 0xFF means 0x0. 0x0 means other.
        pmovmskb    ecx, xmm1               ; Store MSB of each byte of XMM1 in ECX's 16 lowest bits (CX). If ECX is 0, ZeroFlag is set.
        test        cx, cx                  ; Add test CX, CX for branch prediction optimization. Could be removed.
        jnz         .byte_loop              ; If ECX not 0, jump to .byte_loop.

        movdqu      [rdi + rbx], xmm0       ; Copy XMM0 in RDI, with RBX offset.
        add         rbx, 16                 ; Increment RBX by 16 bytes.
        jmp         .sse_loop               ; Jump unconditionally to .sse_loop.

    .byte_loop:
        mov         cl, byte [rsi + rbx]    ; Copy the first byte of RSI at offset RBX in CL.
        mov         byte [rdi + rbx], cl    ; Copy CL to RDI at corresponding (RBX offset) position.
        inc         rbx                     ; Increment RBX by 1 byte (to check next character).
        test        cl, cl                  ; Verify if CL is set as null byte (0x0).
        jnz         .byte_loop              ; If CL is not null, jump to .byte_loop.
        ret                                 ; Return RAX, containing the pointer address to RDI.

; My implementation is a bit slower than the original. Specifically on long strings. I can't figure out why. Maybe branch prediction optimization ? But not in a significant amount.