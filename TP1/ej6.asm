section .text
global _start
extern exit
extern print
extern intToString

_start:
            mov rax,num
            call factorial
            sub rsp, 24
            mov rbx,rsp
            call intToString
            mov rax,rsp
            sub rbx, rsp
            call print
            add rsp, 24
            call exit


factorial:
            cmp rax,1
            je return
            push rax
            dec rax
            call factorial
            pop rbx
            imul rbx
return:     ret
            
section .data
num equ 20
