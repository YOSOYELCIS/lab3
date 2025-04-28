#Cis Garcia and Jacob Lee
.text
main:
	la a0, welcome
	li a7, 4
	ecall
	
while: 
	lb t0, user	#going to check if the user pressed n instead of y
	li t1, 'n'
	beq t0, t1, exit
				
	li a0, 10	# Force a clean newline before showing "Please enter a number"
	li a7, 11
	ecall
	
	la a0, enter 	#print the enter statement
	li a7, 4
	ecall
	
	#la a0, input 	#scanning for user's integer input and puts it in the input variable
	li a7, 5
	ecall
	
	mv t2, a0	#this is essentially the load of input
	li t4, 0	#load the counter variable

		
inner_while:
	beqz t2, print	#will jump to print when the tempNum equals 0, if not then it'll repeat this loop
	andi t3, t2, 1	#the AND label for the if statement
	beqz t3, end_if
	addi t4, t4, 1 #adds the counter value
	
end_if:
	srli t2, t2, 1 	#arithmetic shift for unsigned values
	b inner_while

print:

	la a0, bitcount
	li a7, 4
	ecall
	
	mv a0, t4
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
	la a0, exiting 
	li a7, 4 
	ecall
	
	li a7, 10
	ecall

.data
input: .word 0
user: .byte 'y'
welcome: .string "Welcome to the CountOnes Program.\n"
enter: .string "\nPlease enter a number: "
bitcount: .string "The number of bits set is: "
continue: .string "\nContinue (y/n)?: "
exiting: .string "\nExiting"
