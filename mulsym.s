

.data  #start with the data section

multiplier:	#multiplier matrix
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6

multiplicand:	#multiplicand matrix
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6

row:	#current row
	.long 1	

col:	#current column
	.long 1

.text	#start of text section

.globl _start
_start:	#Loads corresponding matricies into correct positions

	call init #initializes registers	
	jmp mulsym	#calculates current element


#find the element we wish to calculate
mulsym:
	
row_op:
	
	addl $1, row #after row operations finish, increase row by one
	cmpl row, %edx
	jl inc_col #if rows are larger than dimensions, move to next col
	jge row_op	#else repeat the row ops


	#retrieve columns of multiplicand matrix
	#calculate the product of matrix
	#calculates the element
	#inserts product into product matrix
	#increase count
	

	


init:
	movl $3, %edx	#copy matrix size into register
	movl $multiplier, %esi	#copy multiplier matrix into register
	movl $multiplicand, %edi	#copy multiplicand matrix into register
	movl $1, row
	movl $1, col
	ret

inc_col:
	movl $1, row #reset rows to 1
	addl $1, col #add 1 to columns
	cmpl col, %edx
	jl done	#if the columns is larger than the dimensions, the program is done
	jge row_op	#if colums is equal or less than the dimensions, repeat the row ops
	

done:	

