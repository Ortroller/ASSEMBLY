%include "io.inc"
section .data
    
    array dd "a", "a", "a", "o", "l", "a", " "
    
section .text
global CMAIN
CMAIN:

    mov esi, array
    mov ecx, 50
    
    call print
    
    NEWLINE
    PRINT_CHAR eax
    ret
    
   
   
 print:
 push esi
 push edx

 .loop:
 
    
    cmp edx, 0
    je .end
    
    mov eax, [esi]
    sub eax, 32
    mov [esi], eax
    
    mov edx, [esi]
    
    ; PRINTING TIME!! ----------------------------
    PRINT_CHAR edx
    NEWLINE
    ;END OF PRINTING! ----------------------------
    
    
    
    add esi, 4
 
    
    jmp .loop
    
 
 
 
 .end:
 pop edx
 pop esi
 ret