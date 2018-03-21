main:
li $s0,2
mtc1 $s0,$f2
cvt.s.w $f2,$f2 # Coloca o valor 2 em F.P. para o calculo da inversa
li $s0,0
mtc1 $s0,$f7
cvt.s.w $f7,$f7 # Coloca o valor 0 em F.P. 
# li $v0,51 # *-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-*
# add $a0,$v0,$zero #  *-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-
# syscall # Lê um valor do teclado    *-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-**-*-*-
 addi $v0,$zero,36 # Definição do valor a ser calculado *Mude o valor para trocar *-*-*-*-**-*-*-*-*-*-*-**-*-*-*-*-*-*-*
add $s0,$zero,$v0 # Salva o valor lido em uma variavel
mtc1 $v0,$f0 # Move o valor lido para o C1
cvt.s.w $f0,$f0 # Trasnforma o valor lido para F.P.
div.s $f1,$f0,$f2 # Definição do chute inicial
j Fim

FX:
mul.s $f3,$f1,$f1 # Encontra x^2
sub.s $f4,$f3,$f0 # Encontra o valor de F(X)=x^2 - (numero lido)
jr $ra

FiX:
mul.s $f5,$f1,$f2 # Calculo de F'(X) = 2*X
jr $ra

FXdivFiX:
sw $ra,0($sp) # Salva endereço de retorno na pilha
jal FX # Chama F(X)
jal FiX # Chama F'(X)
div.s $f6,$f4,$f5 # F(X)/F'(X)
lw $ra,0($sp) # Recupera o endereço de retorno da pilha
jr $ra

Retorno:
sw $ra,4($sp) # Salva endereço de retorno para o fim na pilha
Raiz:
sw $ra,8($sp)
addi $a0,$a0,1 # Aumenta 1 unidade ao contador
jal FXdivFiX # Chama F(X)/F'(X)
sub.s $f12,$f1,$f6 # Calculo da raiz ou do "chute" para o próximo ciclo R = X - (F(X)/F'(X))
add.s $f1,$f12,$f7 # Salva o chute para o próximo ciclo 
slti $t0,$a0,10 # 10 ciclos para precisão 
bne $t0,0,Volta # Refaz o ciclo
lw $ra,8($sp) # Recupera o endereço de retorno da pilha
jr $ra # Retorna para a função
Volta:
jal Raiz # Garante a função com recursão
lw $ra,4($sp) # Recupera o endereço de retorno para o fim da pilha
jr $ra # Retorna para o fim
Fim:
li $a0,0 # Definição inicial do contador
jal Retorno # Inicia o ciclo
# Fim2:
li $v0,2
add $a0,$v0,$zero
syscall # Mostra na tela o resultado
