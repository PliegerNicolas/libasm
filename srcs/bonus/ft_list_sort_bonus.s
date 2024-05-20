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

        test        rdi, rdi                                ; Check if rdi is 0x0 (null) through AND operation.
        jz          .end                                    ; If zero flag set, jump to .end.

        mov         rax, [rdi]                              ; Dereference rdi and store the result in rax: rax = *begin_list.
        mov         [rbp - LEFT_HALF], rax                  ; Store *begin_list (rax) as left-half in stack.
        mov         qword [rbp - RIGHT_HALF], 0x0           ; Set right-half as 0x0 (null) in stack for the time being.

    ; Recursivity: Check for base case ((*begin_list) == NULL || (*begin_list)->next == NULL). This means there are <= 1 nodes left.
        test        rax, rax                                ; Check if rax (*begin_list) is 0x0 (null) through AND operation.
        jz          .end                                    ; If zero flag set, jump to .end.
        mov         rax, [rax + NODE_NEXT]                  ; Move rax one node forward (rax = (*begin_list)->next).
        test        rax, rax                                ; Check if rax ((*begin_list)->next) is 0x0 (null) through AND operation.
        jz          .end                                    ; If zero flag set, jump to .end.

    ; ft_list_sort start.       
        ; ft_list_split: { args: [rdi = t_list *source, rsi = t_list **left_half, rdx = t_list **right_half], ret: [rax is undefined] }
        mov         rdi, [rbp - LEFT_HALF]                  ; Set rdi to *begin_list (has it has been stored in left-half). As requested by 'ft_list_split'.
        lea         rsi, [rbp - LEFT_HALF]                  ; Load effective address of left-half (eq. to &left-half). As requested by 'ft_list_split'.
        lea         rdx, [rbp - RIGHT_HALF]                 ; Load effective address of left-half (eq. to &right-half). As requested by 'ft_list_split'.
        call        ft_list_split                           ; Call 'ft_list_split'.

        mov         rax, [rsi]                              ; Retrieve pointer contained in rsi (*left_half).
        mov         [rbp - LEFT_HALF], rax                  ; Update left-half's head-node pointer.
        mov         rax, [rdx]                              ; Retrieve pointer contained in rdx (*right_half).
        mov         [rbp - RIGHT_HALF], rax                 ; Update right-half's head-node pointer.

        ; ft_list_sort: { args: [rdi = t_list **head-of-sublist, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        lea         rdi, [rbp - LEFT_HALF]                  ; Load effective address of left-half (eq. &left-half) to rdi. As requested by 'ft_list_sort'.
        mov         rsi, [rbp - CMP_FNC]                    ; Set rsi to pointer to cmp function. As requested by 'ft_sit_sort'.
        call        ft_list_sort                            ; Call recursivly 'ft_list_sort'.

        ; ft_list_sort: { args: [rdi = t_list **head-of-sublist, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        lea         rdi, [rbp - RIGHT_HALF]                 ; Load effective address of right-half (eq. &right-half) to rdi. As requested by 'ft_list_sort'.
        mov         rsi, [rbp - CMP_FNC]                    ; Set rsi to pointer to cmp function. As requested by 'ft_sit_sort'.
        call        ft_list_sort                            ; Call recursivly 'ft_list_sort'.

        ; ft_list_merge: { args: [rdi = t_list *head-of-left-sublist, rsi = t_list *head-of-right-sublist, rdx = ptr/addr of 'cmp' function], ret: [rax is set to head-node of merged list] }

    .end:
        ; TEMP
        ;mov         rdi, [rbp - SRC_HEAD_NODE]              ; Restore rdi to source-head-node.
        ;mov         rax, [rsi]                              ; merge will return ptr in rax so this line is not usefull.
        ;mov         [rdi], rax
        ; TEMP

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
        ;   RDI - Pointer/address to source head-node.
        ;   RSI - Reference to pointer/address of left-half head-node. Present so ft_list_split can return the values through those pointers.
        ;   RDX - Reference to pointer/address of right-half head-node. Present so ft_list_split can return the values through those pointers.
        ; Returns:
        ;   RAX - NULL

ft_list_split:
    ; ft_list_split initialization.
        endbr64                                         ; AMD specific branch prediction hint.
        push        rbp                                 ; Push previous base pointer on top of stack.
        mov         rbp, rsp                            ; Setup base pointer to current top of the stack. 

    ; Allocate memory on stack for local variables.
        sub         rsp, ALLOC_SPLIT                    ; Allocate memory on stack.
        mov         [rsp - FAST_NODE], rdi              ; Set fast-node in stack as source.
        mov         qword [rsp - SLOW_NODE], 0x0        ; Set slow-node in stack as source.

        mov         [rsi], rdi                          ; Set *left-half to source systematically.

    ; Check for base-case
        test        rdi, rdi                            ; Check if rdi (source) is 0x0 (null) through AND operation.
        jz          .return                             ; If zero flag set, jump to .end.

        mov         rax, [rdi + NODE_NEXT]              ; Move rdi one node forward (rax = source->next).
        test        rax, rax                            ; Check if rax (source->next) is 0x0 (null) through AND operation.
        jz          .return                             ; If zero flag set, jump to .end.

    ; ft_list_split start.
        mov         [rsp - FAST_NODE], rax              ; Set source->next as fast-node in stack.
        mov         [rsp - SLOW_NODE], rdi              ; Set slow-node to source in stack. At this point slow and fast nodes are == source.

    .loop:
        ; Move fast-node forward
        mov         rax, [rsp - FAST_NODE]              ; Retrieve current fast-node from stack.
        test        rax, rax                            ; Check if current fast-node is 0x0 (null).
        jz          .end                                ; If zero flag set, jump to .end.
        mov         rax, [rax + NODE_NEXT]              ; Move fast-node forward by one node (fast-node = fast-node->next).
        test        rax, rax                            ; Check if current fast-node->next is 0x0 (null).
        jz          .end                                ; If zero flag set, jump to .end.
        mov         rax, [rax + NODE_NEXT]              ; Move fast-node forward by one node (fast-node = fast-node->next->next).
        mov         [rsp - FAST_NODE], rax              ; Update fast-node in stack.

        ; Move slow-node forward.
        mov         rax, [rsp - SLOW_NODE]              ; Retrieve current slow-node from stack.
        mov         rax, [rax + NODE_NEXT]              ; Move it one node forward (slow-node = slow-node->next) unconditionally.
                                                        ;   At initialization source existance is already checked. Else fast-node handles checks.
        mov         [rsp - SLOW_NODE], rax              ; Update slow-node in stack.

        jmp         .loop                               ; Jump unconditionally to .loop.

    .end:
        mov         rcx, [rsp - SLOW_NODE]              ; Set rcx to slow-node.
        mov         rax, rcx                            ; Copy rcx to rax.
        mov         rax, [rax + NODE_NEXT]              ; Move rax forward (rax = slow-node->next).
        mov         qword [rcx + NODE_NEXT], 0x0        ; Remove reference to slow-node->next from slow-node, setting slow-node->next to 0x0 (null). Slow-node->next's ptr is preserved in rax.
        mov         [rsp - SLOW_NODE], rax              ; Update slow-node with rax, the preserve slow-node->next ptr.

        ; Set data to null for testing purpose.
        ;mov         qword [rax + NODE_DATA], 0x0
        ;mov         qword [rdi + NODE_DATA], 0x0

    .return:
        ;           [rsi], source                       ; It has already been set earlier to source. Cheers mate.
        mov         rax, [rsp - SLOW_NODE]              ; Set rax to current slow-node.
        mov         [rdx], rax                          ; Set *right-half to current slow-node.

        xor         rax, rax                            ; Set rax to 0x0 (null) through XOR operation. Function returns void either way.
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

    ALLOC_LIST          equ     32          ; Bytes to allocate for ft_list_sort.
    ALLOC_SPLIT         equ     16          ; Bytes to allocate for ft_list_split.

    CMP_FNC             equ     32          ; Stack shift for pointer to 'cmp' function.
    SRC_HEAD_NODE       equ     24          ; Stack shift for reference to pointer to source-head-node.
    LEFT_HALF           equ     16          ; Stack shift to left-half-node pointer.
    RIGHT_HALF          equ     8           ; Stack shift to right-half-node pointer.

    FAST_NODE           equ     8           ; Stack shift for fast-node for fast-slow floyd-warshall algorithm.
    SLOW_NODE           equ     16          ; Stack shift for fast-node for fast-slow floyd-warshall algorithm.