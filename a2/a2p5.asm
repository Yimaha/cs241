
lis $7;
.word 0xffff000c;
lis $3;
.word 0x40;
lis $4;
.word 4;
lis $9;
.word 0x20;
add $5, $0, $1;
mult $2, $4;
mflo $6;
add $6,$6,$1;
bne $2,$0,1;
	jr $31;

	lw $8,0($5);
	bne $8,$0,1;
		add $8,$9,$0;
	beq $8,$9,1;
		add $8,$3,$8;
	sw $8, 0($7);
	add $5,$5,$4;
bne $5,$6,-8;
jr $31;
