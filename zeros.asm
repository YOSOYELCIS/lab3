.text
main:
	la a0, welcome
	li a7, 4
	ecall
	
while: 
	lb t0, user	#going to check if the user pressed n instead of y
	li t1, 'n'
	beq t0, t1, exit
	
	la a0, enter 	#print the enter statement
	li a7, 4
	ecall
	
	#la a0, input 	#scanning for user's integer input and puts it in the input variable
	li a7, 5
	ecall
	
	mv t2, a0	#this is essentially the load of input
	li t3, 0	#load the counter variable
	li t4, 0x80000000	#mask variable
	
	bnez t2, else	#if num == 0
	addi t3, t3, 32	#if it satisfies, then it is 32 bits for the counter variable
	b print
	
else:
	bleu t4, zero, print
	and t5, t2, t4 #saving the AND value from the input and mask

if: 
	bnez t5, end_if	#if num & mask == 0
	addi t3, t3, 1	#adds the counter value
	
end_if:
	srli t4, t4, 1	#right shift the mask by 1
	b else			#it branches through the else again since it's a while loop in itself

print:

	la a0, zerocount
	li a7, 4
	ecall
	
	mv a0, t3
	li a7, 1
	ecall
	
	la a0, continue
	li a7, 4
	ecall

	li a7, 12	#scanning the user's choice for continuing the while loop or not
	ecall
	sb a0, user, t0
	
	b while
	
exit: 
	la a0, exiting 	#exit function
	li a7, 4 
	ecall
	
	li a7, 10
	ecall

.data
input: .word 0
user: .byte 'y'
welcome: .string "Welcome to the Zeros Program\n"
enter: .string "\nPlease enter a number: "
zerocount: .string "The number of leading zeros is: \n"
continue: .string "\nContinue (y/n)?: "
exiting: .string "\nExiting"