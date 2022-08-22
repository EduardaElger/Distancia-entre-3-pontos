# Cálculo entre três pontos.

Programa que realiza o cálculo da distância de 3 pontos em assembly.

_Instruções gerais:_

- Entradas:
  - Dois vetores, na seguinte ordem:
    - Primeiro vetor: (x1, y1, z1)
    - Segundo vetor: (x2, y2, z2)
  - Todas as entradas serão em ponto flutuante, de precisão dupla.
- Saídas:
  - A saída ocorrera em um arquivo que será criado com o nome e extensão definida na linha 16 na variável nomearquivo.
  - O dado armazenado no arquivo também será um valor em ponto flutuante de precisão dupla.
- Funções:
  - Funções externas utilizadas:
    - extern printf (utilizada para realizar a escrita na tela)
    - extern scanf (utilizada para armazenar valores digitados)
    - extern fopen (utilizada para abrir arquivo)
    - extern fclose (utilizada para fechar arquivo)
    - extern fprintf (utilizada para escrever no arquivo)
  - Funções criadas:
    - dis3Dlm: Função que realiza o cálculo da distância, ela possui a seguinte assinatura:

	dis3Dlm(double\* p1, double\* p2)

	Além disto, ela realizará o seguinte cálculo:

    - abrearquivo: Função que cria, escreve e fecha o arquivo, utilizando as funções externas descritas anteriormente. Lembrando que toda vez que o programa é executado o arquivo é recriado, ou seja, ele escreve apenas o resultado atual, perdendo os demais de execuções passadas.
- Execução:
  - Montar: nasm -f elf64 main.asm
  - Linkar: gcc -m64 -no-pie main.o -o main.x
  - Executar: ./main.x
