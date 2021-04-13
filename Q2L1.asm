%include "io.inc"

section .text
global CMAIN

CMAIN:

    mov eax, 200
    mov edx, 50
    
    mov ecx, 25
    mov ebx, 22
    
    add eax, edx
    add ecx, ebx
    
    sub eax, ecx
    
    PRINT_DEC 4, eax
    


    ;write your code here
    xor eax, eax
    ret