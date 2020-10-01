  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set up a, b, c and d with initial test values
  MOV   R1, #5          @ a=5
  MOV   R2, #6          @ b=6
  MOV   R3, #7          @ c=7
  MOV   R4, #8          @ d=8
  bx    lr

.end