%include "io.inc"
section .bss
    st resw 50
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

      
    GET_STRING [st], 50
    
    mov ecx, st
    
    .lp1:
    
    cmp [ecx], byte 48
    jl .fora
    cmp [ecx], byte 57
    jle .dentro
    
    cmp [ecx], byte 97
    jl .fora
    cmp [ecx], byte 102
    jle .dentro
    jmp .fora
    .dentro:
    
    inc ecx
    cmp [ecx], byte "h"
    jne .lp1
    PRINT_CHAR "S"
    
    ret
    
    .fora:
    
    PRINT_CHAR "N"
    xor eax, eax
    ret