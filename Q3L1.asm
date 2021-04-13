%include "io.inc"

section .data
v: DD 1,2,3,4,5,6,7,8,9,10

section .text

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx, 10
    mov edx, v
    LL:
    
       GET_DEC 4, eax
       inc eax
       MOV [edx], eax
       add edx, 4
    LOOP LL
    
     PRINT_DEC 4, [v]
     PRINT_STRING " "
     PRINT_DEC 4, [v+4]
     PRINT_STRING " "
     PRINT_DEC 4, [v+8]
     PRINT_STRING " "
     PRINT_DEC 4, [v+12]
     PRINT_STRING " "
     PRINT_DEC 4, [v+16]
     PRINT_STRING " "
     PRINT_DEC 4, [v+20]
     PRINT_STRING " "
     PRINT_DEC 4, [v+24]
     PRINT_STRING " "
     PRINT_DEC 4, [v+28]
     PRINT_STRING " "
     PRINT_DEC 4, [v+32]
     
     
    ;write your code here
    xor eax, eax
    ret