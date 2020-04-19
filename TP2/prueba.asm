;main.asm
GLOBAL main
extern printf
section .rodata
cadena db "cantidad de args %d"
section .text
main:
    push rbp
    mov rbp,rsp
    push qword [rbp+16]
    push cadena
    call printf
    add rsp,32
    ret