.import print
lis $4
.word 4
lis $10
.word print
lis $11
.word 1
sub $29, $30, $4
sw $1, -4($30)
sub $30, $30, $4
sw $2, -4($30)
sub $30, $30, $4
lis $3
.word 1
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
sw $3, -4($30)
sub $30, $30, $4
loop0:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, 0($29)
add $30, $30, $4
lw $5, -4($30)
slt $3, $5, $3
beq $3, $0, endWhile0
lis $3
.word 1
sw $3, -12($29)
loop1:
lw $3, -12($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
add $30, $30, $4
lw $5, -4($30)
slt $3, $5, $3
beq $3, $0, endWhile1
sw $1, -4($30)
sub $30, $30, $4
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -12($29)
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
add $1, $3, $0
sw $31, -4($30)
sub $30, $30, $4
jalr $10
add $30, $30, $4
lw $31, -4($30)
add $30, $30, $4
lw $1, -4($30)
lw $3, -12($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -12($29)
beq $0, $0, loop1
endWhile1:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -8($29)
beq $0, $0, loop0
endWhile0:
loop2:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, 0($29)
add $30, $30, $4
lw $5, -4($30)
slt $3, $3, $5
beq $3, $0, endWhile2
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
sub $3, $5, $3
sw $3, -8($29)
beq $0, $0, loop2
endWhile2:
loop3:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, 0($29)
add $30, $30, $4
lw $5, -4($30)
slt $6, $3, $5
slt $7, $5, $3
add $3, $6, $7
sub $3, $11, $3
beq $3, $0, endWhile3
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -8($29)
sw $1, -4($30)
sub $30, $30, $4
lw $3, -8($29)
add $1, $3, $0
sw $31, -4($30)
sub $30, $30, $4
jalr $10
add $30, $30, $4
lw $31, -4($30)
add $30, $30, $4
lw $1, -4($30)
beq $0, $0, loop3
endWhile3:
loop4:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, 0($29)
add $30, $30, $4
lw $5, -4($30)
slt $3, $5, $3
sub $3, $11, $3
beq $3, $0, endWhile4
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
sub $3, $5, $3
sw $3, -8($29)
sw $1, -4($30)
sub $30, $30, $4
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -12($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -8($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -12($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
add $1, $3, $0
sw $31, -4($30)
sub $30, $30, $4
jalr $10
add $30, $30, $4
lw $31, -4($30)
add $30, $30, $4
lw $1, -4($30)
beq $0, $0, loop4
endWhile4:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -8($29)
loop5:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, 0($29)
add $30, $30, $4
lw $5, -4($30)
slt $6, $3, $5
slt $7, $5, $3
add $3, $6, $7
beq $3, $0, endWhile5
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 2
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
sw $3, -8($29)
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 3
add $30, $30, $4
lw $5, -4($30)
div $5, $3
mflo $3
sw $3, -8($29)
beq $0, $0, loop5
endWhile5:
sw $1, -4($30)
sub $30, $30, $4
lis $3
.word 3
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 5
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 9
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
add $1, $3, $0
sw $31, -4($30)
sub $30, $30, $4
jalr $10
add $30, $30, $4
lw $31, -4($30)
add $30, $30, $4
lw $1, -4($30)
lw $3, 0($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -8($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -12($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
add $30, $30, $4
add $30, $30, $4
add $30, $30, $4
add $30, $30, $4
add $30, $29, $4
jr $31
