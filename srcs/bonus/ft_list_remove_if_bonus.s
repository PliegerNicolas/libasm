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
        jz          .return                     ; If rdi (dual-pointer to head-node) is 0x0 (null), jump to .return.
        test        rdx, rdx                    ; Check if rdx ('cmp' function ptr) is 0x0 (null).
        jz          .return                     ; If rdx ('cmp' function ptr) is 0x0 (null), jump to .return.
        test        rcx, rcx                    ; Check if rcx ('free_fct' function ptr) is 0x0 (null).
        jz          .return                     ; If rcx ('free_fct' function ptr) is 0x0 (null), jump to .return.

        sub         rsp, 64                     ; Allocate 64 bytes in stack (8 bytes * 8).
        mov         [rbp - SRC_HEAD_NODE], rdi  ; Set SOURCE_HEAD_NODE pointer in stack. This is a pointer to the pointer to the list's head-node.
        mov         rax, [rdi]                  ; Store in rax dereferenced rdi (dual pointer to list's head-node).
        mov         [rbp - HEAD_NODE], rax      ; Set HEAD_NODE pointer in stack through rax. 
        mov         [rbp - CURR_NODE], rax      ; Set CURRENT_NODE pointer in stack through rax. 
        mov         rax, [rax + NODE_NEXT]      ; Set rax to current-node->next.
        mov         [rbp - NEXT_NODE], rax      ; Set NEXT_NODE pointer in stack through rax (current-node->next).
        mov         qword [rbp - PREV_NODE], 0  ; Set PREVIOUS_NODE pointer in stack. Set it as null because there is no previous-node at initialization.
        mov         [rbp - REF_DATA], rsi       ; Set REFERENCE_DATA pointer in stack through rsi.
        mov         [rbp - CMP_FNC], rdx        ; Set CMP_FUNCTION's pointer in stack through rdx.
        mov         [rbp - FREE_FCT_FNC], rcx   ; Set FREE_FCT_FUNCTION's pointer in stack through rcx.

    ; ft_list_remove_if start.
    .loop:
        mov         rdi, [rbp - CURR_NODE]      ; Store CURRENT_NODE in rdi.
        test        rdi, rdi                    ; Check if rdi (current-node) is 0 (null).
        jz          .end                        ; If current-node is null (zero flag set), jump to .end.

        mov         rsi, [rdi + NODE_NEXT]      ; Store in rsi current-node->next ([rdi + NODE_NEXT]).
        mov         [rbp - NEXT_NODE], rsi      ; Set NEXT_NODE in stack through rsi (current-node->next).

    .compare:
        ; cmp: { args: [rdi contains data, rsi data to compare to], ret: [rax is set to the comparison value as int] }
        mov         rsi, [rdi + NODE_DATA]      ; As rdi as previously been set to current-node ... Set rsi to current-node->data (rdi + NODE_DATA).
        mov         rdi, [rbp - REF_DATA]       ; Set rdi to REFERENCE_DATA.
        call        [rbp - CMP_FNC]             ; Call 'cmp' function. /!\ This function call invalidates potentially every callee-saved register.
        mov         rdi, [rbp - CURR_NODE]      ; Set rdi to CURRENT_NODE.
        test        rax, rax                    ; Check if rax is 0x0 (null) ('cmp's output). If rax is 0, we consider equality.
        jz          .delete_node                ; If equality (zero flag set), jump to .delete_node.
    
    .next_node:
        mov         [rbp - PREV_NODE], rdi      ; Set PREVIOUS_NODE to rdi (current-node).
        mov         rdi, [rdi + NODE_NEXT]      ; Set rdi to current-node->next ([rdi + NODE_NEXT]).
        mov         [rbp - CURR_NODE], rdi      ; Set CURRENT_NODE to rdi (next-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .delete_node:
        ; free_fct: { args: [rdi contains the data to free], ret: [rax is undefined] }
        mov         rdi, [rdi + NODE_DATA]      ; Set rdi to current-node->data (rdi + NODE_DATA), as requested by 'free_fct'
        call        [rbp - FREE_FCT_FNC]        ; Call 'free_fct'. /!\ This function call invalidates potentially every callee-saved register.
        ; free: { args: [rdi contains the data to free], ret: [rax is undefined] }
        mov         rdi, [rbp - CURR_NODE]      ; Set rdi to CURRENT_NODE, as requested by 'free'.
        call        free wrt ..plt              ; Call _free.

        mov         rdi, [rbp - NEXT_NODE]      ; Set rdi to NEXT_NODE.
        mov         [rbp - CURR_NODE], rdi      ; Set CURRENT_NODE to rdi (next-node).
        mov         rsi, [rbp - PREV_NODE]      ; Set rsi to PREVIOUS_NODE.
        test        rsi, rsi                    ; Check if previous-node is 0x0 (null).
        jz          .set_head_node              ; If previous-node is null (zero flag set), jump to .set_head_node.
        mov         [rsi + NODE_NEXT], rdi      ; Set [rsi + NODE_NEXT] (previous-node->next) to rdi (current-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .set_head_node:
        mov         [rbp - HEAD_NODE], rdi      ; Set HEAD_NODE to rdi (current-node).
        jmp         .loop                       ; Jump unconditionally to .loop.

    .end:
        mov         rcx, [rbp - SRC_HEAD_NODE]  ; Set rcx to dual-pointer to SOURCE_HEAD_NODE.
        mov         rdi, [rbp - HEAD_NODE]      ; Set rdi to HEAD_NODE.
        mov         [rcx], rdi                  ; Store rcx (head-node) at dereferenced rdi.
        add         rsp, 64                     ; Liberate allocated 64 bytes from stack.

    .return:
        xor         rax, rax                    ; Set rax to 0. Function returns void so we set it at 0x0 (null).
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

section .data
    NODE_DATA       equ     0                   ; Shift to retrieve data's value from dereferenced node pointer.
    NODE_NEXT       equ     8                   ; Shift to retrieve next's value from dereferenced node pointer.

    SRC_HEAD_NODE   equ     24                  ; Represents stack shift for the pointer that points to the original head-node.
    HEAD_NODE       equ     64                  ; Represents stack shift for head-node.
    CURR_NODE       equ     56                  ; Represents stack shift for current-node pointer.
    NEXT_NODE       equ     48                  ; Represents stack shift for next-node pointer.
    PREV_NODE       equ     40                  ; Represents stack shift for prevous-node pointer.
    REF_DATA        equ     32                  ; Represents stack shift for ref_data pointer.
    CMP_FNC         equ     16                  ; Represents stack shift for cmp function pointer.
    FREE_FCT_FNC    equ     8                   ; Represents stack shift for free_fct function pointer.

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.