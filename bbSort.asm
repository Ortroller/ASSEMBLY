%include "io.inc"

section .data

    n dd 6
    i dd 0
    array dd 5,2,80,15,788,14
section .text
global CMAIN
CMAIN:
 
  mov esi, array
  mov eax, i
  
  
  call bubble
  call printArray
  
;PRINT_DEC 4, n
;NEWLINE
;PRINT_DEC 4, i
  
    ret
    
   ;int i, j; 
   ;for (i = 0; i < n-1; i++)       
 ;         
  ;     for (j = 0; j < n-i-1; j++)  
   ;        if (arr[j] > arr[j+1]) 
    ;          swap(&arr[j], &arr[j+1]); 

    
    
 
bubble: ; int array[], int n
    
    mov ecx, 0 ;i
    mov esi, array
    
    .for:
    cmp ecx, [n]
        jnl .p1
        
        push eax
        mov eax, i
        sub [eax] , ecx
        pop eax
        
           .for2:
           mov eax, 0 ;j
           cmp eax, [i]
           jnl .p2
           
            push esi
                add esi, eax
            push eax
                add esi, 1d
                mov eax, esi
                sub esi, 1d
                
                cmp esi, eax
                jle .if
                
                call swap
            
          
               .if:
               pop eax
               pop edx
           jmp .for2
           
        .p2:
    jmp .for
    .p1: ; sai do laco maior (1st for)
    
  
 
 ret
 
 swap: ; troca esi por eax
 
 pushad
    mov edx, [eax]
 
    mov ecx, [esi] ; AUX
    mov [esi], edx ;ESI recebe EAX
    mov [eax], ecx  ;EAX recebe ESI
 
 popad
 ret
 
 printArray:
 push esi
 push ecx
 mov ecx, [n]
 .loop:
 
   
    PRINT_DEC 4, [esi]
    NEWLINE
    add esi, 4
    
    sub ecx, 1
jnz .loop
 
 pop ecx
 pop esi
 ret