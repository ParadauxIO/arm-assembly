  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @ First, set up to test with x=5
  MOV   R1, #4
  
  @ Write a program to compute 4x^2+3x
  MUL   R0, R1, R1      @ result = x * x
  LDR   R2, =4          @ tmp = 4
  MUL   R0, R2, R0      @ result = 4 * x * x

  LDR   R2, =3          @ tmp = 3
  MUL   R2, R1, R2      @ tmp = x * tmp

  ADD   R0, R0, R2      @ result = result + tmp

  @ Check your result

  BX    lr
.size Main, .-Main