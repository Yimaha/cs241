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
lis $3
.word 1
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
sw $3, -4($30)
sub $30, $30, $4
lw $3, -16($29)
sw $3, -20($29)
lis $3
.word -8
add $3, $3, $29
sw $3, -20($29)
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
sw $3, -20($29)
lis $3
.word 1000
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
sw $3, -16($29)
lw $3, -20($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 12
mult $3, $4
mflo $3
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -20($29)
lis $3
.word 12
mult $3, $4
mflo $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -20($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -20($29)
lw $3, -20($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -16($29)
add $30, $30, $4
lw $5, -4($30)
sub $3, $5, $3
div $3, $4
mflo $3
sw $3, -12($29)
lw $3, -20($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 12
mult $3, $4
mflo $3
add $30, $30, $4
lw $5, -4($30)
sub $3, $5, $3
sw $3, -20($29)
lw $3, -12($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -20($29)
add $30, $30, $4
lw $5, -4($30)
sw $5, 0($3)
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 12
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -20($29)
add $30, $30, $4
lw $5, -4($30)
sw $5, 0($3)
loop0:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
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
lw $3, -4($29)
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
lw $3, -4($29)
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
lw $3, -4($29)
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
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
slt $3, $3, $5
sub $3, $11, $3
beq $3, $0, endWhile5
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 1
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
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
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
add $30, $30, $4
lw $5, -4($30)
slt $3, $5, $3
sub $3, $11, $3
beq $3, $0, else0
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 100
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -8($29)
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
add $30, $30, $4
lw $5, -4($30)
slt $6, $3, $5
slt $7, $5, $3
add $3, $6, $7
sub $3, $11, $3
beq $3, $0, else1
lw $3, -12($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 12
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -8($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -12($29)
beq $0, $0, endif1
else1:
endif1:
beq $0, $0, endif0
else0:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 100
add $30, $30, $4
lw $5, -4($30)
sub $3, $5, $3
sw $3, -8($29)
endif0:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
add $30, $30, $4
lw $5, -4($30)
slt $3, $5, $3
sub $3, $11, $3
beq $3, $0, else2
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 100
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -8($29)
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
add $30, $30, $4
lw $5, -4($30)
slt $6, $3, $5
slt $7, $5, $3
add $3, $6, $7
sub $3, $11, $3
beq $3, $0, else3
lw $3, -12($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 12
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -8($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -12($29)
beq $0, $0, endif3
else3:
endif3:
beq $0, $0, endif2
else2:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 100
add $30, $30, $4
lw $5, -4($30)
sub $3, $5, $3
sw $3, -8($29)
endif2:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
add $30, $30, $4
lw $5, -4($30)
slt $3, $5, $3
sub $3, $11, $3
beq $3, $0, else4
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 100
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -8($29)
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
add $30, $30, $4
lw $5, -4($30)
slt $6, $3, $5
slt $7, $5, $3
add $3, $6, $7
sub $3, $11, $3
beq $3, $0, else5
lw $3, -12($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 12
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, -8($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
sw $3, -12($29)
beq $0, $0, endif5
else5:
endif5:
beq $0, $0, endif4
else4:
lw $3, -8($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 100
add $30, $30, $4
lw $5, -4($30)
sub $3, $5, $3
sw $3, -8($29)
endif4:
lw $3, -20($29)
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
lw $3, -16($29)
beq $3, $11, skipDelete1
add $1, $3, $0
sw $31, -4($30)
sub $30, $30, $4
lis $31
.word delete
jalr $31
add $30, $30, $4
lw $31, -4($30)
skipDelete1:
lw $3, 0($29)
add $30, $30, $4
add $30, $30, $4
add $30, $30, $4
add $30, $30, $4
add $30, $30, $4
add $30, $30, $4
add $30, $29, $4
jr $31
