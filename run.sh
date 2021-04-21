nasm -f elf32 boot.asm -o boot.o
x86_64-elf-g++ -m64 kernel.cpp boot.o -o kernel.bin -nostdlib -ffreestanding -std=c++11 -fno-exceptions -nostdlib -fno-rtti -Wall -Wextra -Werror -T linker.ld

# qemu-system-x86_64 boot.bin
