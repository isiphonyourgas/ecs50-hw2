

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

product:
	.long 	0
	.long 	0
	.long 	0
	.long 	0
	.long 	0
	.long 	0
	.long 	0
	.long 	0
	.long 	0


row:	#current row
	.long	1	

col:	#current column
	.long	1

size:
	.long	3

.text	#start of text section

.globl _start
_start:	#Loads corresponding matricies into correct positions

	call init #initializes registers	
	jmp mulsym	#calculates current element


#find the element we wish to calculate
mulsym:
#	movl $0, %ecx	
row_op:
	addl $-4, %esi
	addl $-4, %edi
	movl $0, %ebx	
	movl $0, %ecx
multi:
	addl $1, %ecx	
	cmpl %ecx, row	#if the current row is greater than the  count
	jl add1a	#jump to add the corresponding slots
	addl $4, %esi
part2:	
	cmpl %ecx, col	#same as above but for column
	jl add1b
	addl $4, %edi
part3:	
	movl (%esi), %eax
	imull (%edi)
	movl size, %edx
	addl %eax, %ebx
#check then jump to multi

	
	cmpl %ecx, %edx
	jg multi

	movl %ebx, (%ebp)
	addl $4, %ebp


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
	movl $product, %ebp
	movl $1, row
	movl $1, col
	movl %edx, size
	ret

inc_col:
	movl $1, row #reset rows to 1
	addl $1, col #add 1 to columns
	cmpl col, %edx
	jl done	#if the columns is larger than the dimensions, the program is done
	jge row_op	#if colums is equal or less than the dimensions, repeat the row ops
	
add1a:
	addl $-1, %ecx
	addl %ecx, %esi
	addl %ecx, %esi
	addl %ecx, %esi
	addl %ecx, %esi
	addl $1, %ecx
	
	jmp part2

add1b:
	addl $-1, %ecx
	addl %ecx, %edi
	addl %ecx, %edi
	addl %ecx, %edi
	addl %ecx, %edi
	addl $1, %ecx
	jmp part3

done:	

