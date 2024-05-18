section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
        extern  ft_list_size
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
    ; We'll be utilizing merge sort as it is the overall best sorting method for linked lists.

    ; ft_list_sort initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

        test        rdi, rdi                    ; Check if rdi is 0x0/null.
        jz          .return                     ; If zero flag is set, rdi is 0x0: return.

        sub         rsp, 24                     ; Allocate 24 bytes in stack (8 bytes * 3).
        mov         [rbp - 24], rdi             ; Store rdi (dual-pointer to list's head-node) in stack. This will represent DUAL-PTR HEAD-NODE.
        mov         rax, [rdi]                  ; Dereference rax to get the actual head-node.
        mov         [rbp - 16], rax             ; Store rax (head-node) in stack. This will represent HEAD-NODE.
        mov         [rbp - 8], rsi              ; Store rsi (reference-data) in stack. This will represent REFERENCE-DATA.

    ; ft_list_sort start.

    .end:
        mov         rdi, [rbp - 24]             ; Set rdi to dual-pointer to list's head-node.
        mov         rsi, [rbp - 16]             ; Set rsi to head-node.
        mov         [rdi], rsi                  ; Store rsi (head-node) of list at dereferenced rdi (dual-pointer to list's head-node).
        add         rsp, 24                     ; Liberate allocated 24 bytes from stack.

    .return:
        xor         rax, rax                    ; Set rax to 0x0/null. Functions returns void so we set 0x0 by default.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.