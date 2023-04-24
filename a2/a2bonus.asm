;# because we are given the length of the array, we just have to sort the array and take the middle number and we are good. ;
;# to satisfy the time constraint, one may use merge sort.


sw $31, -4($30);
lis $31;
.word -4;
add $30, $30, $31;

lis $4;
.word merge;
jalr $4;

lis $31
.word 4
add $30, $30, $31
lw $31, -4($30)

lis $5;
.word 2;
lis $6;
.word 4;
div $2, $5;
mflo $5;
mult $5, $6;
mflo $5;
add $5, $5, $1;

lw $3, 0($5);

jr $31




merge:		

;# initializing $5 before other register because it will be return.
;# unlike last question where just pass back a value, we have to pass a reference back this time (array)
;# assumption is that, the program that calles that function should ready their $5 as the return Array[0] location, so we can directly modify it.



;# presaving the register

	sw $1, -4($30); # current Array start memory
	sw $2, -8($30); # current Array length
	sw $3, -12($30); # array left
	sw $4, -16($30); # array right
	sw $6, -20($30); # temp variable
	sw $7, -24($30); # temp variable
	sw $8, -28($30); # temp variable
	sw $9, -32($30); # temp variable
	sw $10, -36($30); #store the length of return array
	sw $11, -40($30); #temp variable
	sw $12, -44($30); #temp variable 
	sw $13, -48($30); #temp variable
	sw $14, -52($30); #temp variable

	lis $6;
	.word -52;
	add $30, $30, $6; 
	
;# check if array.length === 1;
	lis $6;
	.word 1;
	bne $6, $2, lengthNotOne;
		beq $0, $0, return;
lengthNotOne:

;# check if array.length === 2
	lis $6;
	.word 2;
	lis $9;
	.word 4;

	bne $6, $2, lengthNotTwo;
		lw $7, 0($1);
		lw $8, 4($1);
		slt $6, $7, $8
		bne $6, $0, return; # if [0] > [1] then order is right, just return
		sw $8, 0($1);
		add $10, $1, $9;
		sw $7, 0($10);
		beq $0, $0, return;
lengthNotTwo:

;# if not 1 or 2, start recursively call function.
	lis $6;
	.word 2;
	div $2,$6; # get the median value
	mflo $6;
	mfhi $7;

;# get the left part of the array
	sw $31, -4($30);
	sw $2, -8($30);
;# no need to save beginning address, since it will not be modified
	lis $31;
	.word -8;
	add $30, $30, $31;
	
	add $2, $6, $0;
	beq $7, $0, evenSkip2; # if remainder is 0, then you don't need to add it by 1
		add $2, $2, $7; # in case where remainder is 1, you neec to add it by 1
evenSkip2:
	add $13, $0, $2;
	lis $8;
	.word merge;
	jalr $8;

	add $3, $0, $1; # save the left array
	add $21, $0, $3;
	lis $31;
	.word 8;
	add $30, $30, $31;
	lw $31, -4($30);
	lw $2, -8($30);

;# get the right part of the array
	sw $31, -4($30);
	sw $2, -8($30);
	sw $1, -12($30);
	lis $31;
	.word -12;
	add $30, $30, $31;
	
	add $2, $6, $0; # set the length of next array

	lis $8; 
	.word 4;
	mult $8, $6; # find out how much address forward
	mflo $6;
	add $1, $1, $6;	 # set the address of [0] for the next function at $1
 
	beq $7, $0, evenSkip1; # if remainder is 0, then you don't need to add $1 by 4
		add $1, $1, $8; # in case where remainder is 1, you neec to add it by 4
evenSkip1:
	add $14, $0, $2
	lis $8;
	.word merge;
	jalr $8;

	add $4, $0, $1; # save the right array
	add $22, $0, $4;
	lis $31;
	.word 12;
	add $30, $30, $31;
	lw $31, -4($30);
	lw $2, -8($30);
	lw $1, -12($30);



;# now merge sort after right and left array are retrieved;
	lis $6; # ++ amount
	.word 4;
	lis $8; # i-counter
	.word 0;
	mult $6, $2;
	mflo $9;
	sub $10, $30, $9;
	sub $30, $10, $0;	
	
	mult $13, $6;
	mflo $13;

	mult $14, $6;
	mflo $14;

while1:
	lis $7;
	.word 2;
	div $2, $7;
	mflo $11;
	mfhi $12;

	lw $11, 0($3);
	lw $12, 0($4)
	slt $7, $11, $12;
        beq $13, $0, leftGreater;
        beq $14, $0, rightGreater;

	beq $7, $0, leftGreater;
	bne $7, $0, rightGreater;

rightGreater:
	sw $11, 0($10);	 
	add $3, $3, $6;
	add $24, $24, $6;
	sub $13, $13, $6;
	beq $0, $0, finishPushing;
leftGreater:  
	sw $12, 0($10);	 
	add $4, $4, $6;
	add $25, $6, $25;
	sub $14, $14, $6;
	beq $0, $0, finishPushing;

finishPushing:
	add $10, $10, $6;
	add $8, $8, $6;
	bne $8, $9, while1; # if $8 havn't reached the length, then repeat the process again. 
	lis $7;
	.word 0;
	sub $10, $10, $9
while2: 
	add $8, $1, $7; # find the current index
	lw $11, 0($10);
	sw $11, 0($8); # update current index
	add $10, $10, $6; # index ++
	add $7, $7, $6; # index ++ 
	bne $7, $9, while2; # if index has not reach the end, reapeat.

	add $30, $30, $9;	
	beq $0, $0, return;


return:

;# putting back the register (no $5 given that it is suppose to be saved already);


 	lis $6;
	.word 52;
	add $30, $30, $6; 

;# note, now the $30 should be at array_return[0], which is stored in $5 as well

 	lw $1, -4($30); # current Array start memory (also serve as counter later)
	lw $2, -8($30); # current Array length
	lw $3, -12($30); # array left
	lw $4, -16($30); # array right
	lw $6, -20($30); # temp variable
	lw $7, -24($30); # temp variable
	lw $8, -28($30); # temp variable
	lw $9, -32($30); # temp variable
	lw $10, -36($30); # temp variable
	lw $11, -40($30); # temp variable
	lw $12, -44($30); # temp variable
        lw $13, -48($30); #temp variable
        lw $14, -52($30); #temp variable

	jr $31;
	
