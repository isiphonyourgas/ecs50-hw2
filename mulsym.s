#This is just a test to load the matrix in

.data  #start with the data section

multiplier:
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6

multiplicand:
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6

.text	#start of text section

.globl _start
_start:	#Loads corresponding matricies into correct positions

	movl $3, %edx	#copy matrix size into register
	movl $multiplier, %esi	#copy multiplier matrix into register
	movl $multiplicand, %edi	#copy multiplicand matrix into register
	

	movl $1, cur_col	#sets the current column
	movl $1, cur_row	#sets teh current row

#find the element we wish to calculate
find_elm:
	add

#calculate the element and store to memory
#jump back to next calculation of element	

done:	

