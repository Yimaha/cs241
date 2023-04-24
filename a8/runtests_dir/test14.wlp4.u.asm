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
lis $8
.word new
lis $9
.word delete
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
.word wain
jr $3
Fthree:
sub $29, $30, $4
sw $5, -4($30)
sub $30, $30, $4
sw $6, -4($30)
sub $30, $30, $4
sw $7, -4($30)
sub $30, $30, $4
lw $3, 12($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, 8($29)
add $30, $30, $4
lw $5, -4($30)
mult $3, $5
mflo $3
sw $3, -4($30)
sub $30, $30, $4
lw $3, 4($29)
add $30, $30, $4
lw $5, -4($30)
add $3, $5, $3
add $30, $30, $4
lw $7, -4($30)
add $30, $30, $4
lw $6, -4($30)
add $30, $30, $4
lw $5, -4($30)
add $30, $29, $4
jr $31
wain:
sw $29, -4($30)
sub $30, $30, $4
sw $31, -4($30)
sub $30, $30, $4
lw $3, 0($29)
sw $3, -4($30)
sub $30, $30, $4
lw $3, -4($29)
sw $3, -4($30)
sub $30, $30, $4
lis $3
.word 20
sw $3, -4($30)
sub $30, $30, $4
lis $31
.word Fthree
jalr $31
add $30, $30, $4
lw $5, -4($30)
add $30, $30, $4
lw $5, -4($30)
add $30, $30, $4
lw $5, -4($30)
add $30, $30, $4
lw $31, -4($30)
add $30, $30, $4
lw $29, -4($30)
add $30, $29, $4
jr $31
