%include "io.inc"
section .data
    
    vec dw "EU FACA O QUE EU QUERO"
    tam equ ($-vec)

section .text
global CMAIN
CMAIN:
    
        GET_CHAR dl
        
        mov esi, vec
        mov ax, 0d
        
        mov ecx, tam

        .lp1:
        
            mov bl, [esi]
            cmp bl , dl
            jne .jp
            
            inc eax
            .jp:
            
            add esi, 1d
            
        loop .lp1
        
        PRINT_DEC 2, ax
    ret