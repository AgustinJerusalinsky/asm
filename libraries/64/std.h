extern print
extern exit
extern intToString
extern strlen
%macro pushall 0
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
%endmacro
%macro popall 0
    pop rax
    pop rbx
    pop rcx
    pop rdx
    pop rsi
    pop rdi
%endmacro
%macro write_string 2 
    mov rax,%1
    mov rbx,%2
    call print
%endmacro
%macro write_string 1
    push %1 
    mov rax,%1
    call strlen
    mov rbx,rax
    pop rax
    call print
%endmacro
%macro write_number 1 
    mov rax,[%1]
    sub rsp,8
    mov rbx,rsp
    call intToString
    sub rbx,rsp
    write_string rsp,rbx
    add rsp,8
%endmacro

%macro write_character 1
    sub rsp,1
    mov byte [rsp],%1
    write_string rsp, 1
    add rsp,1    
%endmacro

