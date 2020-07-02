  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  MOV R0, #0

Loop:
  LDR R2, [R1]
  CMP R2, #0
  BEQ ELoop
  ADD R0, R0, #1
  ADD R1, R1, #1
  B   Loop
ELoop:

  @ End of program ... check your result

End_Main:
  BX    lr

