  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

While:
  LDRB R2, [R1]

  CMP R2, #0x0
  BEQ EndWhile

  STRB R2, [R0]

  ADD R1, R1, #1
  ADD R0, R0, #1
  b While
  @ End of prog
EndWhile:

  LDR R2, =0x0
  STRB R2, [R0]

  @ End of program ... check your result

End_Main:
  BX    lr

