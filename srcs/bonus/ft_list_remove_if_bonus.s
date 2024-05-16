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

        push        rbx                         ; Push rbx to stack to preserve it's data (callee-saved).
        push        r12                         ; Push r12 to stack to preserve the hold data (callee-saved).
        push        r13                         ; Push r13 to stack to preserve the hold data (callee-saved).
        push        rdi                         ; Push rdi to stack to preserve the dual pointer to the list.

        mov         rbx, rdi                    ; rbx holds the address of the dual pointer to the head node of the list.

        mov         r11, [rdi]                  ; r11 holds the pointer to the head-node of the list.
        mov         r10, [rdi]                  ; r10 holds the pointer to the current-node.
        xor         r9, r9                      ; Set r9 to 0x0 through XOR operation. r9 holds pointer to next-node. It doesn't exist yet at initialization.
        xor         r8, r8                      ; Set r8 to 0x0 through XOR operation. r8 holds pointer to previous-node. It doesn't exist yet at initialization.
        mov         r12, rdx                    ; r12 holds pointer to 'cmp' function.
        mov         r13, rcx                    ; r13 holds pointer to 'free_fct' function.

    ; ft_list_remove_if start.
    .loop:
        test        r10, r10                    ; Check if current-node(r10) is defined (not null/0x0).
        jz          .end                        ; If current-node null/0x0, jump to .end. 
        mov         r9, [r10 + 0x8]             ; Store current-node(r10)->next in next-node(r9).

    .compare:
        ; cmp: { args: [rdi contains data, rsi data to compare to], ret: [rax is set to the comparison value as int] }
        mov         rdi, [r10 + 0x0]            ; Store current-node(r10)'s data in rdi as requested by 'cmp'.
        push        rsi                         ; Push rsi to stack to preserve it.
        call        r12                         ; Call 'cmp' function through it's stored pointer in r12.
        pop         rsi                         ; Restore rsi.
        test        rax, rax                    ; Verify the output of 'cmp'.
        jz          .equality_found             ; If rax is 0x0, it means an equality has been found between current-node(r10)->data and ref_data.
        mov         r8, r10                     ; Move current-node(r10) to previous-node(r8).
        mov         r10, r9                     ; move next-node(r9) to current-node(r10).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .equality_found:
        ; free_fct: { args: [rdi contains the data to free], ret: [rax is undefined] }
        mov         rdi, [r10 + 0x0]            ; Move current-node(r10)->data to rdi as requested by 'free_fct'.
        call        r13                         ; Call 'free_fct' function through it's stored pointer in r13.
        test        r8, r8                      ; Check if previous-node(r8) is defined (not null/0x0).
        jz          .update_head_node           ; If previous-node(r8) is null/0x0, link current-node(r9) to head-node(r11) instead.
        mov         [r8 + 0x8], r9              ; Move next-node(r9) to previous-node(r8)->next.
        jmp         .loop                       ; Jump to .loop unconditionally.

    .update_head_node:
        mov         [r11 + 0x8], r9             ; Move current-node(r9) to head-node(r11)->next.
        jmp         .loop                       ; Jump to .loop unconditionally.

    .end:
        pop         rdi                         ; Restore rdi.
        ; Set next head pointer in rdi: mov rdi, [head_ptr].
        pop         r13                         ; Restore r13.
        pop         r12                         ; Restore r12.
        pop         rbx                         ; Restore rbx.
    
    .return:
        xor         rax, rax                    ; Set rax to 0x0 through XOR operation because function returns void.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.