  .syntax unified
  .cpu cortex-m4
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Test with 17
  @ LDR   R1, =17

  @ Test with 8
  LDR R1, =-97

  bx    lr

.end