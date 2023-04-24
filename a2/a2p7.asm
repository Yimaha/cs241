

beq $2,$0,return;

lis $5;
.word 4;
mult $5,$2;
mflo $2;

add $3,$1,$2;
add $6,$1,$0;
lis $4;
.word print;
	
label:	sw $31, -4($30);
	lis $31;
	.word -4;
	add $30, $30, $31;
	lw $1,0($6);
	jalr $4;
	add $6, $6, $5;
	lis $31;
	.word 4
	add $30, $30, $31
	lw $31, -4($30)
bne $6, $3, label;
return: jr $31;
