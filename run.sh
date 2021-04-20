nasm -f bin boot.asm -o boot.bin
nasm -f bin ExtendedProgram.asm -o ExtendedProgram.bin
# nasm -f elf64 ExtendedProgram.asm -o ExtendedProgram.o

# x86_64-elf-gcc -ffreestanding -mno-red-zone -m64 -c "Kernel.cpp" -o "Kernel.o"

# ld -o kernel.tmp -Ttext 0x7e00 ExtendedProgram.o Kernel.o

# objcopy -O binary kernel.tmp kernel.bin

# cat boot.bin kernel.bin > boot.flp

cat boot.bin ExtendedProgram.bin > boot.flp

qemu-system-x86_64 boot.flp
