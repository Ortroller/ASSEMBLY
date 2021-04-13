%include "io.inc"
section .bss

    vet resd 10
    
section .text
global CMAIN
CMAIN:

    mov ecx, 10d
    mov esi, vet
    
    push ecx
    push esi
    .lp1:
        
        GET_DEC 4, eax
        mov [esi], eax 
        add esi, 4   
    
    
    loop .lp1
    pop esi
    pop ecx
    
    dec ecx
    
    
    .lp2:
        mov eax, [esi]
        inc eax
        mov [esi], eax
        PRINT_DEC 4, [esi]
        NEWLINE
        add esi, 4
        dec ecx
        
    cmp ecx, 0
    jne .lp2
    
    ret