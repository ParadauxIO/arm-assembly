  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Compute x^y where x is in R1 and y is in R2

  MOV     R0, #1          @ result = 1
While:
  CMP     R2, #0          @ Assuming R2 is equal to 0
  BEQ     EndWh           @ If that's the case, go to the lebel EndWh:
  MUL     R0, R0, R1      @ Multiply the result by x 
  SUB     R2, R2, #1      @ Decrement the iterator value (y)
  B       While           @ Go back to the start of the while loop
EndWh:

  @ End of program ... check your result

End_Main:
  BX    lr

.end