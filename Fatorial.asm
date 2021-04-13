%include "io.inc"
 ;FATORIAL DE UM NUM N
section .data
    resp dd 0


section .text
global CMAIN
CMAIN:
   
   GET_UDEC 4, ecx
   mov eax, 1
   
   mov esi, resp
   
  
   cmp ecx, 0
   je fim
   
    .loop:
    
    mul ecx
    
    loop .loop
   
   
   mov [esi], eax
   
   PRINT_UDEC 4, [esi]
   
    ret
    
    fim:
    PRINT_UDEC 4, 1d
    ret