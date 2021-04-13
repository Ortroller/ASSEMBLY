%include "io.inc"
section .data
    
    vec dd "EU FACO O QUE EU QUERO"
    tam equ ($-vec)/4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, 1d
    mov ebx, 2d
    mov ecx, 3d
    GET_DEC 4, edx
    
    
    .lp1:
        push eax
        push edx
        
        mul ebx
        mul ecx
        
        pop edx
        
        cmp eax, edx
        je .ptr
        
        cmp eax, edx
        ja .fim
        
        pop eax
        inc eax
        inc ebx
        inc ecx
    
    jmp .lp1
    .ptr:
     pop eax
     
        PRINT_DEC 4, eax
        NEWLINE
        PRINT_DEC 4, ebx
        NEWLINE
        PRINT_DEC 4, ecx
        
     ret
    .fim:
     pop eax
    
    ret