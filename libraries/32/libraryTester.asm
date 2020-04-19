extern exit
extern intToString
extern print
extern strlen
extern factorial
extern swap
extern integerRecursiveBubbleSort ;este 
GLOBAL _start

section .bss
buffer resb 32

section .data
output db "esto funciona bien",10,0
arr dd 5,1,7,4,3,9,1,3
length equ ($-vec)/4
number equ 5

section .text
_start:
    push number
    call factorial
    add esp,4
    
    push eax
    push buffer
    call intToString
    add esp,2*4

    push eax
    push buffer
    call print
    add esp,2*4

    push output
    call strlen
    add esp,4

    push eax
    push output
    call print
    add esp,2*4    

    push length 
    push vec
    call sort

    call exit