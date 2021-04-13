%include "io.inc"

section .text
global CMAIN

CMAIN:

    GET_DEC 4, eax
    GET_DEC 4, edx
    mov ecx, eax
    
    add eax, edx
    PRINT_DEC 4, eax
    sub ecx, edx
    PRINT_DEC 4, ecx
    


    ;write your code here
    xor eax, eax
    ret