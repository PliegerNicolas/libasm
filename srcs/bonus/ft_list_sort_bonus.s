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

ft_list_sort:                                       ; This function is intended for recursion.
    ; ft_list_sort initialization.
        endbr64                                     ; AMD specific branch prediction hint.
        push        rbp                             ; Push previous base pointer on top of stack.
        mov         rbp, rsp                        ; Setup base pointer to current top of the stack.

    ; Allocate memory on stack for local variables. This function is intended for recursivity. /!\ Possibility of stack overflow. Careful.
        sub         rsp, ALLOC_LIST                 ; Allocate memory on stack.
        mov         [rbp - CMP_FNC], rsi            ; Store in stack the 'cmp' function pointer.
        mov         [rbp - SRC_HEAD_NODE], rdi      ; Store in stack reference to head-node (t_list **begin_list).
        mov         rax, [rdi]                      ; Derefrence rdi and store it in rax.
        mov         [rbp - LEFT_HALF], rax          ; Stores the address to the left half of the list.
        mov         qword [rbp - RIGHT_HALF], 0x0   ; Stores the address to the right half of the list.
        mov         [rbp - HEAD_NODE], rax          ; Stores the pointer to the head of the list.

    ; ft_list_sort start.
        ; Test for base case of recursive function.
        test        rdi, rdi                        ; Check if rdi (**begin_list) is defined (not 0x0/null).
        jz          .end                            ; If zero flag set (previous condition met), jump to .end
        test        rax, rax                        ; Check if rax (*begin_list) is defined (not 0x0/null).
        jz          .end                            ; If zero flag set (previous condition met), jump to .end
        mov         rax, [rax]                      ; Check if rax (begin_list->next) is defined (not 0x0/null).
        jz          .end                            ; If zero flag set (previous condition met), jump to .end

        ; ft_list_split: { args: [rdi = t_list *source, rsi = t_list **left_half, rdx = t_list **right_half], ret: [rax is undefined] }
        lea         rsi, [rbp - 24]                 ; Set rsi to the effective address of left_half (equivalent of &left_half in c).
        lea         rdx, [rbp - 16]                 ; Set rdx to the effective address of right_half (equivalent of &right_half in c).
        mov         rdi, [rdi]                      ; Dereference the source list (*begin_list).
        call        ft_list_split                   ; Call 'ft_list_split'.

        ; ft_list_sort: { args: [rdi = t_list **head-of-sublist, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        ; ft_list_sort: { args: [rdi = t_list **head-of-sublist, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        ; ft_list_merge: { args: [rdi = t_list *head-of-left-sublist, rsi = t_list *head-of-right-sublist, rdx = ptr/addr of 'cmp' function], ret: [rax is set to head-node of merged list] }

    .end:
        add         rsp, ALLOC_LIST             ; Deallocate memory on stack.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

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
        endbr64                                     ; AMD specific branch prediction hint.
        push        rbp                             ; Push previous base pointer on top of stack.
        mov         rbp, rsp                        ; Setup base pointer to current top of the stack.

        sub         rsp, ALLOC_SPLIT                ; Allocate memory on stack.
        mov         [rsp - FAST_NODE], rdi          ; Store in stack source as fast-node.
        mov         qword [rsp - SLOW_NODE], 0x0    ; Store in stack 0x0 as slow-node.

        ; Initial check.
        mov         rax, rdi                        ; Store source in rax.
        test        rax, rax                        ; Check if source is 0x0 (null).
        jz          .end                            ; If zero flag set (if null), jump to .end.
        mov         rax, [rax + NODE_NEXT]          ; Move rax (source) forward (source->next).
        test        rax, rax                        ; Check if source->next is 0x0 (null).
        jz          .end                            ; If zero flag set (if null), jump to .end.

        mov         [rsp - SLOW_NODE], rax          ; Set slow-node to source->next.
        mov         rax, [rax + NODE_NEXT]          ; Move rax forward (source->next->next).
        mov         [rsp - FAST_NODE], rax          ; Set fast-node to source->next->next.

    ; ft_list_split start.
        ; Move fast-node forward.

    .loop:
        mov         rax, [rsp - FAST_NODE]          ; Store fast-node in rax.
        test        rax, rax                        ; Test if rax (fast-node) is 0x0 (null).
        jz          .end                            ; If zero flag set (if null), jump to .end.
        mov         rax, [rax + NODE_NEXT]          ; Move rax (fast-node) forward.
        test        rax, rax                        ; Test if rax (fast-node->next) is 0x0 (null).
        jz          .end                            ; If zero flag set (if null), jump to .end.
        mov         [rsp - FAST_NODE], rax          ; Store fast-node back in reference to left-half.

        ; Move slow-node forward.
        mov         rax, [rsp - SLOW_NODE]          ; Store last-node in rax.
        mov         rax, [rax + NODE_NEXT]          ; Move rax (last-node) forward.
        mov         [rsp - SLOW_NODE], rax          ; Update slow-node.

    .end:
        mov         [rsi], rdi                      ; Store source in reference to left-half.
        mov         rax, [rsp - SLOW_NODE]          ; Set rax to slow-node.
        mov         rax, [rax + NODE_NEXT]          ; Move rax (slow-node) forward once to retrieve the start node of the right-half.
        mov         [rdx], rax                      ; Store slow-node in reference to right-half.

        ; temp tester.
        ;mov         qword [rdi + NODE_DATA], 0x0
        ;mov         qword [rax + NODE_DATA], 0x0
        ; temp

        add         rsp, ALLOC_SPLIT                ; Deallocate memory on stack.
        pop         rbp                             ; Restore previous base pointer and remove it from the top of the stack.
        ret                                         ; Return (by default expects the content of rax).

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
        endbr64                                     ; AMD specific branch prediction hint.
        push        rbp                             ; Push previous base pointer on top of stack.
        mov         rbp, rsp                        ; Setup base pointer to current top of the stack.

    ; ft_list_merge start.

    .end:
        xor         rax, rax                        ; Set rax to 0 through XOR operation. Function returns null, so we return 0x0/null.
        pop         rbp                             ; Restore previous base pointer and remove it from the top of the stack.
        ret                                         ; Return (by default expects the content of rax).



section .data
    NODE_DATA           equ     0           ; Shift to retrieve data's value from dereferenced node pointer.
    NODE_NEXT           equ     8           ; Shift to retrieve next's value from dereferenced node pointer.

    ALLOC_LIST          equ     48          ; Bytes to allocate for ft_list_sort.
    ALLOC_SPLIT         equ     16          ; Bytes to allocate for ft_list_split.

    CMP_FNC             equ     40          ; Stack shift for pointer to 'cmp' function.
    SRC_HEAD_NODE       equ     32          ; Stack shift for reference to pointer to source-head-node.
    LEFT_HALF           equ     24          ; Stack shift to left-half-node pointer.
    RIGHT_HALF          equ     16          ; Stack shift to right-half-node pointer.
    HEAD_NODE           equ     8           ; Stack shift to head-node pointer.

    FAST_NODE           equ     8           ; Stack shift for fast-node for fast-slow floyd-warshall algorithm.
    SLOW_NODE           equ     16          ; Stack shift for fast-node for fast-slow floyd-warshall algorithm.