  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

SomeSpace:
  .space 256

SomeLabel: 
  LDR R1, =SomeSpace
 
End_Main:
  BX    lr

.end