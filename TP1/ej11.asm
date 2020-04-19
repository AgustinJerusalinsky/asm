%include "/home/agus/Documents/asm/libraries/std.h"
section .text
global _start
_start:
        mov rbp,rsp
        mov rax,[rbp]
        add rax,36
        mov rbx,8
        imul rbx
        add rax,16
        mov rbx,rbp
        add rbx,rax
        mov rax,[rbx]
        write_string rax
        call exit