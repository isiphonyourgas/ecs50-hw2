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
	
	movl $1, %ecx	#keeps track of current element stored by column-by-column
			#Note this is not a symetric matrix

	jmp calc_elm	#calculates current element


#find the element we wish to calculate
calc_elm:
	
	#jumps to retrieve row of multiplier matrix determined by ecx
	#retrieve columns of multiplicand matrix
	#calculate the product of matrix
	#calculates the element
	#inserts product into product matrix
	#increase count
	#jump to the next element within the matrix
	



done:	

