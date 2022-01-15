org 0x7c00

start:
    mov ax, 0
    mov ds, ax
print:
    mov si, string
    mov ah, 0x0e
    mov bx, 0x0007
putchar:
    mov al, [si]
    add si, 1
    cmp al, 0
    je end
    int 0x10
    jmp putchar
end:
    hlt
    jmp end

string:
    db 'Hello, World!', 0

    times 510 - ($-$$) db 0
    db 0x55
    db 0xaa
