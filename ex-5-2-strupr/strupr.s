  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  MOV R0, #0

Loop:
  LDRB  R2, [R1]
  CMP   R2, #0
  BEQ   ELoop
  CMP   R2, #'a'
  BLO   EIfLwr
  CMP   R2, #'z'
  BHI   EIfLwr
  SUB   R2, R2, #0x20
  STRB  R2, [R1]
EIfLwr:
  ADD   R1, R1, #1
  B     Loop
ELoop:

  @ End of program ... check your result

End_Main:
  BX    lr

