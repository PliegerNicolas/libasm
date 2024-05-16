section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_remove_if

    ; Information on ft_list_remove_if.
        ; Arguments:
        ;   RDI - Dual pointer/address to head-node of list.
        ;   RSI - Reference data to compare to.
        ;   RDX - Pointer to passed comparison function.
        ;           cmp: { args: [rdi contains data, rsi data to compare to], ret: [rax is set to the comparison value as int] }
        ;   RCX - Pointer to passed data free function.
        ;           free_fct: { args: [rdi contains the data to free], ret: [rax is undefined] }
        ; Returns:
        ;   RAX - NULL.

ft_list_remove_if:

    ; ft_list_remove_if initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

        test        rdi, rdi                    ; Verify if rdi is not null (0x0).
        jz          .return                     ; If zero flag set, jump to .return.

        push        rbx                         ; Push rbx to stack to preserve it's data.
        push        rdi                         ; push rdi to stack to preserve the dual pointer to the list.

        mov         rbx, rdi                    ; rbx holds the address of the dual pointer to the head node of the list.

        mov         r11, [rdi]                  ; r11 holds the pointer to the head-node of the list.
        mov         r10, [rdi]                  ; r10 holds the pointer to the current-node.
        xor         r9, r9                      ; Set r9 to 0x0 through XOR operation. r9 holds pointer to next-node. It doesn't exist yet at initialization.
        xor         r8, r8                      ; Set r8 to 0x0 through XOR operation. r8 holds pointer to previous-node. It doesn't exist yet at initialization.
        mov         rdx, rdx                    ; rdx holds pointer to 'cmp' function.
        mov         rcx, rcx                    ; rcx holds pointer to 'free_fct' function.

    ; ft_list_remove_if start.
    .loop:
        mov         r9, [r10 + 0x8]             ; Store current-node(r10)->next in next-node(r9).


    .end:
        pop         rdi                         ; Restore rdi.
        ; Set next head pointer in rdi: mov rdi, [head_ptr].
        pop         rbx                         ; Restore rbx.
    
    .return:
        xor         rax, rax                    ; Set rax to 0x0 through XOR operation because function returns void.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.