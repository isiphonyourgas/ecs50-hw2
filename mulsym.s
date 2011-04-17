

.data  #start with the data section

multiplier:	#multiplier matrix
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.long	8
	.long	9
	.long	10

multiplicand:	#multiplicand matrix
	.long	9
	.long	8
	.long	5
	.long	7
	.long	13
	.long	88
	.long	64
	.long	78
	.long	6
	.long	33

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
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0


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
	addl $-4, %esi
	addl $-4, %edi
row_op:
	
	
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

	movl row, %eax#preps eax as row -1 for call set_next_row
#	subl $1, %eax
	cmpl %eax, %edx	
	jg set_multiplier
	addl $1, %edx
	call reset_multiplier
	
part4:
	call set_multiplicand
	addl $1, row #after row operations finish, increase row by one
	cmpl row, %edx
	mov $0, %eax
	jl inc_col #if rows are larger than dimensions, move to next col
	jge row_op	#else repeat the row ops


	#retrieve columns of multiplicand matrix
	#calculate the product of matrix
	#calculates the element
	#inserts product into product matrix
	#increase count
	

	


init:
	movl $4, %edx	#copy matrix size into register
	movl $multiplier, %esi	#copy multiplier matrix into register
	movl $multiplicand, %edi	#copy multiplicand matrix into register
	movl $product, %ebp
	movl $1, row
	movl $1, col
	movl %edx, size
	ret

set_multiplier:
	subl $1, %edx
	subl %edx, %esi
	subl %edx, %esi
	subl %edx, %esi
	subl %edx, %esi
	cmpl row, %edx
	jnz set_multiplier
#	cmpl $1, %edx
#	jnz set_multiplier2
revert_multiplier:
	movl size, %edx
#	addl $4, %esi
	jmp part4

set_multiplier2:
	subl $1, %edx
	subl $4, %esi
	cmpl $1, %edx
	jnz set_multiplier2
	jmp revert_multiplier

reset_multiplier:
	subl $1, %edx
	subl %edx, %esi
	subl %edx, %esi
	subl %edx, %esi
	subl %edx, %esi
	cmpl $1, %edx
	jnz reset_multiplier
	movl size, %edx
	ret
set_r:
	subl $1, %edx
	subl %edx, %esi
	subl %edx, %esi
	subl %edx, %esi
	subl %edx, %esi
	subl %edx, %edi
	subl %edx, %edi
	subl %edx, %edi
	subl %edx, %edi
	addl $4, %esi
	addl $4, %edi
	add $1, %edx
	jmp part4
	
set_multiplicand:
	subl $1, %edx
	subl %edx, %edi
	subl %edx, %edi
	subl %edx, %edi
	subl %edx, %edi
	cmpl col, %edx
	jnz set_multiplicand
	cmpl $1, %edx
	jnz set_multiplicand2
revert_multiplicand:
	movl size, %edx
	subl $4, %edi
	ret

set_multiplicand2:
	subl $1, %edx
	subl $4, %edi
	cmpl $1, %edx
	jnz set_multiplicand2
	jmp revert_multiplicand

	
	

inc_col:
	movl $1, row #reset rows to 1
inc_col2:
	addl col, %edi
	addl col, %edi
	addl col, %edi
	addl col, %edi
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

