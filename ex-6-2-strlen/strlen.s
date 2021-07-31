  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @ Address is in R1
  @ R2 is our current character
  @ R0 is our iterator 

  LDR R0, =0
  LDR R3, =0

  While:
    LDRB R2, [R1]

    CMP R2, #0x0
    BEQ End_Main

    ADD R0, R0, #1
    ADD R1, R1, #1

    b While
  @ End of program ... check your result

End_Main:
  BX    lr

