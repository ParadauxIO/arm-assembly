  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set up a, b, c and d with some test values
  MOV   R1, #2          @ a=6
  MOV   R2, #3          @ b=7
  MOV   R3, #4          @ c=8
  MOV   R4, #5          @ d=9
  bx    lr

.end