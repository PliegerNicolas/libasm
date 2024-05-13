align 16
global ft_read                              ; Entry-point for linker.
extern __errno_location                     ; Declare external symbol for errno.

    ft_read:
        ; Arguments:
        ;   rdi (fd) - File descriptor to read from.
        ;   rsi (buf) - Buffer to write.
        ;   rdx (count) - Length of buffer.
        ; Returns:
        ;   rax - Length of the string excluding null terminator.

        ; Preparing the write syscall
        xor rax, rax                        ; Set syscall number for read to 0 via xor operation.
                                            ; File descriptor is already stored in rdi
                                            ; Buffer is already stored in rsi.
                                            ; Length of buffer is already stored in rdx.
        
        syscall                             ; Invoke syscall (set to write).

        test    rax, rax                    ; Verify if syscall returned an error.
        jns     .end                        ; Jump if the sign flag is not negative, indicating success.

    .error:
        ; If error, set errno and return -1.
        neg rax                             ; syscall returns negative error code. Invert it's sign.
        mov rdi, rax                        ; Move error code to rdi. _errno_location will need rax.
        call    __errno_location wrt ..plt  ; Call __errno_location, returns the memory address of the errno variable.
        mov [rax], rdi                      ; Set errno value by dereferencing it and giving it the rdi value.
        mov rax, -1                         ; Set return value (rax) to -1.

    .end:
        ret                                 ; Return length stored in rax (default).