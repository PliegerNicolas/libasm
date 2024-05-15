section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_strcpy

    ; Information on ft_strcpy.
        ; Arguments:
        ;   RDI - Pointer/Address to targeted buffer. Pointer to copy the data to.
        ;   RSI - Pointer/Address to targeted null-terminated string in memory. Source pointer/string to copy the data from.
        ; Returns:
        ;   RAX - Pointer/address to the destination string (copy of original rdi).

ft_strcpy:

    ; ft_strcpy initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

        push        rax                         ; Push rax to stack to preserve it.
        xor         rax, rax                    ; Set rax to 0 through XOR operation. Used as common string offset index.

    ; ft_strcpy start.
    .sse_loop:
        movdqu      xmm0, [rsi + rax]           ; Move 16 bytes (128 bits) of data from rsi + offset rax to xmm0.
        pxor        xmm1, xmm1                  ; Set xmm1 to 0 through XOR operation. Will be used to check 0x0 in xmm0.
        pcmpeqb     xmm1, xmm0                  ; Compare byte/byte xmm0 with xmm1 and store result in xmm1. 0xFF is set if common character found, else 0x0.
                                                ;   Now, xmm1 represents the null bytes of xmm0 at respective byte positions. 0xFF means 0x0. 0x0 means other.
        pmovmskb    edx, xmm1                   ; Store msb of each byte of xmm1 in edx's 16 lowest bits (dx). If edx is 0, ZeroFlag is set.
        test        dx, dx                      ; Add test dx, dx for branch prediction optimization. Could be removed.
        jnz         .byte_loop                  ; If ecx not 0, jump to .byte_loop.

        movdqu      [rdi + rax], xmm0           ; Copy xmm0 in rdi, with rax offset.
        add         rax, 16                     ; Increment rax by 16 bytes.
        jmp         .sse_loop                   ; Jump unconditionally to .sse_loop.

    .byte_loop:
        mov         dl, byte [rsi + rax]        ; Copy the first byte of RSI at offset rax in dl.
        mov         byte [rdi + rax], dl        ; Copy dl to rdi at corresponding (rax offset) position.
        inc         rax                         ; Increment rax by 1 byte (to check next character).
        test        dl, dl                      ; Verify if dl is set as null byte (0x0).
        jnz         .byte_loop                  ; If dl is not null, jump to .byte_loop.

    .end:
        pop         rax                         ; Restore rax
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; /!\ This implementation of strcpy has slower performances to the original clib strcpy. /!\
; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.