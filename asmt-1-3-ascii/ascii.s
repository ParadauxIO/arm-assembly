  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will convert
  @    a sequence of four ASCII characters, each representing a
  @    decimal digit, into tje to the value represented by the
  @    sequence.
  
  @ e.g. '2', '0', '3', '4' (or 0x32, 0x30, 0x33, 0x34) to 2034 (0x7F2)

  @ *** your solution goes here ***

  SUB R5, R4, #0x30
  LDR R0, =1000
  MUL R0, R5, R0 @ Thousands

  SUB R5, R3, #0x30 
  LDR R6, =100
  MUL R5, R6, R5 @ Hundreds

  ADD R0, R0, R5

  SUB R5, R2, #0x30
  LDR R6, =10 
  MUL R5, R6, R5 @ Tens

  ADD R0, R0, R5

  SUB R5, R1, #0x30 @ Units
  ADD R0, R0, R5 



  @ End of program ... check your result

End_Main:
  BX    lr

.end
 