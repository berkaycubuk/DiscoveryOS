nasm -f bin boot.asm -o boot.bin
nasm -f bin ExtendedProgram.asm -o ExtendedProgram.bin

cat boot.bin ExtendedProgram.bin > boot.flp

qemu-system-x86_64 boot.flp
