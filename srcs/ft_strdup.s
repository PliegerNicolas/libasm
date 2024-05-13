extern  ft_strlen                   ; Declare external symbol for ft_strlen
    ; Arguments:
    ;   rdi - Pointer to start of null-terminated string.
    ; Returns:
    ;   rax - Length of the string excluding null terminator.
extern  ft_strcpy                   ; Declare external symbol for ft_strcpy
    ; Arguments:
    ;   rdi (s1) - Destination buffer. Should be of sufficiant size to contain s2 and it's terminator null byte.
    ;   rsi (s2) - Source string. Should be null terminated.
    ; Returns:
    ;   rax - Pointer to the destination string (copy of original rdi).
extern  malloc                      ; Declare external symbol for malloc
    ; Arguments:
    ;   rdi - Size in bytes of memory to allocate.
    ; Returns:
    ;   rax - Ptr to new memory.
extern __errno_location             ; Declare external symbol for errno.

align   16
global  ft_strdup                   ; Entry-point for linker.

    ft_strdup:
        ; Arguments:
        ;   rdi (s) - Pointer to string that we want to duplicate.
        ; Returns:
        ;   rax - New pointer containing the same data as what' original RDI points to.

        endbr64                     ; Mark the start of a function for control flow integrity (CFI) protection.
        push    rdi                 ; Push RDI onto the stack.

        ; ft_strlen: { args: [RDI contains ptr to str], ret: [RAX is undefined] }
        call    ft_strlen           ; Call ft_strlen. Returns the length of the string, null byte excluded.
        inc     rax                 ; Increment RAX by 1 to account for null byte.

        ; malloc: { args: [RDI contains size in bytes to allocate], ret: [RAX is new ptr] }
        mov     rdi, rax            ; Store size in bytes (RAX) for malloc in RDI.
        call    malloc wrt ..plt    ; Call malloc. Allocates RDI bytes of memory and returns new ptr in RAX or 0x0 on fail.
        test    rax, rax            ; Check if RAX is set to 0x0.
        jz      .error              ; If 0, jump to .error

        ; ft_strcpy: { args: [RDI contains ptr to dest str (to copy to), RSi contains ptr of source str (to copy from)], ret: [RAX is undefined] }
        pop     rdi                 ; Restore RDI from stack.
        mov     rsi, rdi            ; Move RDI to RSI.
        mov     rdi, rax            ; Copy new ptr to RDI.
        call    ft_strcpy

    .end:
        ret

    .error:
        mov     rdi, ENOMEM                 ; Move error code to rdi. _errno_location will need rax.
        call    __errno_location wrt ..plt  ; Call __errno_location, returns the memory address of the errno variable.
        mov     [rax], rdi                  ; Set errno value by dereferencing it and giving it the rdi value.
        mov     rax, 0x0                    ; Set return value (rax) to -1.
        jmp     .end                        ; Jump to .end unconditionally.
    
section .data
    ENOMEM equ  12                  ; Err code for POSIX-compliant systems: 'Not Enough Memory'

; My implementation is significantly slower than the original one. It is because it accumulates the defaults of the called functions.