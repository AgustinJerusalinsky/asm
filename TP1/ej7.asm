section .text
extern print
extern exit
extern minor
extern intToString
global _start
_start:
        mov rax, size
        mov rbx, arr
        call minor
        mov rbx, string
        call intToString
        mov eax, string
        sub rbx,string
        call print
        call exit


minor: ; en rax el largo y en rbx el puntero al inicio
        mov edx,[rbx]
lp:     dec rax
        jz return
        add rbx, 4
        cmp edx,[rbx]
        jle lp
        jmp minor
return: mov eax,edx
        ret
        
section .data
arr dd  10,12,7,11,10
size equ ($-arr)/4

section .bss
string resb 8