  .syntax unified
  .cpu cortex-m4
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Test with n=6 (F_6)
  MOV   R1, #20
  bx    lr

.end