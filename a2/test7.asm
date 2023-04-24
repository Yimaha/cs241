; push $31 on stack
sw $31, -4($30)
lis $31
.word -4
add $30, $30, $31

lis $1
.word 12345
lis $2
.word print
jalr $2 ; call procedure

; pop $31 from stack
lis $31
.word 4
add $30, $30, $31
lw $31, -4($30)

jr $31

print: 

sw $1,-4($30);
sw $3,-8($30);
sw $4,-12($30);
sw $5,-16($30);
sw $6,-20($30);
sw $7,-24($30);
sw $8,-28($30);
sw $9,-32($30);
sw $10,-36($30);
sw $11,-40($30);
sw $12,-44($30);

lis $12;
.word -44;
add $30,$30,$12;


lis $7;
.word 10;
lis $3;
.word 0xffff000c;
lis $6;
.word -4;
lis $11;
.word 0x0a;
lis $10;
.word 0x30;
add $9,$30,$0;
slt $5,$1,$0;

beq $5, $0,3;
	lis $8;
	.word 0x2d;
	sw $8, 0($3);

	div $1,$7;
	mfhi $4;
	mflo $1;
	beq $5,$0,1;
		sub $4,$0,$4;
	add $9,$9,$6;
	sw $4,0($9);
bne $1,$0,-8;

	lw $12, 0($9);
	add $12, $10, $12
	sw $12, 0($3);
	sub $9,$9,$6;
bne $9, $30, -5;

sw $11, 0($3);

lis $12;
.word 44;
add $30,$30,$12; 

lw $1,-4($30);
lw $3,-8($30);
lw $4,-12($30);
lw $5,-16($30);
lw $6,-20($30);
lw $7,-24($30);
lw $8,-28($30);
lw $9,-32($30);
lw $10,-36($30);
lw $11,-40($30);
lw $12,-44($30);


jr $31;
