%include "io.inc"
section .data
    
    vec dd 10, 20, 30, 40
    tam equ ($-vec)/4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov esi, 0

    mov ecx, 2
    dec ecx
    
    .lp1:
    
        mov eax, vec ; primeiro elemento
        add eax, esi
        
        mov edx, vec
        add edx, tam*3
        
        mov ebx, [eax]
        push ebx
        mov ebx, [edx]
        mov [eax], ebx
        pop ebx
        mov [edx], ebx
        
        add esi, 4d
    
        
        dec ecx
        cmp ecx, 0
        jne .lp1
  
    mov esi, vec
    mov ecx, tam
    
    .pr:
        
        PRINT_DEC 4, [esi]
        NEWLINE
        add esi , 4d
        
        
    dec ecx
    cmp ecx, 0
    
    jne .pr
    
    
    xor eax, eax
    ret