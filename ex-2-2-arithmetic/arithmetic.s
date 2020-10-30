  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Evaluate 4x^2 + 3x, X = R1 

  LDR R2, =4
  
  MUL R0, R1, R1
  MUL R0, R0, R2  

  LDR R2, =3     
  MUL R2, R1, R2  
  
  ADD R0, R0, R2  

  @ End of program ... check your result

End_Main:
    BX    lr
