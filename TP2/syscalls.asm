GLOBAL sys_write, sys_read,sys_open,sys_close

sys_write: ;unsigned int fd, const char * buffer, size_t count ([rbp+32],[rbp+24],[rbp+16])
    push rbp
    mov rbp,rsp
    mov rax,1
    mov rdi,[rbp+32]
    mov rsi, [rbp+24]
    mov rdx, [rbp+16]
    syscall
    pop rbp    
    ret
sys_read: ;unsigned int fd, char * buffer, size_t count ([rbp+32],[rbp+24],[rbp+16])
    push rbp
    mov rbp,rsp
    mov rax,0
    mov rsi,[rbp+32]
    mov rdi, [rbp+24]
    mov rdx, [rbp+16]
    syscall
    pop rbp    
    ret
 
    ret
sys_open: ;unsigned int fd, int flags, int mode
    push rbp
    mov rbp,rsp
    mov rax,3
    mov rdi,[rbp+32]
    mov rsi,[rbp+24]
    mov rdx,[rbp+16]
    ret
sys_close: ;unsigned int fd
    push rbp
    mov rbp,rsp
    mov rax,3
    mov rdi,[rbp+16]
    syscall
    ret