
GLOBAL exit ;void exit();
GLOBAL intToString ;int intToString(char * buffer, int numero);
GLOBAL nprint ;void nprint(char * buffer, int size);
GLOBAL print ;int print(char * buffer);
GLOBAL strlen ;int strlen(char * buffer);
GLOBAL factorial;int factorial(int num);
GLOBAL swap; void swap( void * dir1, void * dir2, size_t size);
GLOBAL integerRecursiveBubbleSort ;void integerRecursiveBubbleSort(int * arr, size_t size);
;flags
%define	O_RDONLY	0x0000		/* open for reading only */
%define	O_WRONLY	0x0001		/* open for writing only */
%define	O_RDWR		0x0002		/* open for reading and writing */
%define	O_APPEND	0x400		/* set append mode */
%define	O_CREAT		0x40		/* create if nonexistant */
%define	O_EXCL		0x80	/* error if already exists */
GLOBAL fopen ; int fopen(char * path, int flags);
GLOBAL fclose ; int fclose(int fd);
GLOBAL fread ; int fread(int fd, void *buf, int count);
GLOBAL fwrite ; int fwrite(int fd, void *buf, int count);
GLOBAL fprintf ;int fprintf(int fd, int buffSize, char * format,...)
GLOBAL printf ;int fprintf(char * format,...)

section .text
exit:
    mov eax, 1		; ID del Syscall EXIT
    mov ebx, 0		; Valor de Retorno
    int 80h			; Ejecucion de la llamada

intToString: ; int intToString(char * buffer, int numero) -- [ebp+8], [ebp+12] retorna la longitud
    push ebp
    mov ebp,esp

    push 0
    mov eax,[ebp + 12] ; eax=numero
    mov ecx,10 ;divisor=10

    .loop:
        mov edx,0 ; resto=0
        div ecx
        add edx,'0'
        push edx
        cmp eax,0
        jne .loop

    mov ecx,[ebp+8]
    mov eax,0

    .reverse:
        inc eax
        pop edx
        mov [ecx],edx
        inc ecx
        cmp edx,0
        jne .reverse

    pop ebp
    ret 

nprint: ; void nprint(char * buffer, int size) [ebp+8], [ebp+12]
    push ebp
    mov ebp,esp
    push ebx
    mov ecx, [ebp+8] 	; Puntero a la cadena
    mov edx, [ebp+12]	; Largo de la cadena 
    mov ebx, 1		; FileDescriptor (STDOUT)
    mov eax, 4		; ID del Syscall WRITE
    int 80h    		; Ejecucion de la llamada
    pop ebx
    pop ebp
	ret
print: ; void print(char * buffer)
    push ebp
    mov ebp,esp
    push ebx
    push dword [ebp+8]
    call strlen
    add esp,4
    mov ecx, [ebp+8] 	; Puntero a la cadena
    mov edx, eax	; Largo de la cadena 
    mov ebx, 1		; FileDescriptor (STDOUT)
    mov eax, 4		; ID del Syscall WRITE
    int 80h    		; Ejecucion de la llamada
    mov eax,edx
    pop ebx
    pop ebp
	ret
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

factorial: ;int factorial(int num)
    push ebp
    mov ebp,esp
    mov eax,[ebp+8]
    cmp eax,1
    je return
    dec eax
    push eax
    call factorial
    add esp,4
    mov ecx,[ebp+8]
    mul ecx
    return:
        pop ebp 
        ret

swap: ; void swap( void * dir1, void * dir2, size_t size)
    push ebp
    mov ebp,esp
    push ebx
    mov eax,[ebp+8]
    mov ebx,[ebp+12]
    mov ecx,[ebp+16]
    .loop:
        mov dl,[eax] ; aux=d1
        push edx ; mem=d1
        mov dl,[ebx] ;aux=d2
        mov [eax],dl ;d1=aux
        pop edx ;aux=s
        mov [ebx],dl ;d2=aux
        inc eax
        inc ebx
        dec ecx
        jne .loop
    pop ebx
    pop ebp
    ret
integerRecursiveBubbleSort: ;void integerRecursiveBubbleSort(int * arr, size_t size)
        push ebp
        mov ebp,esp
        push ebx
        cmp dword [ebp+12],1 ; caso base, un solo elemento
        jle .return
        mov ebx,[ebp+8]
        push dword [ebp+12] ;indice en [ebp-8]
    .loop:
        mov edx,[ebx+4] ;cargo en el registro edx para comparar
        cmp [ebx],edx ; comparamos ebx con ebx+4
        jle .cycle_end
        push 4
        push dword ebx
        push dword ebx
        add dword [esp],4
        call swap
        add esp,3*4
        .cycle_end:
            add ebx,4
            dec dword[ebp-8]
            jnz .loop

    push dword [ebp+12]
    dec dword [esp]
    push dword [ebp+8]
    call integerRecursiveBubbleSort
    add esp,2*4
    .return:
        mov ebx,[ebp-4]
        mov esp,ebp
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

fread: ; int fread(int fd, void *buf, int count);
    push ebp
    mov ebp,esp
    push ebx
    mov ebx, [ebp+8] 	; FileDescriptor
    mov ecx, [ebp+12] 	; Puntero a la cadena
    mov edx, [ebp+16]	; cantidad de caracteres
    mov eax, 3		; ID del Syscall READ
    int 80h    		; Ejecucion de la llamada
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
fseek: ;int lseek(int fd, int offset, int whence);
    push ebp
    mov ebp,esp
    push ebx
    mov ebx, [ebp+8]	; FileDescriptor
    mov ecx, [ebp+12] 	; offset
    mov edx, [ebp+16]	; origin
    mov eax, 19		    ; ID del Syscall WRITE
    int 80h    		    ; Ejecucion de la llamada
    pop ebx
    pop ebp
	ret
fprintf: ;int fprintf(int fd, int buffSize, char * format,...)
    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi

    sub esp,[ebp+12]
    mov edi,esp
    mov esi, ebp ;paremeter pointer
    add esi,16 ; esi siempre apunta al parametro anterior al que necesito en los cases
    mov ebx, [ebp+16]

    .loop:
        cmp byte [ebx],'%'
        jne .continue
        inc ebx
        cmp byte [ebx],'s'
        je .caseS
        cmp byte [ebx],'d'
        je .caseD
        mov eax,-1
        jmp .end
        .continue:
        mov dl,[ebx]
        mov [edi],dl
        inc edi
        inc ebx
        cmp dl,0
        jne .loop

    .end:
        mov eax, edi
        sub eax,esp
        mov ecx,esp
        push eax
        push ecx
        push dword [ebp+8]
        call fwrite
        add esp,2*4
        pop eax
        add esp,[ebp+12]
        pop edi
        pop esi
        pop ebx
        pop ebp
        ret


    .caseD:
        add esi,4
        push dword [esi]
        push edi
        call intToString
        add esp, 2*4
        add edi,eax
        inc ebx
        jmp .loop

    .caseS:
        ;TODO
        jmp .loop
    



printf: ;int printf(char * format,...)
    pop eax
    push 100
    push 1
    push eax
    jmp fprintf

newFunction:
newFunction:
newFunction:

