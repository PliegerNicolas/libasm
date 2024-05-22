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
        endbr64                                             ; Branch prediction hint (control flow enforcement technology).
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Allocate memory on stack for local variables. This function is intended for recursivity. /!\ Possibility of stack overflow. Carefull.
        sub         rsp, ALLOC_LIST                         ; Allocate memory on stack.

    ; Verify base-case.
        ; Return if 'cmp' == NULL.
        test        rsi, rsi                                ; Verify if 'cmp' function is not 0x0: begin_list != NULL.
        jz          .end                    

        ; Return if begin_list == NULL.
        test        rdi, rdi                                ; Verify if reference to pointer of begin_list is not 0x0: begin_list != NULL.
        jz          .end                                    ; If zero flag set (thus if begin_list == NULL), jump to .end.

        ; Return if *begin_list == NULL.
        mov         rax, [rdi]                              ; Dereference rdi and store the value in rax: rax = *begin_list.
        test        rax, rax                                ; Verify if *begin_list is not 0x0: *begin_list != NULL.
        jz          .end                                    ; If zero flag set (thus if *begin_list == NULL), jump to .end.

        ; Return if (*begin_list)->next == NULL.
        mov         rax, [rax + NODE_NEXT]                  ; Dereference and move rax NODE_NEXT bytes forward, retrieving next node's pointer: rax = (*begin_list)->next.
        test        rax, rax                                ; Verify if (*begin_list)->next is not 0x0: *begin_list != NULL.
        jz          .end                                    ; If zero flag set (thus if (*begin_list)->next == NULL), jump to .end.

    ; Initialize stack variables.
        mov         [rbp - BEGIN_LIST], rdi                 ; Store in stack begin_list as it is used as return value.
        mov         [rbp - CMP_FUNC], rsi                   ; Store in stack 'cmp' function pointer.

        mov         rax, [rdi]                              ; Set rax to *begin_list.
        mov         [rbp - SPLIT_SOURCE], rax               ; Set SPLIT_SOURCE to *begin_list (rax).

    ; Split source into left_half and right_half using 'ft_list_split' function.
        ; ft_list_split: { args: [rdi = t_list *source, rsi = t_list **left_half, rdx = t_list **right_half], ret: [rax is undefined] }
        mov         rdi, rax                                ; Set rdi to split_source (rax = [rdi] = split_source).
        lea         rsi, [rbp - LEFT_HALF]                  ; Set rsi to left_half's effective address in stack as requested by ft_list_split.
        lea         rdx, [rbp - RIGHT_HALF]                 ; Set rdx to right_half's effective address in stack as requested by ft_list_split.
        call        ft_list_split                           ; Call 'ft_list_split'.

    ; Call recursivly 'ft_list_sort' on left_half.
        ; ft_list_sort: { args: [rdi = t_list **left_half, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        lea         rdi, [rbp - LEFT_HALF]                  ; Set rdi to left_half's effective address in stack as requested by ft_list_sort.
        mov         rsi, [rbp - CMP_FUNC]                   ; Set rsi to 'cmp' function pointer.
        call        ft_list_sort                            ; Call 'ft_list_sort' recursivly.

    ; Call recursivly 'ft_list_sort' on right_half.
        ; ft_list_sort: { args: [rdi = t_list **right_half, rsi = ptr/addr of 'cmp' function], ret: [rax is undefined] }
        lea         rdi, [rbp - RIGHT_HALF]                 ; Set rdi to left_half's effective address in stack as requested by ft_list_sort.
        mov         rsi, [rbp - CMP_FUNC]                   ; Set rsi to 'cmp' function pointer.
        call        ft_list_sort                            ; Call 'ft_list_sort' recursivly.

    ; Merge  left and right half lists.
        ; ft_list_merge: { args: [rdi = t_list *left_half, rsi = t_list *right_half, rdx = ptr/addr of 'cmp' function], ret: [rax is set to head-node of merged list] }
        mov         rdi, [rbp - LEFT_HALF]                  ; Set rdi to left_half as requested by ft_list_merge.
        mov         rsi, [rbp - RIGHT_HALF]                 ; Set rsi to right_half as requested by ft_list_merge.
        mov         rdx, [rbp - CMP_FUNC]                   ; Set rdx to 'cmp' function pointer as requested by ft_list_merge.
        call        ft_list_merge                           ; Call 'ft_list_merge'.            

        mov         rdi, [rbp - BEGIN_LIST]                 ; Restore begin_list to rdi.
        mov         [rdi], rax                              ; Make rdi reference return value of ft_list_merge.

    .end:
        add         rsp, ALLOC_LIST                         ; Deallocate memory on stack.
        pop         rbp                                     ; Restore previous base pointer and remove it from the top of the stack.
        xor         rax, rax                                ; Set rax to 0 through XOR operation as this function returns void.
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
        endbr64                                             ; Branch prediction hint (control flow enforcement technology).
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack. 

    ; Initialize return values.
        mov         [rsi], rdi                              ; Set *left_half to source.
        mov         qword [rdx], 0x0                        ; Set *right_half to 0x0 (null).

    ; Allocate memory on stack for local variables.
    ;    sub         rsp, ALLOC_SPLIT                        ; Allocate memory on stack.

    ; Handle edge-cases.
        ; Return if source == NULL.
        test        rdi, rdi                                ; Verify if reference to pointer of source is not 0x0: source != NULL.
        jz          .end                                    ; If zero flag set (thus if source == NULL), jump to .end.

        ; Return if source->next == NULL.
        mov         rax, [rdi + NODE_NEXT]                  ; Dereference and move rdi NODE_NEXT bytes forward, retrieving next node's pointer: rax = source->next.
        test        rax, rax                                ; Verify if (*begin_list)->next is not 0x0: source != NULL.
        jz          .end                                    ; If zero flag set (thus if source->next == NULL), jump to .end.

        ; Initialize fast-node and slow-node.
        ;mov        rax, rax                                ; Rax is already equal to source->next. Commented out, just present for clarity.
        mov         rcx, rdi                                ; Set rcx to source initially. Represents slow-node.

    ; Move nodes forward using Floyd Warshall fast-slow technique.
    .loop:
        test        rax, rax                                ; Verify if fast is not 0x0: fast != NULL.
        jz          .end_loop                               ; If zero flag set (thus if fast == NULL), jump to .loop_end.

        mov         rax, [rax + NODE_NEXT]                  ; Move fast one node forward: rax = fast->next.
        test        rax, rax                                ; Verify if fast->next is not 0x0: fast->next != NULL.
        jz          .end_loop                               ; If zero flag set (thus if fast->next == NULL), jump to .loop_end.

        mov         rax, [rax + NODE_NEXT]                  ; Move fast one node forward: rax = fast->next->next.
        mov         rcx, [rcx + NODE_NEXT]                  ; move slow one node forward: rcx = slow->next.

        jmp         .loop                                   ; Jump unconditionally to .loop.

    .end_loop:
        mov         r8, rcx                                 ; Copy slow-node (rcx) in r8.
        mov         rcx, rcx[ + NODE_NEXT]                  ; Move slow one node forward: rcx = slow-node->next.
        mov         [rdx], rcx                              ; Set *right_half to rcx : *right_half = slow->next.
        mov         qword [r8 + NODE_NEXT], 0               ; Break the link between the two halfs: slow->next = null.

    .end:
        pop         rbp                                     ; Restore previous base pointer and remove it from the top of the stack.
        xor         rax, rax                                ; Set rax to 0 through XOR operation as this function returns void.
        ret                                                 ; Return (by default expects the content of rax).

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
        ;   RDI - Pointer/address to head-node of left_half.
        ;   RSI - Pointer/address to head-node of right_half.
        ;   RDX - Pointer/address of 'cmp' function.
        ; Returns:
        ;   RAX - Pointer/address of new merged head-node.

ft_list_merge:
    ; ft_list_split initialization.
        endbr64                                             ; Branch prediction hint (control flow enforcement technology).
        push        rbp                                     ; Push previous base pointer on top of stack.
        mov         rbp, rsp                                ; Setup base pointer to current top of the stack.

    ; Allocate memory on stack for local variables.
        sub         rsp, ALLOC_MERGE                        ; Allocate memory on stack.

    ; Check base-case / edge-case.  
        ; Return right_half if left_half is null.
        mov         rax, rsi                                ; Set rax to right_half in case the following test passes.
        test        rdi, rdi                                ; Verify if rdi (left_half) is not 0x0 (null).
        jz          .end                                    ; If zero flag set (left_half == null), jump to .end.

        ; Return left_half if right_half is null.
        mov         rax, rdi                                ; Set rax to left_half in case the following test passes.
        test        rsi, rsi                                ; Verify if rdi (right_half) is not 0x0 (null).
        jz          .end                                    ; If zero flag set (right_half == null), jump to .end.

    ; Initialize stack variables.
        mov         [rbp - LEFT_HALF], rdi                  ; Set rdi as left_half in stack.
        mov         [rbp - RIGHT_HALF], rsi                 ; Set rsi as right_half in stack.
        mov         [rbp - CMP_FUNC], rdx                   ; Set rdx as cmp_function in stack.

    ; Compare the data of left_half node with data of right_half node.
        ; cmp: { args: [rdi = void *left-data, rsi = void *right-data], ret: [rax is set 0 if equality. Positive means rdi > rsi, else negative] }
        mov         rdi, [rdi + NODE_DATA]                  ; Set rdi to it's contained data pointer as requested by 'cmp'.
        mov         rsi, [rsi + NODE_DATA]                  ; Set rsi to it's contained data pointer as requested by 'cmp'.
        call        rdx                                     ; Call 'cmp'.

        ; Restore caller-saved registers after function call.
        mov         rdi, [rbp - LEFT_HALF]                  ; Restore left_half to rdi.
        mov         rsi, [rbp - RIGHT_HALF]                 ; Restore right_half to rsi.
        mov         rdx, [rbp - CMP_FUNC]                   ; Restore 'cmp' function pointer to rdx.

        cmp         eax, 0                                  ; Compare 'cmp's output with 0. We use eax instead of rax because we are checking for the value of a 32bit integer.
        jg          .greater                                ; If eax > 0, jump to .greater.

    .smaller_or_equal:
        ; ft_list_merge: { args: [rdi = t_list *left_half, rsi = t_list *right_half, rdx = ptr/addr of 'cmp' function], ret: [rax is set to head-node of merged list] }
        mov         rdi, [rdi + NODE_NEXT]                  ; Move rdi one node forward: rdi = left_half->next.
        call        ft_list_merge                           ; Call 'ft_list_merge' recursivly.

        mov         rdi, [rbp - LEFT_HALF]                  ; Recuperate left_half from stack.
        mov         [rdi + NODE_NEXT], rax                  ; Set left_half->next to null to break linkage to following node.
        mov         rax, rdi                                ; Set rax (return value) to left_half.

        jmp         .end                                    ; Jump unconditionally to .end.

    .greater:
        ; ft_list_merge: { args: [rdi = t_list *left_half, rsi = t_list *right_half, rdx = ptr/addr of 'cmp' function], ret: [rax is set to head-node of merged list] }
        mov         rsi, [rsi + NODE_NEXT]                  ; Move rsi one node forward: rsi = right_half->next.
        call        ft_list_merge                           ; Call 'ft_list_merge' recursivly.

        mov         rsi, [rbp - RIGHT_HALF]                 ; Recuperate right_half from stack.
        mov         [rsi + NODE_NEXT], rax                  ; Set right_half->next to null to break linkage to following node.
        mov         rax, rsi                                ; Set rax (return value) to right_half.

    .end:
        add     rsp, ALLOC_MERGE                            ; Deallocate memory on stack.
        pop     rbp                                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                                 ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                              data                                ; ;;;
;;; ; ================================================================ ; ;;;

section .data
    ; List helpers.
    NODE_DATA           equ     0           ; Shift to retrieve data's value from dereferenced node pointer.
    NODE_NEXT           equ     8           ; Shift to retrieve next's value from dereferenced node pointer.

    ; Stack memory allocation for local variables.
    ALLOC_LIST          equ     40          ; Bytes to allocate on stack for specific function.
    ALLOC_MERGE         equ     24          ; Bytes to allocate on stack for specific function.

    ; General purpose stack shift offsets. To store and access, use [rbp - OFFSET] where OFFSET if the constant's name.
    CMP_FUNC            equ     24
    LEFT_HALF           equ     16
    RIGHT_HALF          equ     8

    ; ft_list_sort specific
    BEGIN_LIST          equ     40
    SPLIT_SOURCE        equ     32

    ; ft_list_split specific
    SLOW                equ     16
    FAST                equ     8

    ; ft_list_merge specific

; This code is far from being as fast as it's C version optimized with -O3 but learning purposes wise, I'm content. It works, it's fast and it's readable.
; I should minimize stack calls but with recursivity it's complicated. Do loop unrolling also. Minimize calls to stack.