section .text
extern exit
extern intToString
extern print
global _start
_start:
        mov rax,0
_loop:   add rax,[num]
        dec byte [num]
        jnz _loop
        mov rbx,string
        call intToString
        mov rax,string   ;string start
        mov rbx,16    ;string size
        call print
        call exit  

        

section .data
num: dw 10

section .bss
string: resb 16