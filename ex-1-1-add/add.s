  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @ First, set up a, b, c and d with some test values
  MOV   R1, #6          @ a=6
  MOV   R2, #7          @ b=7
  MOV   R3, #8          @ c=8
  MOV   R4, #9          @ d=9
  
  @ Write a program to compute total=a+b+c+d
  MOV   R0, R1          @ total=a
  ADD   R0, R0, R2      @ total=total+b
  ADD   R0, R0, R3      @ total=total+c
  ADD   R0, R0, R4      @ total=total+d

  @ End of program ... check your result

End_Main:
  BX    lr
.size Main, .-Main