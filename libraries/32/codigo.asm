GLOBAL strlen ;int strlen(char * buffer);
GLOBAL fopen ; int fopen(char * path, int flags);
GLOBAL fclose ; int fclose(int fd);
GLOBAL fwrite ; int fwrite(int fd, void *buf, int count);

section .text
strlen: ; int strlen(char * buffer) 

    push ebp
    mov ebp,esp
    mov ecx, [ebp+8]
    mov eax,0
    .loop:
        cmp byte [ecx],0
        jz .return
        inc eax
        inc ecx
        jmp .loop
    .return:
        pop ebp
        ret

fopen: ;int fopen(char * path, int flags); retorna fd
    push ebp
    mov ebp,esp
    push ebx
    mov ebx, [ebp+8] 	; path
    mov ecx, [ebp+12] 	; flags
    mov edx, 110110110b	; mode 
    mov eax, 5		; ID del Syscall open
    int 80h    		; Ejecucion de la llamada
    pop ebx
    pop ebp
    ret
fclose: ;int fclose(int fd);
    push ebp
    mov ebp,esp
    push ebx
    mov ebx,[ebp+8] ; fd
    mov eax,6 ;id del syscall close
    int 80h
    pop ebx
    pop ebp
    ret

fwrite: ;int write(int fd, void *buf, int count);
    push ebp
    mov ebp,esp
    push ebx
    mov ebx, [ebp+8]	; FileDescriptor
    mov ecx, [ebp+12] 	; Puntero a la cadena
    mov edx, [ebp+16]	; Largo de la cadena 
    mov eax, 4		    ; ID del Syscall WRITE
    int 80h    		    ; Ejecucion de la llamada
    pop ebx
    pop ebp
	ret

