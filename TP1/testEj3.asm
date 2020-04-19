section .text
global _start
extern print
extern intToString
extern exit
_start:
        mov eax,0fh
        mov rbx,string
        call intToString
        mov rax,string
        mov rbx,4
        call print
        call exit

section .bss
string: resb 32

