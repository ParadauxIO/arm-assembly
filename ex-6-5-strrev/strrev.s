  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

LDR R3, =0

WhileStrLength:
  LDRB R2, [R1]

  CMP R2, #0x0
  BEQ EndWhile

  ADD R1, R1, #1
  ADD R3, R3, #1

  b WhileStrLength
EndWhile:

Move:
  SUB R1, R1, #1

  LDRB R2, [R1]

  CMP R2, 0x0
  BEQ EndMove

  STRB R2, [R0]
  
  ADD R0, R0, #1

  b Move
EndMove:

LDR R2, =0x0
STRB R2, [R0]
  @ End of program ... check your result

End_Main:
  BX    lr

