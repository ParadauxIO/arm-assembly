  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will divide a
  @   value, a, in R2 by another value, b, in R3.
  
  @ *** your solution goes here ***
  @ Rían Errity 20333410 28/10
    
  @ R0 = R2 / R3
  @ R4 = Modulus (the remainder)

  @ If R2 == R3, R0 = 1, R1 = 0

  @ while ( R1 > R3) {
  @     R0 = R0 + 1
  @     R1 = R1 - R3
  @ }

  @ We can't assume it's already zero
  LDR R0, =0  @ This will store the quotient
  MOV R1, R2  @ This will store the modulus

  IfEqual:
  CMP R2, R3
  BNE IfZero

  MOV R0, #1
  MOV R1, #0
  b End_Main

  IfZero:
  CMP R3, #0 
  BEQ DivisionNotPossible @ Can't divide by zero

  ValidDivisionPossible:

    While:
    CMP R1, R3  
    BLO End_Main
      ADD R0, R0, #1
      SUB R1, R1, R3
    b While  

  DivisionNotPossible:

End_Main:
  BX    lr

.end
