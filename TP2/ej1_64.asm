;main.asm
GLOBAL main
EXTERN printf
section .rodata
fmt db "Cantidad de argumentos: %d",10, 0
arguments db "argumento [%d]: %s",10, 0
section .text
main:
    push rbp ; Armado de stack frame
    mov rbp, rsp ;
    push qword [rbp+16]
    push fmt
    call printf
    add rsp, 2*8
    push rbx
    push rcx
    mov rcx,0
    mov rbx,[rbp+24]

.loop:
    cmp [rbp+16],rcx
    je .return
    push qword [rbx]
    push rcx
    push arguments
    call printf
    add rsp,8
    pop rcx
    add rsp,8
    inc rcx
    add rbx,8
    jmp .loop

    pop rcx
    pop rbx

.return:
    mov rax, 0

    mov rsp, rbp ; Desarmado de stack frame
    pop rbp
    ret