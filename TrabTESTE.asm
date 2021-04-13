%include "io.inc"

section .data
    cm1 dw 1
    lm1 dw 3
    cm2 dw 1
    lm2 dw 1

    col db 2
    lin db 2
    
    btam dw 2 ;bytes
    
    i dw 0 ;indice auxiliar
    
    J dw 0 ;indice auxiliar para multiplicação de matriz
    acumulador dw 0
    tam dd 4 ;contador de interacoes
    
    
    mat1 times 100 dw 3
    mat2 times 100 dw 5, 2
    mat3 times 100 dw 0
    vet times 100 dw 2,3,2
    vetr times 100 dw 0
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

    
    
  ;  call oposta
    NEWLINE
    call Soma
  ;  call PrintR
    call PrintM1
    xor eax, eax
    
    ret
    
Sub:

    pushad ; Soma a Matriz 1 com a Matriz 2, Salva na Matriz 1
    
    movzx eax, word [tam]
    
    mov ecx, mat1
    mov ebx, 0d
    .lp1:
    
        mov dx, [ecx]
        sub dx, [mat2+ebx]
        mov [ecx], dx


        add ebx, 2
        add ecx, 2
        dec eax
    cmp eax, 0
    jne .lp1
    
    popad
    
ret

mulVet: ;Implementa multiplicação de matrizes (mat3 = mat1 * mat2) 
; Variaveis: lm1, cm1, lm2, cm2, tam, mat1, mat2, mat3
    ;total de colunas * linha desejada + coluna desejada 
    pushad
    ;Verificação de compatibilidade 
    mov ax, [cm1]
    cmp ax, [lm2]
    jne .erro ; Se coluna da matriz 1 for diferente da linha da matriz 2
    
    mov ecx, 0
    mov eax, 0
    mov esi, 0
    mov edx, 0
    mov ebx, 0
    
    .lp1:
    
        mov esi, i
        mov [esi], cx
        mov esi, 0
        
        push ecx
        mov ecx, 0
        
        .lp2:
        
            ;salvar em J, o resto da divisão de cx por tamanho (tam)
            mov ax, cx
            div word [tam]
            mov esi, J
            mov [esi], dx
            
            push ecx
            mov ecx, 0
            
            .lp3:
                
                 ;localizar elemento da matriz 1
                 mov ax, [cm1]
                 mul word [i] ; Linha desejada
                 add ax, cx ; Coluna desejada
                 mul word [btam] ; Tamanho em bytes de cada elemento
                 ;Elemento localizado
                 mov ebx, eax ; Salvando posição da matriz 1 em EDX
                 
                ; localizar elemento da matriz 2
                mov ax, [cm2]
                mul cx ; Linha desejada
                add ax, [J] ; Coluna desejada
                mul word [btam] ; Tamanho em bytes de cada elemento
                ;Elemento localizado
                
                mov dx, word [mat2 + eax] ; Pegando valor da matriz 2
                mov ax, word [mat1 + ebx] ; Pegando valor da matriz 1
                mul dx ; multiplicando valor de matriz 1 por matriz 2
                
                mov esi, acumulador
                add [esi], ax
                
                
            inc cx
            cmp cx, [lm2]
            jne .lp3 ;LOOP 3
            pop ecx
            
            
push esi ; SALVAR NA MATRIZ RESPOSTA (MATRIZ 3)
        
        ;localizar elemento da matriz resposta
        mov ax, word [cm2]
        mul word [i] ; Linha desejada
        add ax, cx ; Coluna desejada
        mul word [btam] ; Tamanho em bytes de cada elemento
        ;Elemento localizado
        
        mov esi, mat3
        add esi, eax
        movzx eax,  word [acumulador]
        
        mov [esi], eax
        mov esi, acumulador
        mov [esi], word 0 ; ==========================
        
pop esi ;FIM DO ALGORITMO DE SALVAR

 
        
        inc cx
        cmp cx, [tam]
        jne .lp2 ;loop 2
    
    
    
    pop ecx
    inc cx
    cmp cx, [lm1]
    jne .lp1 ;LOOP 1
    popad
ret
    .erro:
    
    NEWLINE
    PRINT_STRING "Matrizes incompativeis!"
    NEWLINE
    
    popad
ret          
                
                
                

PrintVR:
pushad 
    mov eax, 1d
    mul byte [lm1]
    mov ecx, vet
    mov bl, [lm1]

    .lp1:

        PRINT_DEC 2, [ecx]
        PRINT_STRING " | "
        dec bl
        cmp bl, 0d
        jne .fund ; Quando a coluna chegar a 0, da newline e reseta o valor 
            NEWLINE
            mov bl, [lm1]
        .fund:
        
        add ecx, 2
        dec eax

    cmp eax, 0
    jne .lp1
    
    popad
    ret
    
PrintM1:
pushad ; Printar primeira matriz
    movzx eax, byte [col]
    mul byte [lin]
    mov ecx, mat1
    mov bl, [col]

    .lp1:

        PRINT_DEC 2, [ecx]
        PRINT_STRING " | "
        dec bl
        cmp bl, 0d
        
        jne .fund ; Quando a coluna chegar a 0, da newline e reseta o valor 
            NEWLINE
            mov bl, [col]
        .fund:
        
        add ecx, 2
        dec eax

    cmp eax, 0
    jne .lp1
    
    popad
ret

LerVet: ; Ler vetor (Passar para ESI o endereço do vetor, e para EAX o tamanho das linhas da matriz 1)
pushad
    mov esi, vet
    mov eax, [lm1]
    
    .lp1:
        
        GET_DEC 2, [esi]
        add esi, 2
    
    dec eax
    cmp eax, 0
    jne .lp1
    
    
    
popad
ret

push esi ; SALVAR NA MATRIZ RESPOSTA (MATRIZ 3)
        
        movzx eax, word [i]
        mul word[btam]
        
        mov esi, mat3 
        add esi, eax
        movzx eax,  word [acumulador]
        
        mov [esi], eax
        mov esi, acumulador
        mov [esi], word 0 ; ==========================
        
pop esi ;FIM DO ALGORITMO DE SALVAR