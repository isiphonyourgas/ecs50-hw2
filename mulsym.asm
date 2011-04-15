# Meenal Tambe, Jason Wong, Aaron Okano, Gowtham Vijayaragavan
# assembly language program; multiplies two compressed symmetric matrices.
# saves storage space by storing what is on or above diagonal

# to run: nasm -f elf mulsym.asm
# ld -s -o mulsym mulsym.o
# ./mulsym


# insert wrapper code here
# .data has matrices
section .data

matrix: db "Enter your matrix, with rows separated by colons:",10

; "Matrix is inserted" 10

matrixLen: equ $-matrix; 12
;
	
# set registers
section .text

global _start

_start:

mov eax,4

mov ebx,1

mov ecx,matrix

mov edx,matrixLen

int 80h

mov eax,1

mov ebx,0

int 80h

# call mulsym

# done:

# create function mulsym
# has 4 arguments:
# matrix size, stored in EDX
# address of multiplier matrix, stored in ESI
# address of multiplicand matrix, stored in EDI
# address of product matrix, stored in EBP
