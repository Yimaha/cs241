.import print
.import init
.import new
.import delete
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
lis $2
.word 0
sw $31, -4($30)
sub $30, $30, $4
lis $31
.word init
jalr $31
add $30, $30, $4
lw $31, -4($30)
beq $0, $0, wain
wain:
lis $3
.word 1
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 10
add $1, $3, $0
sw $31, -4($30)
sub $30, $30, $4
lis $31
.word new
jalr $31
add $30, $30, $4
lw $31, -4($30)
bne $3, $0, 1
add $3, $11, $0
sw $3, -8($29)
lis $3
.word 4
sw $3, -4($30)
sub $30, $30, $4
lw $3, -8($29)
add $30, $30, $4
lw $5, -4($30)
sw $5, 0($3)
sw $1, -4($30)
sub $30, $30, $4
lw $3, -8($29)
lw $3, 0($3)
add $1, $3, $0
sw $31, -4($30)
sub $30, $30, $4
jalr $10
add $30, $30, $4
lw $31, -4($30)
add $30, $30, $4
lw $1, -4($30)
lw $3, -8($29)
beq $3, $11, skipDelete0
add $1, $3, $0
sw $31, -4($30)
sub $30, $30, $4
lis $31
.word delete
jalr $31
add $30, $30, $4
lw $31, -4($30)
skipDelete0:
lw $3, 0($29)
add $30, $30, $4
add $30, $30, $4
add $30, $30, $4
add $30, $29, $4
jr $31
