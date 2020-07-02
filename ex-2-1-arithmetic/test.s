  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Test with x=5
  MOV   R1, #5
  bx    lr

.end