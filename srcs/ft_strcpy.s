align   16
global  ft_strcpy   ; Entry-point for linker.

    ft_strcpy:
        ; Arguments:
        ;   rdi (s1) - Destination buffer. Should be of sufficiant size to contain s2 and it's terminator null byte.
        ;   rsi (s2) - Source string. Should be null terminated.
        ; Returns:
        ;   rax - Pointer to the destination string (copy of original rdi).

        xor         rcx, rcx                ; Set rcx to 0 through XOR operation. Used as common string offset index.

    .sse_loop:
        movdqu      xmm0, [rsi + rcx]       ; Move 16 bytes (128 bits) of data from RSI + offset RCX to XMM0.
        pxor        xmm1, xmm1              ; Set XMM1 to 0 through XOR operation. Will be used to check 0x0 in XMM0.
        pcmpeqb     xmm1, xmm0              ; Compare byte/byte XMM0 with XMM1 and store result in XMM1. 0xFF is set if common character found, else 0x0.
                                            ;   Now, XMM1 represents the null bytes of XMM0 at respective byte positions. 0xFF means 0x0. 0x0 means other.
        pmovmskb    edx, xmm1               ; Store MSB of each byte of XMM1 in EDX's 16 lowest bits (DX). If EDX is 0, ZeroFlag is set.
        test        dx, dx                  ; Add test DX, DX for branch prediction optimization. Could be removed.
        jnz         .byte_loop              ; If ECX not 0, jump to .byte_loop.

        movdqu      [rdi + rcx], xmm0       ; Copy XMM0 in RDI, with RCX offset.
        add         rcx, 16                 ; Increment RCX by 16 bytes.
        jmp         .sse_loop               ; Jump unconditionally to .sse_loop.

    .byte_loop:
        mov         dl, byte [rsi + rcx]    ; Copy the first byte of RSI at offset RCX in DL.
        mov         byte [rdi + rcx], dl    ; Copy DL to RDI at corresponding (RCX offset) position.
        inc         rcx                     ; Increment RCX by 1 byte (to check next character).
        test        dl, dl                  ; Verify if DL is set as null byte (0x0).
        jnz         .byte_loop              ; If DL is not null, jump to .byte_loop.
        ret                                 ; Return RAX, containing the pointer address to RDI.

; My implementation is a bit slower than the original. Specifically on long strings. I can't figure out why. Maybe branch prediction optimization ? But not in a significant amount.