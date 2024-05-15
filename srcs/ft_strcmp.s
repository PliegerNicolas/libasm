section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_strcmp

    ; Information on ft_strcmp.
        ; Arguments:
        ;   RDI - Pointer/Address to targeted null-terminated string in memory. String to compare (s1) with.
        ;   RSI - Pointer/Address to targeted null-terminated string in memory. String to compare (s2) to.
        ; Returns:
        ;   RAX - An integer who's sign represents equality. (pos => s1 > s2. neg => s1 < s2. zero => s1 == s2).

ft_strcmp:

    ; ft_strcmp initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

        xor         rax, rax                    ; Set rax to 0 through XOR operation. Will be common string index and ultimately will contain the final result.
        pxor        xmm5, xmm5                  ; Set xmm5 to 0 through XOR operation. It will be compared to, to find position of null-bytes.
        pcmpeqb     xmm6, xmm6                  ; Fill xmm7 with 1 through comparison with itself. It will be used to reproduce NOT's behaviour with a XOR operation.

    ; ft_strcmp start.
    .loop:

    ; Find null bytes.
        movdqu      xmm0, [rdi + rax]           ; Move 16-bytes (128-bits) to xmm0. Accounting the address contained in rdi and the rax offset.
        movdqu      xmm1, [rsi + rax]           ; Move 16-bytes (128-bits) to xmm1. Accounting the address contained in rsi and the rax offset.
        pcmpeqb     xmm0, xmm5                  ; Compare xmm0 and xmm5 byte/byte. Result stored in xmm0. Common characters (null-bytes) are represented by 0xFF and discrepencies as 0x00.
        pcmpeqb     xmm1, xmm5                  ; Compare xmm1 and xmm5 byte/byte. Result stored in xmm1. Common characters (null-bytes) are represented by 0xFF and discrepencies as 0x00.
        por         xmm0, xmm1                  ; Merge xmm0 and xmm1. This merges together the positions of xmm0 and xmm1's null-bytes.
        ; xmm0 now contains the position of null-bytes as 0xFF.

        pmovmskb    ecx, xmm0                   ; Move MSB of xmm0's 16 bytes to cx (ecx's 16 lowest bytes). pmovmskb expects a 32 bit register but we'll use half of it.
        tzcnt       cx, cx                      ; Count number of trailing zeros (valid characters/bytes before finding a null byte).

    ; Find discrepent bytes.
        movdqu      xmm1, [rdi + rax]           ; Move 16-bytes (128-bits) to xmm1. Accounting the address contained in rdi and the rax offset.
        movdqu      xmm2, [rsi + rax]           ; Move 16-bytes (128-bits) to xmm2. Accounting the address contained in rsi and the rax offset.
        pcmpeqb     xmm1, xmm2                  ; Compare xmm1 and xmm2 byte/byte. Result stored in xmm1. Common characters are represented by 0xFF and discrepencies as 0x00.
        pxor        xmm1, xmm6                  ; Not xmm1 through XOR operation with xmm6 filled with ones.
        ; xmm1 now contains the position of discrepent bytes as 0xFF.

        pmovmskb    edx, xmm1                   ; Move MSB of xmm1's 16 bytes to dx (edx's 16 lowest bytes). pmovmskb expects a 32 bit register but we'll use half of it.
        tzcnt       dx, dx                      ; Count number of trailing zeros (valid characters/bytes before finding a discrepency).

        cmp         dx, cx                      ; Compare cx and dx.
        cmovl       cx, dx                      ; Store the smallest value in cx.
        add         rax, rcx                    ; Add the smallest computed length (cx through rcx) to rax.
        sub         rcx, 16                     ; Substitute 16 from rcx.
        jz          .loop                       ; If 0, it means that no null bytes or discrepencies have been found. A new iteration of the loop is triggered by jump to .loop.

    ; Calculate output.
        movzx       rcx, byte [rsi + rax]       ; Move byte in rcx and sign extend (s2's char/byte).
        movzx       rax, byte [rdi + rax]       ; Move byte in rax and sign extend (s1's char/byte).
        sub         rax, rcx                    ; Substitute rax with rcx.

    ; Normalize output.
        test        rax, rax                            ; Check if RAX is 0.
        jz          .end                                ; If RAX is 0, jump to .end.
        mov         rax, 1                              ; Set RAX to 1.
        jns         .end                                ; If not signed, jump to .end
        neg         rax                                 ; Negate RAX.

    .end:
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; This implementation of strcmp has similar performances to the original clib strcmp.
; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.