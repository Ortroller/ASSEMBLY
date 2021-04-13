%include "io.inc"
section .data
    vet dd 1,233,3,4,5,4,3,2,1
    tam dd 9
    
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    push dword [tam]
    push vet
    call menor
    add esp, 8

    PRINT_DEC 4, eax
    
    xor eax, eax
    ret
    
    ;-----------questão lista 1-------------------
    imp:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8]
    cmp eax, 0
    jl .fim
    
    PRINT_DEC 4, eax
    NEWLINE
    
    dec eax
    
    push eax
    call imp
    add esp, 4
    
        .fim:
    
    pop ebp
    ret
    
    ;---------------------------------------------
    
    ;-----------questão lista 2-------------------
    impd:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8]
    cmp eax, 0
    jle .fim
    
    
    
    dec eax
    
    push eax
    call impd
    pop eax
    
        PRINT_DEC 4, eax
        NEWLINE
    
        .fim:

    pop ebp
    ret
    ;---------------------------------------------
    
    ;-----------questão lista 3-------------------
    pares:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8]
    cmp eax, 0
    jl .fim
    
    dec eax
    push eax
    call pares
    pop eax
    
        inc eax
        test eax, 1d
        jnz .fim
        
        PRINT_DEC 4, eax
        NEWLINE
    
        .fim:

    pop ebp
    ret
    ;---------------------------------------------
    
    mutRussa:
    push ebp
    mov ebp, esp
    
    
        mov ecx, [ebp + 8] ; B
        mov eax, [ebp + 12] ; A
        cmp eax, 1
        je .fim
    

    ;div word[val]
    
    mov ebx, ecx
    add ecx, ebx
    
    push eax
    push ecx
    call mutRussa
    add esp, 8
    
    .fim:
    mov eax, ecx
    pop ebp
    
    ret
    
    menor:
        push ebp
        mov ebp, esp
        
        mov esi, [ebp + 8] ; vetor
        mov ebx, [ebp + 12] ; tamanho
        
        cmp ebx, 0
        je .fim
        
        dec ebx
        
        cmp [esi], eax
        jle .nada
        mov eax, [esi]
        .nada:
        
        add esi, 4
        
        push ebx
        push esi
        call menor
        add esp, 8
        
        
        .fim:
        pop ebp
    ret