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
        endbr64                                 ; Branch prediction hint (control flow enforcement technology).
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

        push        rax                         ; Push rax to stack to preserve it.
        xor         rax, rax                    ; Set rax to 0 through XOR operation. Used as common string offset index.

    .sse_loop:
        pxor            xmm1, xmm1              ; Set xmm0 to 0 through XOR operation. Used as null comparator to detect null-bytes.
        movdqu          xmm0, [rsi + rax]       ; Move 16-bytes (128-bits) to xmm0. Accounting the address contained in rdi and the rax offset.
        pcmpeqb         xmm1, xmm0              ; Compare byte per byte xmm0 with xmm1. Store result in xmm0. If common byte found (null byte), set 0xFF else 0x00.
        pmovmskb        ecx, xmm1               ; Move MSB of xmm1's 16 bytes to cx (ecx's 16 lowest bytes). pmovmskb expects a 32 bit register but we'll use half of it.
        tzcnt           cx, cx                  ; Count until first found non null-byte from LSB to MSB in cx.
        jnc             .byte_loop              ; If carry-out flag not set, jump to .byte_loop. CF is set when tzcnt hits the end of cx.
        movdqu          [rdi + rax], xmm0       ; Copy the 16 bytes contained in xmm0 to rdi accounting for rax offset.
        add             rax, 16                 ; Increment rax (common counter) by 16 bytes.
        jmp             .sse_loop               ; Jump unconditionally to .sse_loop.

    .byte_loop:
        mov             dl, byte [rsi + rax]    ; Store the current byte of rsi in dl.
        mov             byte [rdi + rax], dl    ; Mov the just store byte in dl to it's target position in rdi.
        inc             rax                     ; Increment the common index (rax) by 1 byte.
        test            dl, dl                  ; Verify if the just copied byte isn't a null byte.
        jnz             .byte_loop              ; If not a null-byte, jump to .byte_loop.

    .end:
        pop         rax                         ; Restore rax
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; /!\ This implementation of strcpy has slower performances to the original clib strcpy. /!\
; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.