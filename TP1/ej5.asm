section .text
global _start
extern print
extern exit
extern intToString
_start:
        inc dword [number]
lp:     mov rcx, divider
        dec dword [number]
        jz endLoop
        mov rax,[number]
        mov rdx,0
        idiv rcx
        cmp rdx,0
        jne lp
        sub rsp,8
        mov rax, [number]
        mov rbx, rsp
        call intToString
        mov byte [rbx], ' '
        mov byte [rbx+1], 0
        mov rax, rsp
        mov rbx, 10
        call print
        add rsp, 8
        jmp lp
        
endLoop:
        call exit
        
section .data
divider equ 3
number dw 11
        