
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

### Registers structure

Registers are fundamental components of the CPU. They are small storage location within the CPU that are extremly fast for data storage and manipulation (and they say that usual RAM is fast. It's nothing compared to cpu registers). They can be used for arithmetic operations, data movement and addressing for example.

The number and size of GPRs (general purpose registers) depends on the CPU architecture.

To ensure transition capabilities between different CPU architecture (64bit, 32bit, 16bit, 8bit ...), GPRs provide register extensions. For example:
- AL (lower 8bits) and AH (higher 8bits) are 8 bit registers.
- AX is composed of AH and AL. It is a 16bit register.
- EAX is composed of AX and 16 supplementary bits. It is a 32bit register.
- RAX is composed of ECX and 32 supplementary bits. it is a 64bit register.
Thus if you modify the 8 lowest bits of RAX, you'll modify the 8 lower bits of EAX and AX (thus the whole content of AL.).

Bad news. There is no direct way to modify the higher 32 bits of RAX or the higher 16 bits of EAX. You usually modify the whole content of the higher order register.

Register extensions provide flexibility, backward compatibility and future-proofing.

To know how many different values a register can hold you can calculate that through 2^n where n is the number of bits the register can hold. 64bit registers can hold 18.4 quintillion different values and 6bit registers only 256. Witht he arrival of larger and larger registers, the way of using them has evolved and the potential of CPUs with it. More memory == More fun.

# Main things to know.

Careful. This isn't sufficiant. You should check my sources and even more. This is just a general overview (partical if you forgot something while coding).

### Caller/Callee-saved registers.

Caller-saved registers:

This is a list of registers that could be modified by the callee (function being called). Thus it is the responsability of the caller to preserve (usually through usage of the stack) the data of these specific registers before the function call and restore them after wards.
```
RAX
RCX
RDX
RSI
RDI
R8
R9
R10
R11
```

Callee-saved registers:

This is a list of registers that the callee (function being called) should preserve the data of. If it modified the values in one of those registers it should save the data before and restore it before the function exits. This preserves the calling function's state.
```
RBX
RBP
R12
R13
R14
R15
```

### What about the stack.

A stack is a pile of data. Imagine it just like a pile of cards. The last card you've added to the pile while be the first one you'll grab (if you don't mix the deck and you draw in a traditionnal way). We say usally that stacks are LIFO (last in, first out).

In a function calling language, using a stack is quite efficient. It respects it's hierarchical structure. The data that's the highest on the stack and thus the most easily accessible is the data related to the current and most recent function call. Once that function is done, it's data is cleared and the next available data is related to the previous function (caller). And this until you return to main and exit the program.

When programming you should consider the stack and the following two registers.
- RIP (instruction pointer). This one points to the address of the next instruction to execute (next function, next instruction ...). Every time you execute an instruction, EIP is modified to point to the next instruction.
- RSP (stack pointer). When you call a function and jump else where in the code, you store the content of RIP on the top of the stack so we know where to return too. Before exiting your function, you retrive that value and set it in RIP so your function knows where to return to.

Here are interesting videos explaining efficiently what you should know:
- https://www.youtube.com/watch?v=RU5vUIl1vRs
- https://www.youtube.com/watch?v=21u0Uerx0_Y

# Some sources so you can learn the necessary stuff.

- A short video to explain assembly in 100 secondes: https://www.youtube.com/watch?v=4gwYkEK0gOk
- Syntax, difference between AT&T and Intel: https://imada.sdu.dk/u/kslarsen/dm546/Material/IntelnATT.htm
- English assembly tutorial: https://www.tutorialspoint.com/assembly_programming/index.htm
- French assembly tutorial: https://lacl.u-pec.fr/tan/asm.pdf
- syscall table for x86-60: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64
- standard calling convention: https://en.wikipedia.org/wiki/X86_calling_conventions

- 42docs: https://harm-smits.github.io/42docs/projects/libasm
- Student tutorial: https://gaultier.github.io/blog/x11_x64.html