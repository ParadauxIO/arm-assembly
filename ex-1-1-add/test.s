  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set up a, b, c and d with initial test values
  MOV   R1, #2          @ a=2
  MOV   R2, #3          @ b=3
  MOV   R3, #4          @ c=4
  MOV   R4, #5          @ d=5
  bx    lr

.end