
# Libasm

This is a 42 school project designed to teach us about Assembly: a low-level language intended to communicate directly with the computer's hardware.

Thank you Kathleen Booth ! <3

Nowadays assembly is rare but still used to address low level performance issues, create drivers, embedded systems ...
WebAssembly is a new product that is becoming more and more popular, by the way !

# The more you know the better

When creating your first Assembly code, you'll have to inform yourself and make some decisions:
- What architecture am I targetting: (x86, ARM, MIPS, ...)
- What operating system am I using (because each operating system has it's own systems calls and if you code on bare metal you'll have to interact idrectly with the available hardware peripherals).
- What Assembler to compile your code (NASM, GAS, MASM, GCC, ...). I use NASM.
- What syntax standard you'll use (AT&T, Intel, NASM, HLA, ...). We'll use the intel syntax.

I'm using Ubuntu (linux) with a 86x 64 bit processor and 42 School student computers also. So we'll compile with NASM using the '-felf64' flag. Elf stands for Executable and Linkable Format and is specific to linux and unix-based systems.

# Some sources so you can learn the necessary stuff.

A short video to explain assembly in 100 secondes: https://www.youtube.com/watch?v=4gwYkEK0gOk
Syntax, difference between AT&T and Intel: https://imada.sdu.dk/u/kslarsen/dm546/Material/IntelnATT.htm

English assembly tutorial: https://www.tutorialspoint.com/assembly_programming/index.htm
French assembly tutorial: https://lacl.u-pec.fr/tan/asm.pdf
