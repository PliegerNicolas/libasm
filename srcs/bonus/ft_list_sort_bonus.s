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

        ; Save parameters on the stack. On each iteration (by recursion), more data is allocated on stack. /!\ This could cause a stack overflow.
        sub         rsp, ALLOCATED_BYTES            ; Allocate space on the stack for local variables.
        mov         [rbp - SRC_HEAD_NODE], rdi      ; Store in stack the pointer that holds the head-node's pointer to the passed list.
        mov         [rbp - CMP_FNC], rsi            ; Store in stack the pointer to 'cmp' function. (This data is copied on each iteration. But it's done for accessibility and stability).
        ; We do not initialize in stack left-half head-node pointer's contents. They will get modified later on.
        ; We do not initialize in stack right-half head-node pointer's contents. They will get modified later on.
        mov         rax, [rdi]                      ; Dereference rdi and store it in rax.
        mov         [rbp - CURRENT_HEAD_NODE], rax  ; Store current pointer to head-node in stack.

    ; ft_list_sort start.
        test        rdi, rdi                    ; Check if rdi is 0x0 (null).
        jz          .end                        ; If source head-node is 0x0 (null), jump to .end.

        test        rax, rax                    ; Check if rax is 0x0 (null).
        jz          .end                        ; If head-node is 0x0 (null), jump to .end.

        mov         rax, [rax + NODE_NEXT]      ; Set rax to head-node->next.
        test        rax, rax                    ; Check if rax is 0x0 (null).
        jz          .end                        ; If head-node is 0x0 (null), jump to .end.

        ; ft_list_split: { args: [rdi = t_list *source, rsi = t_list **left_half, rdx = t_list **right_half], ret: [rax is undefined] }
        mov         rdi, [rdi]                  ; Dereference rdi to retrieve the current head-node to split as requested by 'ft_list_split'.
        mov         rsi, [rbp - LEFT_HALF]      ; Set rsi to 't_list **left_half's memory location.
        mov         rdx, [rbp - RIGHT_HALF]     ; Set rdx to 't_list **right_half's memory location.
        call        ft_list_split               ; Call 'ft_list_split'.

        ; ft_list_sort: { args: [rdi = t_list **head-of-sublist, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        mov         rdi, [rbp - LEFT_HALF]      ; Set rdi to current left-half head-node as requested by 'ft_list_sort' recursion call.
        mov         rsi, [rbp - CMP_FNC]        ; Set rsi to pointer to 'cmp' function. It is passed through the recursive functions.
        call        ft_list_sort                ; Call 'ft_list_sort'.

        ; ft_list_sort: { args: [rdi = t_list **head-of-sublist, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        mov         rdi, [rbp - RIGHT_HALF]     ; Set rdi to current right-half head-node as requested by 'ft_list_sort' recursion call.
        mov         rsi, [rbp - CMP_FNC]        ; Set rsi to pointer to 'cmp' function. It is passed through the recursive functions.
        call        ft_list_sort                ; Call 'ft_list_sort'.

        ; ft_list_merge: { args: [rdi = t_list *head-of-left-sublist, rsi = t_list *head-of-right-sublist, rdx = ptr/addr of 'cmp' function], ret: [rax is set to head-node of merged list] }
        mov         rdi, [rbp - LEFT_HALF]      ; Set rdi to current left-half head-node as requested by 'ft_list_merge'.
        mov         rsi, [rbp - RIGHT_HALF]     ; Set rsi to current right-half head-node as requested by 'ft_list_merge'.
        mov         rdx, [rbp - CMP_FNC]        ; Set rdx to pointer to 'cmp' function.
        call        ft_list_merge               ; Call 'ft_list_merge'.

        mov         rdi, [rbp - SRC_HEAD_NODE]  ; Restore the source head-node pointer (t_list **begin_list).
        mov         [rdi], rax                  ; Pass the output pointer from ft_list_merge (rax) as value to source head-node.

    .end:
        ; restore dual-ptr and set new head to it.
        xor         rax, rax                    ; Set rax to 0 through XOR operation. Function returns null, so we return 0x0 (null).
        add         rsp, ALLOCATED_BYTES        ; Deallocate space on the stack used for local variables.
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

    ; ft_list_split start.

    .end:
        xor         rax, rax                        ; Set rax to 0 through XOR operation. Function returns null, so we return 0x0/null.
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

    ALLOCATED_BYTES     equ     40          ; Represents the allocated bytes of memory on the stack.
    SRC_HEAD_NODE       equ     8           ; Represents stack shift for the pointer that points to the original head-node.
    CMP_FNC             equ     16          ; Represents stack shift for cmp function pointer.
    LEFT_HALF           equ     24          ; Represents stack shift for pointer to left-half list head-node.
    RIGHT_HALF          equ     32          ; Represents stack shift for pointer to right-half list head-node.
    CURRENT_HEAD_NODE   equ     40          ; Represents stack shift for pointer to the current-head-node (list or sublist).