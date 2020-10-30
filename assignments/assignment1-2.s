  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

    @ A Program to Evaluate ax^2 + bx + c, storing the result in R0
    @ Where: A = R2, B = R3, C = R4 and X = R2.
    @ R5 is a temporary register used for the purposes of storing multiple arguments. 

    @ Write  an  ARM  Assembly  Langauge  program  to  evaluate ax^2+bx+c,  storing  the  result  in  R0.
    @ Assume x is a value stored in register R1 and a, b and c are values stored in registers R2, R3 and R4 respectively

    @ ax^2

    MUL R0, R1, R1 @ x^2
    MUL R0, R0, R2 @ ax^2

    @ bx
    MUL R5, R3, R1 

    @ ax^2 + bx
    ADD R0, R0, R5

    @ ax^2 + bx + c
    ADD R0, R0, R4 

End_Main:
  BX    lr

  .end