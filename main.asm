extern printf
extern scanf
extern fopen
extern fclose
extern fprintf

section .data
    escreve     : db "Entre com o ponto 1 (x.x y.y z.z): ",10,0

    leitura     : db "%lf %lf %lf",0

    escreve2    : db "Entre com o ponto 2 (x.x y.y z.z): ",10,0

    leitura2    : db "%lf %lf %lf",0

    nomearquivo : db "eduarda.lm.txt",0

    permicaoescrita : db "w" ,0

    saida       : db "%lf",10,0

section .bss
    pontos1    : resq 3
    pontos2    : resq 3 
    resultado  : resq 1
    resultado_handle : resq 1

section .text
    global main

main:
    push rbp
    mov rbp,rsp

    ;Inicio do primeiro printf
    xor rax, rax
    mov rdi, escreve
    call printf
    ;Fim do primeiro printf

    ;Inicio do primeiro scanf
    xor rax,rax
    mov rdi, leitura
    lea rsi, [pontos1] ;x1
    lea rdx, [pontos1 + 8] ;y1
    lea rcx, [pontos1 + 16] ;z1
    call scanf
    ;Fim do primeiro scanf

    ;inicio do segundo printf
    xor rax, rax
    mov rdi, escreve2
    call printf
    ;Fim do primeiro printf

    ;Inicio do segundo scanf
    xor rax, rax
    mov rdi, leitura2
    lea rsi, [pontos2]     ;x2
    lea rdx, [pontos2 + 8] ;y2
    lea rcx, [pontos2 + 16];z2
    call scanf
    ;Fim do segundo scanf

    ;Inicio da funcao dis3Dlm(double *p1, double* p2)
    lea rdi, [pontos1]
    lea rsi, [pontos2]
    call dis3Dlm
    ;final da funcao

    movsd [resultado], xmm0
    ;inicio gravacao no arquivo
    call abrearquivo
    ;Fim gravacao no arquivo

fim: 
    mov rsp, rbp
    pop rbp

    mov rsp, rsp
    mov rdi, 0

    syscall 

abrearquivo: 
    push rbp
    mov rbp,rsp

    ;inicio fopen
    mov rdi, nomearquivo
    mov rsi, permicaoescrita
    call fopen
    ;fim fopen

    mov [resultado_handle], rax

    ;Inicio da escrita no arquivo
    mov rax ,1
    movsd xmm0,[resultado]
    mov rdi, [resultado_handle]
    mov rsi, saida
    call fprintf
    ;fim da escrita em arquivo 

    ;inicio do fclose
    mov rdi, [resultado_handle]
    call fclose
    ;final do fclose

    mov rsp, rbp
    pop rbp

    ;retorno da funcao
    ret

dis3Dlm: 
    push rbp
    mov rbp, rsp

    movsd xmm1,[rdi] ;x1
    movsd xmm2,[rsi] ;x2

    movsd xmm3,[rdi + 8] ;y1
    movsd xmm4,[rsi + 8] ;y2

    movsd xmm5,[rdi + 16] ;z1
    movsd xmm6,[rsi + 16] ;z2

    subsd xmm1, xmm2 ;x1-x2
    subsd xmm3, xmm4 ;y1-y2
    subsd xmm5, xmm6 ;z1-z2
    
    mulsd xmm1, xmm1 ;x²
    mulsd xmm3, xmm3 ;y²
    mulsd xmm5, xmm5 ;z²

    addsd xmm1, xmm3 ;(x1-x2)²+(y1-y2)²
    addsd xmm1, xmm5 ;(x1-x2)²+(y1-y2)²+(z1-z2)²

    sqrtsd xmm0, xmm1

    mov rsp, rbp
    pop rbp

    ret