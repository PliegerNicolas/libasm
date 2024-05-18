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

        test        rdi, rdi                    ; Check if rdi (dual-pointer to head-node) is 0x0 (null).
        jz          .return                        ; If rdi (dual-pointer to head-node) is 0x0 (null), jump to .return.
        test        rdx, rdx                    ; Check if rdx ('cmp' function ptr) is 0x0 (null).
        jz          .return                        ; If rdx ('cmp' function ptr) is 0x0 (null), jump to .return.
        test        rcx, rcx                    ; Check if rcx ('free_fct' function ptr) is 0x0 (null).
        jz          .return                        ; If rcx ('free_fct' function ptr) is 0x0 (null), jump to .return.

        sub         rsp, 64                     ; Allocate 64 bytes in stack (8 bytes * 8).
        mov         [rbp - SRC_HEAD_NODE], rdi  ; Store dual-pointer to list's head-node in stack. This will represent DUAL-PTR HEAD-NODE.
        mov         rax, [rdi]                  ; Store in rax dereferenced rdi.
        mov         [rbp - HEAD_NODE], rax      ; Store rax in stack. This will represent HEAD-NODE. 
        mov         [rbp - CURR_NODE], rax      ; Store rax in stack. This will represent CURRENT-NODE.
        mov         rax, [rax + 8]              ; Set rax to current-node->next ([rax + 8]).
        mov         [rbp - NEXT_NODE], rax      ; Store rax (current-node->next-node) to stack. This will represent NEXT-NODE.
        mov         qword [rbp - PREV_NODE], 0  ; Store 0 in stack. This will represent PREVIOUS-NODE.
        mov         [rbp - REF_DATA], rsi       ; Store pointer in stack. This will represent REFERENCE_DATA.
        mov         [rbp - CMP_FNC], rdx            ; Store pointer in stack. This will represent 'CMP-FUNCTION-PTR'.
        mov         [rbp - FREE_FCT_FNC], rcx       ; Store pointer in stack. This will represent 'FREE_FCT-FUNCTION-PTR'.

    ; ft_list_remove_if start.

    .loop:
        mov         rdi, [rbp - CURR_NODE]      ; Store current-node in rdi.
        test        rdi, rdi                    ; Check if rdi (current-node) is 0 (null).
        jz          .end                        ; If current-node is null (zero flag set), jump to .end.

        mov         rsi, [rdi + NEXT]           ; Store in rsi current-node->next ([rdi + NEXT]).
        mov         [rbp - NEXT_NODE], rsi      ; Store rsi (current-node->next) in next-node.

    .compare:
        ; cmp: { args: [rdi contains data, rsi data to compare to], ret: [rax is set to the comparison value as int] }
        mov         rsi, [rdi + DATA]           ; As rdi as previously been set to current-node ... Set rsi to current-node->data (rdi + DATA).
        mov         rdi, [rbp - REF_DATA]       ; Set rdi to reference_data.
        call        [rbp - CMP_FNC]             ; Call 'cmp' function. /!\ This function call invalidates potentially every callee-saved register.
        mov         rdi, [rbp - CURR_NODE]      ; Set rdi to current-node.
        test        rax, rax                    ; Check if rax is 0/null ('cmp's output). If rax is 0, we consider equality.
        jz          .delete_node                ; If equality (zero flag set), jump to .delete_node.
    
    .next_node:
        mov         [rbp - PREV_NODE], rdi      ; Set previous-node to rdi (current-node).
        mov         rdi, [rdi + NEXT]           ; Set rdi to current-node->next ([rdi + NEXT]).
        mov         [rbp - CURR_NODE], rdi      ; Set current-node to rdi (next-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .delete_node:
        ; free_fct: { args: [rdi contains the data to free], ret: [rax is undefined] }
        mov         rdi, [rdi + DATA]           ; Set rdi to current-node->data (rdi + DATA), as requested by 'free_fct'
        call        [rbp - FREE_FCT_FNC]        ; Call 'free_fct'. /!\ This function call invalidates potentially every callee-saved register.
        ; free: { args: [rdi contains the data to free], ret: [rax is undefined] }
        mov         rdi, [rbp - CURR_NODE]      ; Set rdi to current-node
        call        free wrt ..plt              ; Call _free.

        mov         rdi, [rbp - NEXT_NODE]      ; Set rdi to next-node.
        mov         [rbp - CURR_NODE], rdi      ; Set current-node to rdi (next-node).
        mov         rsi, [rbp - PREV_NODE]      ; Set rsi to previous-node.
        test        rsi, rsi                    ; Check if previous-node is 0/null.
        jz          .set_head_node              ; If previous-node is null (zero flag set), jump to .set_head_node.
        mov         [rsi + NEXT], rdi           ; Set [rsi + NEXT] (previous-node->next) to rdi (current-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .set_head_node:
        mov         [rbp - HEAD_NODE], rdi      ; Set head-node to rdi (current-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .end:
        mov         rcx, [rbp - 24]             ; Set rcx to dual-pointer to list's head-node.
        mov         rdi, [rbp - HEAD_NODE]      ; Set rdi to head-node.
        mov         [rcx], rdi                  ; Store head-node of list at dereferenced rdi.
        add         rsp, 64                     ; Liberate allocated 64 bytes from stack.

    .return:
        xor         rax, rax                    ; Set rax to 0. Function returns void so we set it at 0x0 (null).
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

section .data
    DATA            equ     0                   ; Shift to retrieve data's value from node.
    NEXT            equ     8                   ; Shift to retrieve next's value from node.

    SRC_HEAD_NODE   equ     24                  ; Represents stack shift for the pointer that points to the original head-node.
    HEAD_NODE       equ     64                  ; Represents stack shift for head-node.
    CURR_NODE       equ     56                  ; Represents stack shift for current-node pointer.
    NEXT_NODE       equ     48                  ; Represents stack shift for next-node pointer.
    PREV_NODE       equ     40                  ; Represents stack shift for prevous-node pointer.
    REF_DATA        equ     32                  ; Represents stack shift for ref_data pointer.
    CMP_FNC         equ     16                  ; Represents stack shift for cmp function pointer.
    FREE_FCT_FNC    equ     8                   ; Represents stack shift for free_fct function pointer.

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.