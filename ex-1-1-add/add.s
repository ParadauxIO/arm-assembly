  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Submitting as provided by the repository 
  @ Let W = R1, X = R2, Y = R3, Z = R4 providing our final result as R0 


  MOV R0, R1          @ result == W
  ADD R0, R0, R2      @ result += X
  ADD R0, R0, R3      @ result += Y
  ADD R0, R0, R4      @ result += Z

End_Main:
  BX    lr

  .end