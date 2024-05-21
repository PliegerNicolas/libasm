section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_size

    ; Information on ft_list_size.
        ; Arguments:
        ;   RDI - Pointer/address to head-node of list.
        ; Returns:
        ;   RAX - Length of list.

ft_list_size:

    ; ft_list_size initialization.
        endbr64                                 ; Branch prediction hint (control flow enforcement technology).
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

        xor         rax, rax                    ; Set rax to 0 through XOR operation. It will be the node counter.

    ; ft_list_size start.
        test        rdi, rdi                    ; Verify if rdi is not a null byte (0x0).
        jz          .end                        ; If null byte, jump to .end directly (rax == 0).

    .loop:
        inc         rax                         ; Increment the counter/rax by 1.
        mov         rdi, [rdi + 0x8]            ; Retrieve content of list->next situated 8 bytes further.
        test        rdi, rdi                    ; Check if null-byte found.
        jnz         .loop                       ; If null-byte not found, jump to .loop.

    .end:
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.