  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Compute absolute value of value in R1

  @ *** your solution goes here ***

  @ End of program ... check your result

  MOV R0, R1
  CMP R0, #0
  BGE EndIfNeg
  RSB R0, R0, #
  EndIfNeg:

End_Main:
  BX    lr

.end