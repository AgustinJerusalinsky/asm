%include "/home/agus/Documents/asm/libraries/std.h"
section .text
global _start
_start:
        mov rbp,rsp
        sub rsp,8
        mov rax,[rbp]
        mov rbx,rsp
        call intToString
        mov rax,rsp
        sub rbx,rax
        call print
        add rsp,8
        call exit