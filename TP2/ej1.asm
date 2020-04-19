;main.asm
GLOBAL main
EXTERN printf
section .rodata
fmt db "Cantidad de argumentos: %d",10, 0
arguments db "argumento [%d]: %s",10, 0
section .text
main:
    push ebp ; Armado de stack frame
    mov ebp, esp ;
    and esp,-16
    push dword [ebp+8]
    push fmt
    call printf
    add esp, 2*4
    push ebx
    push ecx
    mov ecx,0
    mov ebx,[ebp+12]

.loop:
    cmp [ebp+8],ecx
    je .return
    push dword [ebx]
    push ecx
    push arguments
    call printf
    add esp,4
    pop ecx
    add esp,4
    inc ecx
    add ebx,4
    jmp .loop

    pop ecx
    pop ebx

.return:
    mov eax, 0

    mov esp, ebp ; Desarmado de stack frame
    pop ebp
    ret