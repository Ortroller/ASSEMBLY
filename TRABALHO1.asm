%include "io.inc"

section .data
    cm1 dw 0 ;Colunas da matriz 1
    lm1 dw 0 ;Linhas da matriz 1
    
    cm2 dw 0 ;Colunas da matriz 2
    lm2 dw 0 ;Colunas da matriz 2
    
    btam dd 2 ;Tamanho em bits
    
    i dw 0 ;Indice
    
    J dw 0 ;indice auxiliar para multiplicação de matriz
    
    acumulador dw 0 ;ACUMULADOR DE MULTIPLICAÇÕES
    

    tam dd 9 ;tamanho total das matrizes
    mat1 times 100 dw 1,2,3,4,5,6 ;Matriz principal
    mat2 times 100 dw 2 ;Matriz Secundaria
    
    mat3 times 50 dw 0 ;Matriz resposta 
    
    vet times 100 dw 2,3,2 ;Vetor principal, usado pela funcao "mulVet"
    vetr times 100 dw 0 ;Vetor resposta da funcao "mulVet"
    
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    call LerM1
    call LerM2
   ; call mulmat
    NEWLINE
    
    call igualdade
    
    call Subt
    call PrintM
NEWLINE
    PRINT_DEC 4, eax
    
    xor eax, eax
    ret
    
LerM1: ; Passar para ECX o endereço da matriz na qual quer ser lida antes de charmar a função

    GET_UDEC 2, [lm1] ; LENDO LINHA matriz 1
    GET_UDEC 2, [cm1] ; LENDO COLUNA matriz 1
    
    pushad ; LENDO PRIMEIRA MATRIZ
    
    mov ax, [cm1]
    mul word [lm1]
    
    mov ecx, mat1
    
    mov esi, tam
    mov [esi], ax
    
    .lp1:

        GET_DEC 2, [ecx]
        add ecx, 2
        dec eax

    cmp eax, 0
    jne .lp1
    
    popad
    
ret

LerM2: ; Passar para ECX o endereço da matriz na qual quer ser lida antes de charmar a função

    GET_UDEC 2, [lm2] ; LENDO LINHA matriz 2
    GET_UDEC 2, [cm2] ; LENDO COLUNA matriz 2
    
    pushad ; LENDO PRIMEIRA MATRIZ
    mov ax, [cm2]
    mul word [lm2]
    
    mov ecx, mat2
    
    mov esi, tam
    mov [esi], ax
    
    .lp1:

        GET_DEC 2, [ecx]
        add ecx, 2
        dec eax

    cmp eax, 0
    jne .lp1
    
    popad
    
ret


PrintM:; Printar a matriz1
pushad 
    mov ax,[cm1]
    mul word [lm1]
    mov ecx, mat1
    mov bx, [cm1]

    .lp1:

        PRINT_DEC 2, [ecx]
        PRINT_STRING " | "
        dec bx
        cmp bx, 0d
        jne .fund ; Quando a coluna chegar a 0, da newline e reseta o valor 
            NEWLINE
            mov bx, [cm1]
        .fund:
        
        add ecx, 2
        dec eax

    cmp eax, 0
    jne .lp1
    
    popad
    ret
    
PrintM3:; Printar a matriz 3
NEWLINE
pushad 
    mov ax,[lm1]
    mul word [cm2]
    mov ecx, mat3
    mov bx, [cm2]

    .lp1:

        PRINT_DEC 2, [ecx]
        PRINT_STRING " | "
        dec bx
        cmp bx, 0d
        jne .fund ; Quando a coluna chegar a 0, da newline e reseta o valor 
            NEWLINE
            mov bx, [cm2]
        .fund:
        
        add ecx, 2
        dec eax

    cmp eax, 0
    jne .lp1
    
    popad
ret

Subt: ;implmenta a função de subtracao entre 2 matrizes Mat1 e Mat2, e salva em mat1
; As 2 matrizes deve ter o mesmo tamanho N x M, e deve sem do tipo WORD

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
Soma:

    pushad ; Soma a Matriz 1 com a Matriz 2, Salva na Matriz 1
    
    movzx eax, word [tam]
    
    mov ecx, mat1
    mov ebx, 0d
    .lp1:
    
        mov dx, [ecx]
        add dx, [mat2+ebx]
        mov [ecx], dx


        add ebx, 2
        add ecx, 2
        dec eax
    cmp eax, 0
    jne .lp1
    
    popad
    
ret

igualdade: ; Implementa a funcao de comparar duas matrizes, retorna 1 em EAX se forem iguais, 0 se contrario
;Recebe 2 variaveis que devem ser chamadas de mat1(matriz A) e mat2(MATRIZ B), devendo ser do tipo WORD, obrigatoriamente
push ecx
push edx

    mov ebx, 0
    mov ecx, 0
    mov eax, 1 ; Seta eax para 1, retorno padrao
    mov edx,0
    .lp1:
    
    mov cx, [mat1+edx]
    cmp cx, [mat2+edx]
    jne .notEql
    
    
    add edx,2
    inc bx
    cmp bx, [tam]
    
    jne .lp1
    
    jmp .fim
    
    .notEql:
     mov eax, 0
    .fim:
    
pop edx
pop ecx
ret

oposta: ; Implementa funcao que retorna uma matriz oposta a de mat1, salva em mat1
;Recebe uma matriz chamada de mat1, do tipo WORD, obrigatoriamente
    pushad
    
    mov ecx,2
    mov eax, [tam]
    mul ecx
    mov esi, mat1
    add esi, eax 
    
    add eax,2
    
    .lp1:
    
        sub eax, 2

        mov bx, [mat1+eax] ;Valor da matriz
        not bx ; Negando valor do indice da matriz
        add bx, 1 ; corrigindo valor 
        mov [esi], bx ; colocando valor negado de volta

    sub esi, 2
    
    cmp eax, 0
    jne .lp1
    
    
    popad
ret


transposta: ; salva a matriz1 transposta em matriz 3
 pushad
    ; total de colunas * linha desejada + coluna desejada
    
    mov ecx, 0 ; contador de tamanho
    mov ebx, 0 ; valor da mat1
    
    .lp1: ;linha
    
        mov esi, i
        mov [esi], ecx
        push ecx
        mov ecx, 0d 
        
        .lp2: ;coluna
        
            mov ax, [cm1]
            mul cx
            add eax, [i]
            mul word [btam]
            mov edx, 0
            
            push edx ; inserindo elemento da mat1 na mat3
            
            mov dx, [mat1+eax] ; movendo endereço de mat3 (matriz resposta) para esi
            mov esi, mat3 ;recebendo valor a ser trocado da matriz 1
            add esi, ebx
            mov [esi], dx ; inserindo elementos da mat1 em mat3
            
            add ebx, 2d
            pop edx
            
           
     
         inc cx
         cmp cx, [lm1]
         jne .lp2
         ; ----------------------- FIM LOOP 2
     pop ecx
    inc cx
    cmp cx, [cm1]
    jne .lp1 

         
    popad
    call PrintM3t
ret
 
mulmat:
   ;Implementa multiplicação de matrizes (mat3 = mat1 * mat2) 
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


  
mulVet: ; Multiplica Mat1 por vet1, salva em vetR
    pushad
    ;Passando parametos da funcao "LerVet"
    mov esi, vet 
    movzx eax, word [lm1]
    ;=====================================
    
    call LerVet ; Lendo vetor antes de chamar a função
    
    mov esi, 0
    mov eax, 0
    mov cx, 0
    mov ebx, mat1
    
        .lp1:
            
            
            mov esi, i
            mov [esi], ecx ;Movendo ecx para variavel "I"
            
            push ecx
            mov cx, 0d 
            mov edx, 0
            
            .lp2:
            
                push edx
                
                mov ax,  [vet + edx]
                mul word [ebx]
                mov edx, acumulador
                add [edx], eax
                pop edx
                
                add edx, 2d
                add ebx, 2d
                    
                inc cx
                cmp cx, [cm1]
                jne .lp2
        pop ecx
        
        mov esi, vetr ; movendo vetor de resultado para ESI
        
        movzx eax, byte cl ; descobrindo onde vai ser salvo no vetor resposta
        mul word[btam] ;========================================================
        add esi, eax ; =========================================================
        
        mov edx, [acumulador] ; Pegando o valor acumulado no LOOP 2 (vulgo lp2)
        mov [esi], edx  ; Salvando o valor acumulador
        
        mov edx, acumulador ;Recebendo acumulador
        mov word [edx], 0 ;zerando acumulador para iniciar a contagem
        
        inc cx
        cmp cx, [tam]
        jne .lp1
        
    popad
ret  

PrintVR:
pushad 
    mov eax, 1d
    mul byte [lm1]
    mov ecx, vetr
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
    
PrintM3t:; Printar a matriz3 na forma transposta (matriz resposta)
pushad 
    mov ax,[cm1]
    mul word [lm1]
    mov ecx, mat3
    mov bx, [lm1]

    .lp1:

        PRINT_DEC 2, [ecx]
        PRINT_STRING " | "
        dec bx
        cmp bx, 0d
        jne .fund ; Quando a coluna chegar a 0, da newline e reseta o valor 
            NEWLINE
            mov bx, [lm1]
        .fund:
        
        add ecx, 2
        dec eax

    cmp eax, 0
    jne .lp1
    
    popad
ret

LerVet: ; Ler vetor (Passar para ESI o endereço do vetor, e para EAX o tamanho das linhas da matriz 1)
pushad
;    mov esi, vet
;   mov eax, [lm1]
    
    .lp1:
        
        GET_DEC 2, [esi]
        add esi, 2
    
    dec eax
    cmp eax, 0
    jne .lp1
    
    
    
popad
ret