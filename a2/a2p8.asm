
sw $31, -4($30); 
lis $31;
.word -4;
add $20, $0, $1;
add $30, $30, $31
lis $4;
.word depth;
jalr $4;

lis $31
.word 4
add $30, $30, $31
lw $31, -4($30)

jr $31




depth: 

sw $1, -4($30);# PARAM: reference to the root
sw $2, -8($30);# CONST: -1 for increment and compare
sw $3, -12($30);# Current Depth of the tree;
sw $4, -16($30);# CONST: 4;
sw $5, -20($30);# used for left address then store left depth;
sw $6, -24($30);# address / results in left;
sw $7, -28($30);# address / results in right;
sw $8, -32($30);# index tracker;
sw $9, -36($30);# temp variables.

lis $9;
.word -36;
add $30, $30, $9;
lis $4;
.word 4;
lis $2;
.word -1
sub $3, $3, $2;
add $8, $1, $8; #go to the current index
lw $5, 4($8); #load address of left on $5
lw $6, 8($8); #load address of right on $6



bne $5, $2, depthLeft;

beq $5, $2, noneLeft;

depthLeft:
	    mult $5, $4;
	    mflo $9;
	    add $8, $0, $9;

	    sw $31, -4($30);
	    sw $3, -8($30);
	    lis $31;
	    .word -8;
	    add $30, $30, $31

	    lis $9;
	    .word depth;
	    jalr $9;

            add $5, $0, $3;

	    lis $31
	    .word 8
   	    add $30, $30, $31
	    lw $31, -4($30)
	    lw $3, -8($30)  

	    lis $9;
	    .word leftEvaluationComplete;
	    jr $9;
noneLeft:   add $5, $0, $3;
	    lis $9;
            .word leftEvaluationComplete;
            jr $9;

leftEvaluationComplete:

bne $6, $2, depthRight;
beq $6, $2, noneRight;

depthRight: 
            mult $6,$4;
            mflo $9;
            add $8, $0, $9;
	   
 	    sw $31, -4($30);
	    sw $3, -8($30);
            lis $31;
            .word -8;
            add $30, $30, $31

	    lis $9;
            .word depth;
            jalr $9;
	    add $6, $0, $3;

	    lis $31
	    .word 8
	    add $30, $30, $31
	    lw $31, -4($30);
	    lw $3, -8($30);

            lis $9;
            .word rightEvaluationComplete;
            jr $9;
noneRight: add $6, $0, $3;
            lis $9;
            .word rightEvaluationComplete;
            jr $9;

rightEvaluationComplete:

slt $7, $5, $6;
beq $7, $0,leftGreater;
bne $7, $0,rightGreater;

leftGreater: 	add $3, $0, $5;
 		lis $9;
		.word return;
 		jr $9;

rightGreater: 	add $3, $0, $6;
		lis $9;
		.word return;
		jr $9;
return:		
	lis $9;
	.word 36;
	add $30,$30,$9;
		
	lw $1, -4($30);# PARAM: reference to the root
	lw $2, -8($30);# CONST: -1 for increment and compare
	lw $4, -16($30);# CONST: 4
	lw $5, -20($30);# used for left address then store left depth;
	lw $6, -24($30);# address / results in left;
	lw $7, -28($30);# address / results in right;
	lw $8, -32($30);# temp address for current root;
	lw $9, -36($30);# temp variables.
		
	jr $31;
 	

