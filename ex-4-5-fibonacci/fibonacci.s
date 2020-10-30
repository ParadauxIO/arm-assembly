  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Calculate Fibonacci number Fn, where n is stored in R1
  @ Store the result in R0

  @ *** your solution goes here ***

  LDR R0, =0 @ the sequence starts at zero
  LDR R2, =1 @ We can't be adding zero to itself for the entire loop

  While:    
  CMP R1, #1
  BMI EndWh

  SUB R1, R1, #1 @ Decrement iterator

  ADD R0, R2, R3 @ Result = R2 + R3
  MOV R2, R3     @ R2 = R3
  MOV R3, R0     @ R3 = R2 

  B While

  EndWh: 


  @ End of program ... check your result

End_Main:
  BX    lr

.end