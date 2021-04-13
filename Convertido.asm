%include "io.inc"

section .text
global CMAIN
CMAIN:
    
    GET_UDEC 4, ECX ;RECEBE N
    GET_DEC 4, EAX ;RECEBE B
    GET_DEC 4, EBX ; RECEBE A
    
    while: ; while( n > 0);
        cmp ECX, 0d ;Verificacao de N 
        jle fim ; Se N <= 0, Sai do codigo (JUMP LESS OR EQUAL)
        PRINT_DEC 4,ECX
        NEWLINE
        
        cmp  ECX , 3 ;Primeira parte do IF, (IF n!=3 AND (N < A OR N > B))
            je .l1 ; Se N igual a 3, Pula pro ELSE (.l1)
        cmp ECX, EAX ; Se verdadeira sentenca anterior, Pega segunda parte " N<A = ? "
            jl .l0 ; Se N < A for verdade, então todo o OR é verdade
        cmp ECX, EBX ; Se N > A, então terceira parte tambem e testada "N > B =?"
            jnl .l0 ; Se terceira parte for verdade, entao todo o OR e verdade, Pula pro procedimento IF (.l0)
            jmp .l1 ; Se nenhuma das 2 partes forem verdades, vai ao else (.l1)
        
        .l0: ;if
            sub ECX, 2
        jmp while  ;completa o loop
        .l1: ;else
            sub ECX, 1
        jmp while ;completa o loop
    fim: ;Marca a saída do loop
    NEWLINE
    PRINT_DEC 4, ECX
    NEWLINE
    PRINT_DEC 4, EAX
    NEWLINE
    PRINT_DEC 4, EBX
    
    xor eax, eax
    ret