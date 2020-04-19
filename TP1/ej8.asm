%define arr [rbp+16]
%define size [rbp+24]
    0x10
00h  ret datos ffh

section .data
vec dd  5,4,6,3,8,1,9,2,1,10,1234,65,45,743,0
length equ ($-vec)/4

section .bss
aux resb 9

section .text
extern print
extern intToString
extern exit
global _start
_start:
        push length 
        push vec
        call sort ;parametros y call de sort
        mov ax,length ;ahora vamos a imprimirlo
        mov rbx,vec 
        inc ax ; preparamos para el loop
lp:     dec ax
        jz end
        push rax ;guardamos la pos
        mov eax,[rbx] ;ponemos el numero en rax
        push rbx ; guardamos la direccion
        mov rbx, aux ; especificamos donde se va a escribir
        call intToString
        mov byte [rbx],' ' ;como rbx ahora apunta al final, podemos poner ahi el ' '
        inc rbx
        mov rax,aux ; especifico que imprimir
        sub rbx,aux ; la long es final - inicial
        call print
        pop rbx ;recupero la direccion
        pop rax ; recupero el numero
        add rbx,4
        jmp lp
end:    call exit

swap: ; rax dir1 rbx dir2 rcx size
        inc rcx ;preparo para iniciar el swap
swap_loop:
        dec rcx
        jz swap_return ; cuando te quedas sin mas bytes
        mov dl,[rax] ; d=a
        push rdx ; s=d
        mov dl,[rbx] ;d=b
        mov [rax],dl ;a=d
        pop rdx ;d=s
        mov [rbx],dl ;b=d
        inc rax
        inc rbx
        jmp swap_loop
swap_return:
        ret

sort:   ;[rbp-8] ret [rbp-16] arr [rbp-24] size
        push rbp
        mov rbp,rsp ; armo una especie de stack_frame
        mov rax,size
        mov rbx,arr
        cmp rax,1 ; caso base, un solo elemento
        je sort_return
        sub rbx,4 ; preparo para el oop
sort_loop:
        add rbx,4
        dec rax
        jz sort_newCall
        mov edx,[rbx+4] ;cargo en el registro rdx para comparar
        cmp [rbx],edx ; comparamos rbx con rbx+4
        jle sort_loop
        push rax ; guardo el tamaño actual
        push rbx ; guardo la pos actual
        mov rax,rbx ; ;preparo para el swap, dir1
        add rbx,4 ; preparo para el swap dir2
        mov rcx,4     ;preparo para el swap cantidad de bytes
        call swap
        pop rbx ;recupero la pos
        pop rax ;recupero el tamaño
        jmp sort_loop
sort_newCall:
        dec qword size ;le resto uno al size para la recursividad
        push qword size
        push qword arr ; le paso el comienzo del array
        call sort
sort_return:
        pop rbp ;popeo el rbp
        pop rdx; popeo el ret
        pop rax ;popeo los 2 parametros
        pop rax
        push rdx    
        ret
