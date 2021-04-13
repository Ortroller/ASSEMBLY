%include "io.inc"
 ;FATORIAL DE UM NUM N
section .data
    resp dd 2,2,3,4,5,6,7,8,9,10,11,12,14,0

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, ecx
    
    call func

    PRINT_UDEC 4, eax
    
    ret
    

;Crie uma fun¸c˜ao que receba um n´umero inteiro positivo n e calcule o somat´orio dos
;numeros de 1 a n.

func:
    mov eax, 0
    
    .lp:
        
        add eax, ecx
    
    loop .lp
    
    
    ret