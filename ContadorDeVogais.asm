%include "io.inc"
section .data
    
    array dd "a", "a", "a", "o", "l", "a", " "
    
section .text
global CMAIN
CMAIN:

    mov esi, array
    mov ecx, 50
    mov eax, [n]
    
    call print
    
    NEWLINE
    PRINT_DEC 4, eax
    ret
    
   
   
 print:
 push esi
 push edx

 .loop:
 
    mov edx, [esi]
    cmp edx, " "
    je .end
    
    ; PRINTING TIME!! ----------------------------
    PRINT_CHAR edx
    NEWLINE
    ;END OF PRINTING! ----------------------------
    add esi, 4
    
    
    cmp edx, "a"
    je .inc
    cmp edx, "e"
    je .inc
    cmp edx, "i"
    je .inc
    cmp edx, "o"
    je .inc
    cmp edx, "u"
    je .inc
    
    jmp .loop
    
 .inc:
 add eax, 1
 jmp .loop
 
 
 
 .end:
 pop edx
 pop esi
 ret