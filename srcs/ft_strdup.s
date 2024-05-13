extern  ft_strlen
    ; Arguments:
    ;   rdi - Pointer to start of null-terminated string.
    ; Returns:
    ;   rax - Length of the string excluding null terminator.
extern  ft_strcpy
    ; Arguments:
    ;   rdi (s1) - Destination buffer. Should be of sufficiant size to contain s2 and it's terminator null byte.
    ;   rsi (s2) - Source string. Should be null terminated.
    ; Returns:
    ;   rax - Pointer to the destination string (copy of original rdi).
extern  _malloc
    ;
    ;
    ;
    ;

align   16
global  ft_strdup   ; Entry-point for linker.

    ft_strdup:
        ; Arguments:
        ;   rdi (s) - Pointer to string that we want to duplicate.
        ; Returns:
        ;   rax - New pointer containing the same data as what' original RDI points to.

        mov     rdx, rdi            ; Store RDI pointer to RDX. RDI will need to be modified for futur function calls.

        call    ft_strlen           ; Retrieve length of string (RDI).
        inc     rax                 ; Increment by one byte to account for null byte.

        mov     rdi, rax            ; Store RAX in RDI. RDI is set to the size to allocate in bytes for _malloc.
        ;call    _malloc wrt ..plt   ; Allocate memory. New address is returned in RAX.
        ;test    rax, rax            ; Verify if malloc succeeded. If equal to 0, exit.
        ;jz      .end                ; If 0, jump to .end

    .end:
        ret