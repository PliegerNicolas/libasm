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
        ;   RDI - Pointer/address head-node of list.
        ;   RSI - Data to store in new list node.
        ; Returns:
        ;   RAX -

ft_list_push_front:

    ; ft_list_push_front initialization.
        endbr64                                 ; AMD specific branch prediction hint.
        push        rbp                         ; Push previous base pointer on top of stack.
        mov         rbp, rsp                    ; Setup base pointer to current top of the stack.

    ; ft_list_push_front start.
        push        rdi                         ; Push rdi's value (head-node of list) to stack to preserve it.
        push        rsi                         ; Push rsi's value (data to push to list) to stack to preserve it.

    ; malloc: { args: [RDI contains size in bytes to allocate], ret: [rax is set to new ptr/addr] }
        mov         rdi, t_list_size            ; Store the number of bytes to allocate in rdi as requested by malloc.
        call        malloc wrt ..plt            ; Call malloc.
        test        rax, rax                    ; Check malloc's return value.
        jz          .error                      ; If 0x0, jump to .error

        pop         rsi                         ; Retrieve stored/preserved data (previous rsi) in rsi.
        pop         rdi                         ; Retrieve stored/preserved head-store pointer (previous rdi) in rdi.
        mov         [rax + 0x0], rsi            ; Move data to new node->data through a 0x0 bit offset.
        mov         [rax + 0x8], rdi            ; Add old head-node address to new node->next through a 0x8 bit offset.
        mov         rdi, rax                    ; Replace rdi (old head-node) with new ptr/addr to push it to front of list.
        xor         rax, rax                    ; Set rax to 0 through XOR operation. This function returns void so per security we return 0x0.

    .end:
        pop         rbp                         ; Restore previous base pointer and remove it from the top of the stack.
        ret                                     ; Return (by default expects the content of rax).

    .error:
        mov     rdi, ENOMEM                     ; Move error code to rdi. _errno_location will need rax.
        call    __errno_location wrt ..plt      ; Call __errno_location, returns the memory address of the errno variable.
        mov     [rax], rdi                      ; Set errno value by dereferencing it and giving it the rdi value.
        mov     rax, 0x0                        ; Set return value (rax) to -1.
        jmp     .end                            ; Jump to .end unconditionally.

section .data
    t_list_size     equ     16                  ; Hardcoded size of t_list: 8(ptr) * 2
    ENOMEM          equ     12                  ; Err code for POSIX-compliant systems: 'Not Enough Memory'

; It supposedly follows conventions. At least those I know about. If not, do not hesitate to tell me.