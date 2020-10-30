  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ A Prgoram to evaluate x^3 - 4x^2 + 3x + 8, storing the answer in R0. X is in R1
  @ R2 has to be used as a temporary register to permit multiplication and the storing of multiple arguments.
  @ Rían Errity - 17/10/2020

  @ X^3
  MUL R2, R1, R1 @ X^2
  MUL R0, R2, R1 @ X^3

  @ 4x^2
  LDR R3, =4
  MUL R2, R2, R3 @ We already have X^2 in R2 from Instruction 1, so we just need to multiply it by 4, in R3

  @ X^3 - 4x^2
  SUB R0, R0, R2
  
  @ 3x
  LDR R2, =3
  MUL R2, R1, R2 

  @ 3x + 8 
  ADD R2, R2, #8 @ 3x+8
  
  @ FINAL: x^3 - 4x^2 + 3x + 8
  ADD R0, R0, R2

  @ End of program ... check your result

End_Main:
  BX    lr

  .end