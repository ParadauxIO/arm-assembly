  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set up a, b, c and d with initial test values
  MOV   R1, #3          @ a=3
  MOV   R2, #4          @ b=4
  MOV   R3, #5          @ c=5
  MOV   R4, #6          @ d=6
  bx    lr

.end