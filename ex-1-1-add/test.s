  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set up a, b, c and d with initial test values
  MOV   R1, #6          @ a=6
  MOV   R2, #6          @ b=6
  MOV   R3, #6          @ c=6
  MOV   R4, #6          @ d=6
  bx    lr

.end