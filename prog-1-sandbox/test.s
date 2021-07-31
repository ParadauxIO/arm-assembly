  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Initialise registers with your test vlues here

  @ 4x^2+5x+6

  LDR R3, =30

  @ Do not edit below this line
  bx    lr



@ Hello Elliot!
