%include "io.inc"
section .data

 ls times 50 dd 1,1,0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_DEC 4, ecx
    mov edx, ls+4 ;Elemento da frente
    mov eax, ls ;Elemento anterior
    
    call Fibo
    call Imprime
  
    ret
    
Fibo:
    pushad
    .l1:
    
    mov esi, [edx]
    add esi, [eax]
    add edx, 4
    add eax, 4
    mov [edx], esi
    
    loop .l1
    
    popad
ret


Imprime:
pushad
.l12:
    
    PRINT_UDEC 4, [eax]
    add eax, 4 
    call quebra
    loop .l12
popad
    ret
    
quebra:

PRINT_CHAR " "

ret