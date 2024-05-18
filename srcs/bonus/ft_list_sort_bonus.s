section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_sort

    ; Information on ft_list_sort.
        ; Arguments:
        ;   RDI - Dual pointer/address to head-node of list.
        ;   RSI - Reference data to compare to.
        ; Returns:
        ;   RAX - NULL

ft_list_sort:
    ; ft_list_sort initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

        sub         rsp, 16                     ; Allocate 16 bytes in stack (8 bytes * 8).
        mov         [rbp - SRC_HEAD_NODE], rdi  ; Set SOURCE_HEAD_NODE pointer in stack. This is a pointer to the pointer to the list's head-node.
        mov         [rbp - CMP_FNC], rsi        ; Set CMP_FUNCTION's pointer in stack through rdx.

        mov         rdi, [rdi]                  ; Dereference rdi to retrieve the current head-node. This represents the fast-node.

    ; ft_list_sort start.
        call        ft_merge_sort               ; Call ft_merge_sort (defined below).

    .end:
        ; restore dual-ptr and set new head to it.
        add         rsp, 16                     ; Liberate allocated 16 bytes from stack.
        xor         rax, rax                    ; Set rax to 0 through XOR operation. Function returns null, so we return 0x0/null.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

section .data
    NODE_DATA       equ     0                   ; Shift to retrieve data's value from dereferenced node pointer.
    NODE_NEXT       equ     8                   ; Shift to retrieve next's value from dereferenced node pointer.

    SRC_HEAD_NODE   equ     8                   ; Represents stack shift for the pointer that points to the original head-node.
    CMP_FNC         equ     16                  ; Represents stack shift for cmp function pointer.

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.

;;; ; ================================================================ ; ;;;
;;; ;                           merge_sort                             ; ;;;
;;; ; ================================================================ ; ;;;

section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_merge_sort

    ; Information on ft_merge_sort.
        ; Arguments:
        ;   RDI - Pointer/address to head-node of list.
        ; Returns:
        ;   RAX - NULL

ft_merge_sort:
    ; ft_merge_sort initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_merge_sort start.


    .end:
        xor         rax, rax                    ; Set rax to 0 through XOR operation. Function returns null, so we return 0x0/null.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret    

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.