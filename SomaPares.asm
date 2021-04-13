%include "io.inc"
 ;FATORIAL DE UM NUM N
section .data
    resp dd 2,2,3,4,5,6,7,8,9,10,11,12,14,0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov esi, resp
    mov ecx, 0

   
    
    push esi
    .pl1:
        add ecx,1
        
    mov eax, [esi]
    add esi, 4d
    cmp eax, 0
    jne .pl1
    pop esi
    
    
     call func
    PRINT_DEC 4, eax

    ret
    

;Escreva uma procedimento que recebe um vetor de inteiros, no registrador esi, e seu
;tamanho, no registrador ecx, como parˆametros, e devolve, no registrador eax, a soma
;dos n´umeros pares deste vetor

func:
    mov eax, 0d
    
    .loop:
    
        mov edx, 0
        push ecx
        push eax
        
        mov eax, [esi]
        mov ecx, 2d
        div ecx
        
        pop eax
        pop ecx
        
        
        
        cmp edx, 0d
        je .inc
        .back:
        add esi, 4d
        
        
    loop .loop
    
    ret  
    
    .inc:
        
        add eax, [esi]
        
        
    jmp .back
    ret