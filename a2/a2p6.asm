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
jr $31;
