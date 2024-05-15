section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_strlen

    ; Information on ft_strlen.
        ; Arguments:
        ;   RDI - Pointer/Address to target null-terminated string (s) in memory.
        ; Returns:
        ;   RAX - Contains the length of the string, null-byte excluded.

ft_strlen:

    .initialization:
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_strlen start.
        xor             rax, rax                ; Set rax to 0 througb XOR operation. It will contain the result and serve as offset (counter valid character bytes).
        pxor            xmm1, xmm1              ; Set xmm1 to 0 through XOR operation. It will be used compare it with xmm0 and check for null-bytes.

    .loop:
        movdqu          xmm0, [rdi + rax]       ; Move 16-bytes (128-bits) to XMM0. Accounting the address contained in RDI and the rax offset.
                                                ; Here I am using SSE (SMID) to read 16 character per 16 characters.
        pcmpeqb         xmm1, xmm0              ; Compare byte per byte XMM0 with XMM1. If common byte found (null byte), set 0xFF else 0x00.
        pmovmskb        ecx, xmm1               ; Move MSB of XMM1's 16 bytes to CX (ECX's 16 lowest bytes). pmovmskb expects a 32 bit register but we'll use half of it.
        tzcnt           cx, cx                  ; Count until first found non null-byte from LSB to MSB in cx.
        jnc             .end                    ; If carry-out flag not set, jump to .end. CF is et when tzcnt hits the end of cx.
        add             rax, 16                 ; Add 16 bytes (length of XMM0).
        jmp             .loop                   ; Jump unconditionally to .loop.

    .end:
        add         rax, rcx                    ; Add the remaining read bytes contained in rcx/cx to rax.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of RAX).

; This implementation of ft_strlen has similar performances to the original clib strlen.
; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.