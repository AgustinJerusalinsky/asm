%include "/home/agus/Documents/asm/libraries/std.h"
section .rodata
cantidadArgumentos db "cantidad de argumentos: ",0
section .data 
cadena1 db "argv[",0
cadena2 db "]: "
section .text
global _start
_start:
        mov rbp,rsp
        push rbp
        push 0
        write_string cantidadArgumentos
        write_number rbp
        write_character 10
        add qword [rbp-8],8
lp:     mov rax,[rbp-8]
        cmp qword [rax],0
        jz end        
        write_string cadena1
        mov rax, rbp
        sub rax,16
        write_number rax
        write_string cadena2
        mov rax,[rbp-8]
        mov rax,[rax]
        write_string rax
        write_character 10
        inc qword [rbp-16]
        add qword [rbp-8],8
        jmp lp
end:    call exit
        