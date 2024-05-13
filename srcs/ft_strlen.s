align 16
global ft_strlen                    ; entry-point for linker.

    ft_strlen:
        ; Arguments:
        ;   rdi - Pointer to start of null-terminated string.
        ; Returns:
        ;   rax - Length of the string excluding null terminator.

        xor         rax, rax            ; Set RAX to 0 through XOR operation. Counter of valid bytes/chars an return value.
        test        rdi, rdi            ; If RDI is set to NULL
        jz          .end                ; Jump to .end

    .ft_strlen_loop:
        movdqu      xmm0, [rdi + rax]   ; Move 16-bytes (128-bits) of dereferenced RSI to XMM0. Offset with RAX (already counted characters).
        pcmpeqb     xmm1, xmm0          ; Compare byte/byte XMM0 with XMM1 and store result in XMM1. 0xFF is set if common character found, else 0x0.
                                        ;   Now, XMM1 represents the null bytes of XMM0 at respective byte positions. 0xFF means 0x0. 0x0 means other.
        pmovmskb    ecx, xmm1           ; Store MSB of each byte of XMM1 in ECX's lowest bits (CL). If ECX is 0, ZeroFlag is set.
        or          ecx, 0xFFFF0000     ; Set the MSB of each byte of ECX to 1 to ensure bsf sets ECX to 16 if no 1 (0xFF) has been found.
        tzcnt       ecx, ecx            ; Count trailing zeros from LSB to MSB. It is faster than bsf.
        add         rax, rcx            ; Increment RAX with the result of bsf (ECX through RCX).
        sub         rcx, 16             ; Remove 16 from ECX. If 0, it means 16 characters where counted.
        jz          .ft_strlen_loop     ; If zero flag set, jump to .ft_strlen_loop.

    .end:
        ret