#Jason Wong, Aaron Okano, Meenal Tambe, Gowtham Vijayaragavan

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
	.rept 16
	.long 	0
	.endr

row:	#current row
	.long	1	

col:	#current column
	.long	1

size:
	.long	0

.text	#start of text section

.globl _start
_start:	#Loads corresponding matricies into correct positions

	call init #initializes registers	
	call mulsym	#calculates current element
	jmp done

init:
	movl $4, %edx	#copy matrix size into register
	movl $multiplier, %esi	#copy multiplier matrix into register
	movl $multiplicand, %edi	#copy multiplicand matrix into register
	movl $product, %ebp
	movl $1, row
	movl $1, col
	ret

#find the element we wish to calculate
mulsym:
	movl %edx, size
	addl $-4, %esi
	addl $-4, %edi

#Begins the operation for the current element
row_op:
	movl $0, %ebx	#set running total to 0
	movl $0, %ecx	#set current sub-element to 0

#first call starts with the 1st sub-element
#ith call is the ith sub-element
#computes the 2 multiplied numbers together and adds them up (sub-elements)
#EBX stores teh running total
#ECX stores the current sub-element being calculated
multi:
	addl $1, %ecx	#increments a count for current part of element for multiplication and summation
	cmpl %ecx, row	#if the current row is greater than the  count
	jl add1a	#navigate to the next sub-element in the multiplier matrix needed
	addl $4, %esi	#sub-element is just 1 more away in position
part2:	
	cmpl %ecx, col	#same as above but for column
	jl add1b	#navigates to the next sub-element in multiplicand matrix
	addl $4, %edi	#sub-element is just 1 position away
part3:	
	movl (%esi), %eax	#moves multiplier sub-element into esi
	imull (%edi)		#multiplys multiplicand element with multiplier sub-element
	movl size, %edx		#ensures size is in edx
	addl %eax, %ebx		#adds the current sub-element to the runnign total of the element

#checks if finished with all sub-elements
	cmpl %ecx, %edx
	jg multi	#if not, moves to next sub elements

#if the current element is completed, puts element into product matrix
	movl %ebx, (%ebp)
	addl $4, %ebp	#increments for next product matrix

	cmpl row, %edx		#compares rows to the dimentions
	jg set_multiplier	#resets the multiplier for next element
	addl $1, %edx		#sets up %edx for next function call
	call reset_multiplier	#sets the multiplier for next column
	
part4:
	cmpl col, %edx		#if the colums are equal to the row, don't call set_multiplicand
	jnz set_multiplicand	#resets the multiplicand for next element
	jz set_multiplicand2	#if last column, skips needless previous step
part5:	
	addl $1, row 		#after row operations finish, increase row by one
	cmpl row, %edx		#compares rows to matrix size to determine is should increase columns
	mov $0, %eax		#empty eax
	jl inc_col		#increments columns and sets multiplicand for next column ops
	jge row_op	#else repeat the row ops


#subtracts recursively size -1 to obtain previous sub-element
set_multiplier:
	subl $1, %edx
	subl %edx, %esi	#increments edx slots
	subl %edx, %esi
	subl %edx, %esi
	subl %edx, %esi
	cmpl row, %edx	
	jnz set_multiplier	#alg must stop at diagonals and subtract 1 sub-element at this point
revert_multiplier:
	movl size, %edx
	jmp part4

#subtracts 1 to obtain previous sub-element
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
	
#sets the multiplicand for next row operation at size -1 recursively
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
	jmp part5

#sets multiplicand for next row op but moves 1 slot back
set_multiplicand2:
	subl $1, %edx
	subl $4, %edi
	cmpl $1, %edx
	jnz set_multiplicand2
	jmp revert_multiplicand
	
#increments the columns
inc_col:
	movl $1, row #reset rows to 1
inc_col2:
	addl col, %edi
	addl col, %edi
	addl col, %edi
	addl col, %edi
	addl $1, col 	#add 1 to columns
	cmpl col, %edx
	jl end_mulsym		#if the columns is larger than the dimensions, the program is done
	jge row_op	#if colums is equal or less than the dimensions, repeat the row ops
	
#obtains next subelement in multiplier matrix
add1a:
	addl $-1, %ecx
	addl %ecx, %esi
	addl %ecx, %esi
	addl %ecx, %esi
	addl %ecx, %esi
	addl $1, %ecx
	jmp part2

#obtains next sub-element in multiplicand matrix
add1b:
	addl $-1, %ecx
	addl %ecx, %edi
	addl %ecx, %edi
	addl %ecx, %edi
	addl %ecx, %edi
	addl $1, %ecx
	jmp part3

end_mulsym:
	ret

done:
	movl %eax, %eax #dummy code for debugging

