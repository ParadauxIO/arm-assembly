  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @
  @ Write an ARM Assembly Language Program that will determine
  @   whether the unsigned number in R1 is a prime number
  @
  @ Output:
  @   R0: 1 if the number in R1 is prime
  @       0 if the number in R1 is not prime
  @
  @ *** your solution goes here ***
  
  LDR R0, =0 @ Assume false (Binary boolean result)

  @ if (number <= 1)
  CMP R1, #1         @ Number, 1
  BLT End_Main       @ <= (signed) 
  @ Numbers 1 and below are not considered prime. This includes negative numbers.

  LDR R2, =2 @ Used for division / multiplication to find remainder using MLS (Multiply and subtract)
  LDR R3, =2 @ Iterator for the for loop
  UDIV R4, R1, R2 @ Half of R1, so we know when to stop the for loop
  

  @ For (int i=2; i <= inputNumber/2; i++)
For: 
  @ Compare R3 to half of the input number. 
  @ If there isn't a divisor half way through, there definitely won't be one over half of its value
  CMP R3, R4 
  BHI EndFor

  @ R1 / R5. Checks to see if the iterator is a divisor, used to calculate the remainder.
  UDIV R5, R1, R3

  @ R6 = R1 - (R5 * R3) (Multiply and subtract: calculates the remainder.)
  MLS R6, R5, R3, R1

  @ if the remainder is zero, it has a divisor and thus, isn't prime.
  CMP R6, #0
  BEQ End_Main 

  @ I++;
  ADD R3, R3, #1
  B For
EndFor:

  @ The result must be true, because no divisors were found up to half the value of the input number.
  LDR R0, =1

  @ End of program ... check your result

End_Main:
  BX    lr

.end
