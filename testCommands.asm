GLOBAL main
section .data
string db "walter puto"
main:
    push dword [esp]
    pop eax
    ret

