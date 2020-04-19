GLOBAL _start
EXTERN main
_start:
    call main;
    mov rdi,rax
    mov rax,60
    syscall