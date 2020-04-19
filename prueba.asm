extern printf
global main

section .rodata
cadenaP db "padre",10
cadenaH db "hijo",10


section .text
main:
    mov rax,57
    syscall
    cmp rax,0
    je hijo
    push cadenaP
    call printf
    jmp end
hijo:
    push cadenaH
    call printf
end:
    ret

