nasm -f elf32 boot.asm -o boot.o
i686-elf-g++ -m32 kernel/kernel.cpp boot.o -o kernel.bin -nostdlib -ffreestanding -std=c++11 -fno-exceptions -nostdlib -fno-rtti -Wall -Wextra -Werror -T linker.ld

qemu-system-x86_64 kernel.bin
