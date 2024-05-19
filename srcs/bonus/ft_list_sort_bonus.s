section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_sort
    global  ft_merge_sort

    ; Information on ft_list_sort.
        ; Arguments:
        ;   RDI - Dual pointer/address to head-node of list.
        ;   RSI - Pointer/address to 'cmp' function.
        ; Returns:
        ;   RAX - NULL

ft_list_sort:                                               ; This function is intended for recursion.
    ; ft_list_sort initialization.
        endbr64                                             ; AMD specific branch prediction hint.
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Allocate memory on stack for local variables. This function is intended for recursivity. /!\ Possibility of stack overflow. Careful.
        sub         rsp, ALLOC_LIST                         ; Allocate memory on stack.
        mov         [rbp - CMP_FNC], rsi                    ; Store in stack the 'cmp' function pointer.
        mov         [rbp - SRC_HEAD_NODE], rdi              ; Store in stack reference to head-node (t_list **begin_list).

        test        rdi, rdi                                ; Test if begin_list is 0x0 (null).
        jz          .end                                    ; If begin_list is null, jump to .end.

        mov         rax, [rdi]                              ; Derefrence rdi (*begin_list) and store it in rax.
        mov         [rbp - LEFT_HALF], rax                  ; Stores the address to the left half of the list.
        mov         qword [rbp - RIGHT_HALF], 0x0           ; Stores the address to the right half of the list.
        mov         [rbp - HEAD_NODE], rax                  ; Stores the pointer to the head of the list.

    ; ft_list_sort start.
        ; Test for base case of recursive function.
        test        rax, rax                                ; Test if *begin_list is 0x0 (null).
        jz          .end                                    ; If *begin_list is null, jump to .end.
        mov         rax, [rax + NODE_NEXT]                  ; Mode rax forward by one node ((*begin_list)->next).
        test        rax, rax                                ; Test if next node is 0x0 (null).
        jz          .end                                    ; If *begin_list is null, jump to .end.
        
        ; ft_list_split: { args: [rdi = t_list *source, rsi = t_list **left_half, rdx = t_list **right_half], ret: [rax is 0 (base-case reached)] }
        mov         rdi, [rbp - HEAD_NODE]                  ; Set rdi to current head-node, as requested by 'ft_list_split'.
        lea         rsi, [rbp - 24]                         ; Set rsi to the effective address of left_half (equivalent of &left_half in c), as requested by 'ft_list_split'.
        lea         rdx, [rbp - 16]                         ; Set rdx to the effective address of right_half (equivalent of &right_half in c), as requested by 'ft_list_split'.
        call        ft_list_split                           ; Call 'ft_list_split'.

        ; ft_list_sort: { args: [rdi = t_list **head-of-sublist, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        ; ft_list_sort: { args: [rdi = t_list **head-of-sublist, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        ; ft_list_merge: { args: [rdi = t_list *head-of-left-sublist, rsi = t_list *head-of-right-sublist, rdx = ptr/addr of 'cmp' function], ret: [rax is set to head-node of merged list] }

    .end:
        mov         rdi, [rbp - SRC_HEAD_NODE]              ; Restore original rdi (source-head-node).
        ; Pass to rdi value of current head-node.
        xor         rax, rax                                ; Set rax to 0 through XOR operation. Function returns void so we set 0x0 (null).
        add         rsp, ALLOC_LIST                         ; Deallocate memory on stack.
        pop         rbp                                     ; Restore previous base pointer and remove it from the top of the stack.
        ret                                                 ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                          ft_list_split                           ; ;;;
;;; ; ================================================================ ; ;;;

section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_split

    ; Information on ft_list_split.
        ; Arguments:
        ;   RDI - Pointer/address to source (head-node of source list).
        ;   RSI - Pointer/address to ptr/addr of head-node of left half.
        ;   RDX - Pointer/address to ptr/addr of head-node of right half.
        ; Returns:
        ;   RAX - NULL

ft_list_split:
    ; ft_list_split initialization.
        endbr64                                         ; AMD specific branch prediction hint.
        push        rbp                                 ; Push previous base pointer on top of stack.
        mov         rbp, rsp                            ; Setup base pointer to current top of the stack.

    ; Allocate memory on stack for local variables.
        sub         rsp, ALLOC_SPLIT                    ; Allocate memory on stack.
        mov         [rsp - FAST_NODE], rdi              ; Store in stack source as fast-node.
        mov         qword [rsp - SLOW_NODE], 0          ; Store in stack 0x0 as slow-node.
        mov         qword [rsp - BASE_CASE_REACHED], 0  ; Store in stack 0x0 as base-case reached status (by default: yes/0).

    ; Initial check.
        test        rdi, rdi                            ; Check if source is 0x0 (null).
        jz          .end                                ; If zero flag set (if null), jump to .end.
        mov         rax, [rdi + NODE_NEXT]              ; Move rax (source) forward (source->next).
        test        rax, rax                            ; Check if source->next is 0x0 (null).
        jz          .end                                ; If zero flag set (if null), jump to .end.
        not         qword [rsp - BASE_CASE_REACHED]     ; Invert bits of base-case in stack (0 => -1).

        mov         [rsp - SLOW_NODE], rax              ; Set slow-node to source->next.
        mov         rax, [rax + NODE_NEXT]              ; Move rax forward (source->next->next).
        mov         [rsp - FAST_NODE], rax              ; Set fast-node to source->next->next.

    ; ft_list_split start.
    .loop:
        ; Move fast-node forward.
        mov         rax, [rsp - FAST_NODE]              ; Set rax to current fast-node.
        test        rax, rax                            ; Check if current fast-node == 0x0 (null).
        jz          .end                                ; If zero flag set (if null), jump to .end.
        mov         rax, [rax + NODE_NEXT]              ; Move current fast-node forward (fast-node->next).
        test        rax, rax                            ; Check if current fast-node->next == 0x0 (null).
        jz          .end                                ; If zero flag set (if null), jump to .end.
        mov         rax, [rax + NODE_NEXT]              ; Move current fast-node forward (fast-node->next->next).
        mov         [rsp - FAST_NODE], rax              ; Update fast-node.

        ; Move slow-node forward.
        mov         rax, [rsp - SLOW_NODE]              ; Set rax to current slow-node.
        mov         rax, [rax + NODE_NEXT]              ; Move current slow-node forward.
        mov         [rsp - SLOW_NODE], rax              ; Update slow-node.

        jmp         .loop                               ; Jump unconditionally to .loop.

    .end:
        ; Setup return values.
        mov         [rsi], rdi                          ; Set reference to left-half (*left-half) to source.
        mov         rax, [rsp - SLOW_NODE]              ; Set rax to current slow-node.
        mov         rcx, rax                            ; Copy slow-node (rax) to rcx.
        mov         rcx, [rcx + NODE_NEXT]              ; Move rcx forward (slow-node->next).
        mov         qword [rax + NODE_NEXT], 0          ; Set slow-node->next to 0x0 (null) to break link between left-half and right-half.
        mov         [rdx], rcx                          ; Set reference to right-half (*right-half) to rcx (slow-node->next).
        mov         rax, [rsp - BASE_CASE_REACHED]      ; Set rax to base-case status.

        add         rsp, ALLOC_SPLIT                    ; Deallocate memory on stack.
        pop         rbp                                 ; Restore previous base pointer and remove it from the top of the stack.
        ret                                             ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                          ft_list_merge                           ; ;;;
;;; ; ================================================================ ; ;;;

section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_merge

    ; Information on ft_list_split.
        ; Arguments:
        ;   RDI - Pointer/address to head-node of first list.
        ;   RSI - Pointer/address to head-node of second list.
        ;   RDX - Pointer/address of 'cmp' function.
        ; Returns:
        ;   RAX - Pointer/address of new merged head-node.

ft_list_merge:
    ; ft_list_merge initialization.
        endbr64                                         ; AMD specific branch prediction hint.
        push        rbp                                 ; Push previous base pointer on top of stack.
        mov         rbp, rsp                            ; Setup base pointer to current top of the stack.

    ; ft_list_merge start.

    .end:
        xor         rax, rax                            ; Set rax to 0 through XOR operation. Function returns null, so we return 0x0/null.
        pop         rbp                                 ; Restore previous base pointer and remove it from the top of the stack.
        ret                                             ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                              data                                ; ;;;
;;; ; ================================================================ ; ;;;

section .data
    NODE_DATA           equ     0           ; Shift to retrieve data's value from dereferenced node pointer.
    NODE_NEXT           equ     8           ; Shift to retrieve next's value from dereferenced node pointer.

    ALLOC_LIST          equ     48          ; Bytes to allocate for ft_list_sort.
    ALLOC_SPLIT         equ     24          ; Bytes to allocate for ft_list_split.

    CMP_FNC             equ     40          ; Stack shift for pointer to 'cmp' function.
    SRC_HEAD_NODE       equ     32          ; Stack shift for reference to pointer to source-head-node.
    LEFT_HALF           equ     24          ; Stack shift to reference to left-half-node pointer.
    RIGHT_HALF          equ     16          ; Stack shift to reference to right-half-node pointer.
    HEAD_NODE           equ     8           ; Stack shift to head-node pointer.

    FAST_NODE           equ     8           ; Stack shift for fast-node for fast-slow floyd-warshall algorithm.
    SLOW_NODE           equ     16          ; Stack shift for fast-node for fast-slow floyd-warshall algorithm.
    BASE_CASE_REACHED   equ     24          ; Stack shift for ft_list_split output (status if base case has been reached or not).