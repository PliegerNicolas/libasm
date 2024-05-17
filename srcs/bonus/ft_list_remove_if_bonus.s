section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    extern  free
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

        sub         rsp, 64                     ; Allocate 64 bytes in stack (8 bytes * 8).
        mov         [rbp - 24], rdi             ; Store dual-pointer to list's head-node. This will represent DUAL-PTR HEAD-NODE.
        mov         rax, [rdi]                  ; Store in rax dereferenced rdi.
        mov         [rbp - 64], rax             ; Set to rax. This will represent HEAD-NODE. 
        mov         [rbp - 56], rax             ; Set to rax. This will represent CURRENT-NODE.
        mov         rax, [rax + 8]              ; Set rax to current-node->next ([rax + 8]).
        mov         [rbp - 48], rax             ; Set to rax. This will represent NEXT-NODE.
        mov         qword [rbp - 40], 0         ; Set to 0. This will represent PREVIOUS-NODE.
        mov         [rbp - 32], rsi             ; Store pointer to REFERENCE_DATA.
        mov         [rbp - 16], rdx             ; Store pointer to 'CMP' FUNCTION.
        mov         [rbp - 8], rcx              ; Store pointer to 'FREE_FCT' FUNCTION.

    ; ft_list_remove_if start.

        test        rdi, rdi                    ; Check if rdi (dual-pointer to head-node) is 0x0 (null).
        jz          .end                        ; If rdi (dual-pointer to head-node) is 0x0 (null), jump to .end.

    .loop:
        mov         rdi, [rbp - 56]             ; Store current-node in rdi.
        test        rdi, rdi                    ; Check if rdi (current-node) is 0 (null).
        jz          .end                        ; If current-node is null (zero flag set), jump to .end.

        mov         rsi, [rdi + 8]              ; Store in rsi current-node->next ([rdi + 8]).
        mov         [rbp - 48], rsi             ; Store rsi (current-node->next) in next-node.

    .compare:
        ; cmp: { args: [rdi contains data, rsi data to compare to], ret: [rax is set to the comparison value as int] }
        mov         rsi, [rdi + 0]              ; As rdi as previously been set to current-node ... Set rsi to current-node->data (rdi + 0).
        mov         rdi, [rbp - 32]             ; Set rdi to reference_data.
        call        [rbp - 16]                  ; Call 'cmp' function. /!\ This function call invalidates potentially every callee-saved register.
        mov         rdi, [rbp - 56]             ; Set rdi to current-node.
        test        rax, rax                    ; Check if rax is 0/null ('cmp's output). If rax is 0, we consider equality.
        jz          .delete_node                ; If equality (zero flag set), jump to .delete_node.
    
    .next_node:
        mov         [rbp - 40], rdi             ; Set previous-node to rdi (current-node).
        mov         rdi, [rdi + 8]              ; Set rdi to current-node->next ([rdi + 8]).
        mov         [rbp - 56], rdi             ; Set current-node to rdi (next-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .delete_node:
        ; free_fct: { args: [rdi contains the data to free], ret: [rax is undefined] }
        mov         rdi, [rdi + 0]              ; Set rdi to current-node->data (rdi + 0), as requested by 'free_fct'
        call        [rbp - 8]                   ; Call 'free_fct'. /!\ This function call invalidates potentially every callee-saved register.
        ; free: { args: [rdi contains the data to free], ret: [rax is undefined] }
        mov         rdi, [rbp - 56]             ; Set rdi to current-node
        call        free wrt ..plt              ; Call _free.

        mov         rdi, [rbp - 48]             ; Set rdi to next-node.
        mov         [rbp - 56], rdi             ; Set current-node to rdi (next-node).
        mov         rsi, [rbp - 40]             ; Set rsi to previous-node.
        test        rsi, rsi                    ; Check if previous-node is 0/null.
        jz          .set_head_node              ; If previous-node is null (zero flag set), jump to .set_head_node.
        mov         [rsi + 8], rdi              ; Set [rsi + 8] (previous-node->next) to rdi (current-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .set_head_node:
        mov         [rbp - 64], rdi             ; Set head-node to rdi (current-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .end:
        mov         rcx, [rbp - 24]             ; Set rcx to dual-pointer to list's head-node.
        mov         rdi, [rbp - 64]             ; Set rdi to head-node.
        mov         [rcx], rdi                  ; Store head-node of list in at dereferenced rdi.
        xor         rax, rax                    ; Set rax to 0. Function returns void so we set it at 0x0 (null).
        add         rsp, 64                     ; Liberate allocated 64 bytes from stack.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.