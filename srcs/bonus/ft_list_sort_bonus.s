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

    ; Allocate memory on stack for local variables. This function is intended for recursivity. /!\ Possibility of stack overflow. Carefull.
        sub         rsp, ALLOC_LIST                         ; Allocate memory on stack.

    ; Verify base-case.
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
        mov         qword [rbp - LEFT_HALF], 0x0            ; Initialize left_half to 0 (null).
        mov         qword [rbp - RIGHT_HALF], 0x0           ; Initialize right_half to 0 (null).

    ; Split source into left_half and right_half using 'ft_list_split' function.
        ; ft_list_split: { args: [rdi = t_list *source, rsi = t_list **left_half, rdx = t_list **right_half], ret: [rax is undefined] }
        mov         rdi, [rbp - SPLIT_SOURCE]               ; Set rdi to split_source as requested by ft_list_split.
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

    ; Merge  ... ??
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

    ; ft_list_split start.

    .end:
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

    ; Allocate memory on stack for local variables. This function is intended for recursivity. /!\ Possibility of stack overflow. Careful.
        sub         rsp, ALLOC_MERGE                    ; Allocate memory on stack.

    ; ft_list_merge start.
 
    .end:
        add         rsp, ALLOC_MERGE                    ; Deallocate memory on stack.
        pop         rbp                                 ; Restore previous base pointer and remove it from the top of the stack.
        ret                                             ; Return (by default expects the content of rax).

;;; ; ================================================================ ; ;;;
;;; ;                              data                                ; ;;;
;;; ; ================================================================ ; ;;;

section .data
    ; List helpers.
    NODE_DATA           equ     0           ; Shift to retrieve data's value from dereferenced node pointer.
    NODE_NEXT           equ     8           ; Shift to retrieve next's value from dereferenced node pointer.

    ; Stack memory allocation for local variables.
    ALLOC_LIST          equ     40          ; Bytes to allocate on stack for specific function.
    ALLOC_SPLIT         equ     0           ; Bytes to allocate on stack for specific function.
    ALLOC_MERGE         equ     0           ; Bytes to allocate on stack for specific function.

    ; General purpose stack shift offsets. To store and access, use [rbp - OFFSET] where OFFSET if the constant's name.
    BEGIN_LIST          equ     40
    CMP_FUNC            equ     32
    SPLIT_SOURCE        equ     24
    LEFT_HALF           equ     16
    RIGHT_HALF          equ     8