%include "io.inc"

section .data
    
    vet dd 1, 2, 66, 23, 890, 501, 303, 0
    

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    push 1
    push vet
    call sc
    add esp, 8
    
    
    push 10
    call somatorio
    add esp, 4
    PRINT_DEC 4, eax
    
    
    
    
    ;write your code here
    xor eax, eax
    ret
    
; Faca um procedimento recursivo que recebe um vetor ordenado e um inteiro x e retorna
; se x pertencer ao vetor e 0 caso contrario.

sc:
    push ebp
    mov ebp, esp
    
    mov esi, [ebp+8] ; o vetor
    mov ecx, [ebp+12] ; inteiro X
    
    cmp [esi], dword 0 ; FIM DO VETOR
    je .nulo ; CASO BASE
    
    cmp [esi], ecx
    je .true
    
    push ecx
    inc esi
    push esi
    call sc
    add esp, 8
    
    jmp .fim
    .nulo:
    mov eax,0
    jmp .fim
    .true:
    mov eax,1
    .fim:
    pop ebp
ret




fatdp: ; Implementando um 5!!
    push ebp
    mov ebp, esp
    
    mov ecx, [ebp+8] ; Inteiro N
    
    cmp ecx, 1
    jle .rst
    
    sub ecx, 2d
    push ecx
    call fatdp
    pop ecx
    add ecx,2
    
    
    jmp .fim
    .rst:
    mov eax, 1
    mov ecx, 1
    .fim:
    mul ecx
    
    pop ebp
ret

somatorio:
    push ebp
    mov ebp, esp
    
    mov ecx, [ebp+8] ;Pegando inteiro
    
    cmp ecx, 1
    je .rst
    
    
    dec ecx
    push ecx
    call somatorio
    pop ecx
    inc ecx
    
    add eax, ecx
    
    
    jmp .fim
    .rst:
    mov eax, 1
    .fim:
    
    pop ebp
ret