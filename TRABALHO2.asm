%include "io.inc"
section .data

    

    vet times 50 db "ATACARBASESUL", 0
    size_a dd 13 ; Tamanho do vetor
    
    
    chave times 50 db "LIMAO", 0
    size_b dd 5
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    
    
    
    
    
    ;void replica (char v[], int tam, int new_tam)
    push chave
    push dword [size_b]
    push dword [size_a]
    call replica
    add esp, 12
    
    push vet
    push chave
    push dword [size_a]
    call cripto
    add esp, 12
    
    NEWLINE
    PRINT_STRING vet
    
    
    ;write your code here
    xor eax, eax
    ret
    
    
    
cripto: ; cripto ( int vet[], int chave[], int tam)
    push ebp
    mov ebp, esp
    
    mov esi, [ebp + 12] ; Movendo endereço da chave aqui
    
    mov ecx, 0
    .lp1:
    

    mov bl, [esi+ecx]
    sub bl, 65
    
    push esi
    mov esi, [ebp + 16]
    mov dl, [esi + ecx]
    add dl, bl
    pop esi
    
    
    cmp dl, 90
    jle .passa
    mov al, dl
    sub al, 90
    mov dl, 65
    add dl, al
    dec dl
    
    .passa:
    
        push esi
        mov esi, [ebp + 16]
        mov [esi + ecx], dl
        pop esi
    
    inc ecx
    
    cmp ecx, [ebp + 8]
    jne .lp1
    
    pop ebp
ret

dcripto:

    push ebp
    mov ebp, esp
    
    mov esi, [ebp + 12] ; Movendo endereço da chave aqui
    
    mov ecx, 0
    .lp1:
    

    mov bl, [esi+ecx]
    sub bl, 65
    
    push esi
    mov esi, [ebp + 16]
    mov dl, [esi + ecx]
    sub dl, bl
    pop esi
    
    
    cmp dl, 65
    jge .passa
    mov al, dl
    sub al, 65
    mov dl, 90
    add dl, al
    inc dl
    
    .passa:
    
        push esi
        mov esi, [ebp + 16]
        mov [esi + ecx], dl
        pop esi
    
    inc ecx
    
    cmp ecx, [ebp + 8]
    jne .lp1
    
    pop ebp
ret

replica: ;void replica (char v[], int tam, int new_tam) Recebe string e replica ate tamanho novo (new_tam)
    push ebp
    mov ebp, esp
    
    mov ecx, [ebp + 12] ; Conta de tam ate new_tam
    
    cmp ecx, [ebp + 8] ; se forem iguais
    je .base
    
    mov ebx, 0 ; Conta ate tam
    
    mov esi, [ebp+16] ; recebe vetor de caracteres
    
    .lp1:
    
    mov al, [esi + ebx]
    
    mov [esi + ecx],  al
    
    cmp ebx, [ebp + 12]
    jne .passa
    mov ebx, 0
    .passa:
    
    inc ebx
    inc ecx
    
    cmp ecx, [ebp+8] ;compara com new_tam
    jne .lp1 ;loop se nao igual
    
    add esi, ecx
    mov [esi], byte 0 ; definindo final da string
    
    .base:
pop ebp
ret


size_of: ; int size_of( char txt[] ) retorna tamanho
    push ebp
    mov ebp, esp
    
    mov esi, [ebp+8]
    mov ecx, 0
    
    .lp1:
    
        mov bl, [esi + ecx]
    
        inc ecx
        
        cmp bl, 0
        jne .lp1
    
    
        mov eax, ecx
    pop ebp
ret