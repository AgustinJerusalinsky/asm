%include "/home/agus/Documents/asm/libraries/std.h"
section .text
global _start
_start:
        mov rbp,rsp
        mov rax,[rbp]
        mov rbx,8
        imul rbx
        add rax,16
        mov rbx,rbp
        add rbx,rax
lp:        
        strcmp eax,variable,'='
        jz end
        add rbx,8
        jmp lp
end:    mov rax,[rbx]
        write_string rax
        call exit