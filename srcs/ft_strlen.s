section .bss
    ; variables

section .data
    ; constants

section .text
    ; Actual read code
    global ft_strlen                ; entry-point for linker



ft_strlen:
    ; Initialize counter
    xor rax, rax                    ; Set counter to 0 through XOR operation,
                                    ; who is more efficient than mov;
    
    .loop:                          ; Loop through string