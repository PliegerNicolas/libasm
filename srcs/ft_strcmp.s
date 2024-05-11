global ft_strcmp                            ; Entry-point for linker.

    ft_strcmp:
        ; Arguments:
        ;   rdi (s1) - First string to compare with. Not aligned by default.
        ;   rsi (s2) - Second string to compare with. Not aligned by default.
        ; Returns:
        ;   rax - An negative integer is s1 is less than s2. 0 if equal. A positive integer if s1 is more than s2.

    .initialize:
        xor         rbx, rbx            ; Set RBX to 0 through XOR operation. Used as common index for strings.
        xor         rcx, rcx            ; Set RDX to 0 through XOR operation. Used as storage for null byte index.
        xor         rdx, rdx            ; Set RCX to 0 through XOR operation. Used as storage for discrepent character index.

        pxor        xmm2, xmm2          ; Set XMM2 to 0 through XOR operation.
        pxor        xmm3, xmm3          ; Set XMM3 to 0 through XOR operation.

    .load_data:
        movdqu      xmm0, [rdi + rbx]   ; Copy in XMM0 the next 16 bytes (128 bits) of RDI.
        movdqu      xmm1, [rsi + rbx]   ; Copy in XMM1 the next 16 bytes (128 bits) of RSI.

    .find_next_null_byte:
        pxor        xmm2, xmm2          ; Set XMM2 to 0 through XOR operation.
        pxor        xmm3, xmm3          ; Set XMM3 to 0 through XOR operation.
        pcmpeqb     xmm2, xmm0          ; Compare byte/byte XMM0 and XMM2. Common values are set to 0xFF, else 0x00.
        pcmpeqb     xmm3, xmm1          ; Compare byte/byte XMM1 and XMM3. Common values are set to 0xFF, else 0x00.
        pandn       xmm2, xmm3
        pmovmskb    ecx, xmm3           ; Assign the MSB of each byte of XMM2 to the lower 16 bits of ECX.
        or          ecx, 0xFFFF0000     ; Set 16 most significant bits of ECX to 1 so maximum value of bsf is 16 due
                                        ;   to ECX size being 32 bits.
        bsf         ecx, ecx            ; Get index of first set bit (found 0).

    .find_next_discrepancy:
        movdqu      xmm3, xmm0          ; Copy XMM0 in XMM3.
        pcmpeqb     xmm3, xmm1          ; Compare byte/byte XMM1 and XMM3. Common values are set to 0xFF, else 0x00.
        pmovmskb    edx, xmm3           ; Store MSB of XMM3 in ECX's 16 lowest bits.
        not         edx                 ; invert ECX's bits.
        bsf         edx, edx            ; Find the index of the first set bit.

    .check_indexes:
        cmp         edx, ecx            ; Compare EDX with ECX.
        cmovl       ecx, edx            ; If EDX is less than ECX, move EDX to ECX.
        cmp         ecx, 16             ; Check if ECX is smaller than 16 (no discrepency or null byte found).
        jl          .end                ; If both indexes are not set to 0, jump to .calculate_difference.

    .loop:
        add         rbx, 16             ; Increment RBX by 16 bytes to move forward with the strings.
        jmp         .load_data          ; Jump to load_data and restart the loop.

    .end:
        add         rbx, rcx            ; Add up RBX and RCX to get index of characters to compare.
        movzx       rax, byte [rdi + rbx]
        movzx       rcx, byte [rsi + rbx]
        sub         rax, rcx
        ret