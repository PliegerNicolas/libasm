section .text
    ; Actual read code
    global ft_strlen            ; entry-point for linker

ft_strlen:
    ; Arguments:
    ;   rdi - Pointer to start of null-terminated string.
    ; Returns:
    ;   rax - Length of the string excluding null terminator.

    ; Initialize counter
    xor rax, rax                ; Set counter to 0 through XOR operation,
                                ;   who is more efficient than mov.

.loop:                          ; Loop through string.
    cmp byte [rdi], 0           ; Dereference and compare the first 
                                ;   rdi byte with null terminator.
    je .end                     ; Jump if equal to null terminator -> exit the loop.
    inc rax                     ; Increment counter.
    inc rdi                     ; Increment pointer to move to next character.
    jmp .loop                   ; Jump back to the start of the loop.
    
.end:
    ret                         ; Return length stored in rax (default).



section .bss
    ; variables

section .data
    ; constants