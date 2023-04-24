lis $5;
.word 0;
sltu $4, $1, $2;
add $3, $0, $1;
beq $4, $5, 1;
add $3, $0, $2;
jr $31;
