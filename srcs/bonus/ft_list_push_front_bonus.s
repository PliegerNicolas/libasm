section .text
    ; Padding to align to 16 bytes.
    align   16

    ; External symbol declarations: start.
    extern  malloc
    extern  __errno_location
    ; External symbol declarations: end.

    ; Function entry-point for linker.
    global  ft_list_push_front

    ; Information on ft_list_push_front.
        ; Arguments:
        ;   RDI - Dual pointer/address to head-node of list.
        ;   RSI - Pointer to data to store in new list node.
        ; Returns:
        ;   RAX - NULL.

ft_list_push_front:

    ; ft_list_push_front initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_list_push_front start.
        push        rdi
        push        rsi

    ; malloc: { args: [RDI contains size in bytes to allocate], ret: [rax is set to new ptr/addr] }
        mov         rdi, T_LIST_SIZE            ; Store t_list size in rdi as requested by malloc (total allocated bytes).
        call        malloc wrt ..plt            ; Call malloc.
        pop         rsi                         ; Restore rsi.
        pop         rdi                         ; Restore rdi.
        test        rax, rax                    ; Check malloc's return value.
        jz          .error                      ; If 0x0, jump to .error

        mov         [rax + 0x0], rsi            ; Store data pointer at new_node->data (offset 0x0).
        mov         rcx, [rdi]                  ; Store the pointer stored in rdi to rcx so it can be copied into new pointer later on.
        mov         [rax + 0x8], rcx            ; Store previous head ptr at new_node->next (offset 0x8).
        mov         [rdi], rax                  ; Replace the old pointer with the new head.

   .end:
        xor         rax, rax                    ; Set rax to 0. void output expected, for security purpose.
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

    .error:
        neg         rax                         ; Invert the negative error code returned by syscall.
        mov         rdi, rax                    ; Move rax to rdi to preserve it's value. Call __errno_location would overwrite rax.
        call        __errno_location wrt ..plt  ; Call __errno_location. It will return the pointer/address to errno.
        mov         [rax], rdi                  ; Move the error code from rdi to the memory location pointer by rax (errno).
        mov         rax, -1                     ; Set error code to -1.
        jmp         .end                        ; Jump unconditionally to .end.

section .data
    T_LIST_SIZE     equ     16                  ; Hardcoded size of t_list: 8(ptr) * 2
    ENOMEM          equ     12                  ; Err code for POSIX-compliant systems: 'Not Enough Memory'

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.