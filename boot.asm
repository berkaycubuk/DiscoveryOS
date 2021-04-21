section .boot
bits 16                         ; 16 bit mode
global boot
boot:
    mov ax, 0x2401
    int 0x15                    ; enable A20 bit

    ; set the VGA text mode to known value to be safe
    ;mox ax, 0x3
    ;int 0x10                    ; set vga text mode 3

    ; disk stuff
    mov [disk], dl

    mov ah, 0x2                 ; read sectors
    mov al, 1                   ; sectors to read
    mov ch, 0                   ; cylinder idx
    mov dh, 0                   ; head idx
    mov cl, 2                   ; sector idx
    mov dl, [disk]              ; disk idx
    mov bx, copy_target         ; target pointer
    int 0x13

    cli
    lgdt [gdt_pointer]          ; load the gdt table
    mov eax, cr0
    or eax, 0x1                 ; set cr0 for protected mode bit
    mov cr0, eax
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp CODE_SEG:boot2          ; long jump to the code segment

gdt_start:
    dq 0x0

gdt_code:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0

gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:
gdt_pointer:
    dw gdt_end - gdt_start
    dd gdt_start

disk:
    db 0x0

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

times 510-($-$$) db 0           ; fill remaining bytes with 0
dw 0xaa55                       ; magic number

copy_target:
bits 32                         ; 32 bit mode
    hello: db "Hello world!", 0
boot2:
    mov esi, hello
    mov ebx, 0xb8000

.loop
    lodsb
    or al, al
    jz halt
    or eax, 0x0100
    mov word [ebx], ax
    add ebx, 2
    jmp .loop
    
halt:
    mov esp, kernel_stack_top
    extern kernel
    call kernel
    cli                         ; clear interrupt flag
    hlt                         ; halt execution

section .bss
align 4
kernel_stack_bottom: equ $
    resb 16384                  ; 16 KB
kernel_stack_top:
