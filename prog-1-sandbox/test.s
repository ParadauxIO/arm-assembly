  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Initialise registers with your test vlues here

  @ 4x^2+5x+6

  LDR R1, =7

  LDR R2, =4
  LDR R3, =5
  LDR R4, =6

  @ Do not edit below this line
  bx    lr

.end

@ Hello Elliot!
