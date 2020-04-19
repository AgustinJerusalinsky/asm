section .text
GLOBAL _start

_start:
	mov eax, cadena
loop:	cmp byte [eax], 0
	jz endLp
	call toUpper
	inc eax
	jmp loop
endLp:	mov ecx, cadena 	; Puntero a la cadena
	mov edx, longitud	; Largo de la cadena 
	mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, 4		; ID del Syscall WRITE
	int 80h			; Ejecucion de la llamada

	mov eax, 1		; ID del Syscall EXIT
	mov ebx, 0		; Valor de Retorno
	int 80h			; Ejecucion de la llamada

toUpper:
	cmp byte [eax],'a'
	jnge return
	cmp byte [eax],'z'
	jnle return
	sub byte [eax],'a'
	add  byte [eax],'A'
return:	ret


section .data
cadena db "h4ppy c0d1ng", 0
longitud equ $-cadena
