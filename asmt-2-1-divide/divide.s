  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will divide a
  @   value, a, in R2 by another value, b, in R3.
  
  @ *** your solution goes here ***
  @ Rían Errity 20333410 28/10
  
  @ We can't assume it's already zero
  LDR R0, =0  @ This will store the quotient
  MOV R1, R2  @ This will store the modulus
  
  @ R0 = R2 / R3
  @ R4 = Modulus (the remainder)

  @ If R2 == R3, R0 = 1, R1 = 0

  @ while ( R1 >= R3) {
  @     R0 = R0 + 1
  @     R1 = R1 - R3
  @ }

  IfEqual:
  CMP R2, R3
  BNE While
  MOV R0, #1
  MOV R1, #0
  b End_Main

  IfZero:
  CMP R3, #0 
  BEQ End_Main @ Can't divide by zero

  While: 
  CMP R1, R3   @ Expression arguments
  BLE End_Main @ Opposite condition as to what we compare in pseudocode (>= -> <=)

      ADD R0, R0, #1 
      SUB R1, R1, R3

  B While @ Jumps back up to the beginning of the loop

  @ End of program ... check your result

End_Main:
  BX    lr

.end
