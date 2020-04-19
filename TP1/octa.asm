section .data
cadena db "h4ppy c0d1ng",10
lengthCadena equ $-cadena
section .text
global _start
_start:
    mov rax,5
    mov rbx,3
    call resta
    
    mov rax,1 ;syscall exit
    mov rbx,0 ;valor de retorno
    int 80h

print:
   mov rax,1
   mov rdi,1
   syscall
   ret    
resta:
    sub rax,rbx
    push rax
    mov rsi,rsp
    add byte [rsi],'0'
    mov rdx,1
    ;call print
    pop rax
    ret