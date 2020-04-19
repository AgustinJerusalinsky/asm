section .text
GLOBAL exit
GLOBAL intToString
GLOBAL print
GLOBAL strlen
exit:
    mov eax, 1		; ID del Syscall EXIT
    mov ebx, 0		; Valor de Retorno
    int 80h			; Ejecucion de la llamada

intToString: ;en ax el numero, en rbx el puntero
    push 0
intToString_loop:
    cmp rax,10
    
    jl intToString_reverse
    mov rcx,10
    mov rdx,0
    div rcx
    add rdx,'0'
    push rdx
    jmp intToString_loop    
intToString_reverse:
    add rax,'0'
aux:    mov byte [rbx],al
    inc rbx
    pop rax
    cmp rax,0
    je  intToString_return
    jmp aux
intToString_return:
    mov byte [rbx],0
    ret 

print:
        mov rsi, rax 	; Puntero a la cadena
        mov rdx, rbx	; Largo de la cadena 
        mov rdi, 1		; FileDescriptor (STDOUT)
        mov rax, 1		; ID del Syscall WRITE
        syscall     		; Ejecucion de la llamada
	ret
strlen: ; en rax el puntero
        mov rbx, rax
        mov rax,0
strlen_loop:
        cmp byte [rbx],0
        jz strlen_return
        inc rax
        inc rbx
        jmp strlen_loop
strlen_return:
        ret
        