  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will compute
  @   the GCD (greatest common divisor) of two numbers in R2 and R3.
  
  @ *** your solution goes here ***

  @ Javascript-like pseudocode
  @ let result = 0;
  @ while (a != b) {
  @   if (a > b) {
  @     a = a - b;   
  @   } else {
  @     b = b - a
  @   }
  @ }
  @ result = a;

  While: 
  CMP R2, R3
  BEQ EndWhile
  
  CMP R2, R3
  BLO Else 
    SUB R2, R2, R3
    b EndIf
  Else:
    SUb R3, R3, R2 
  EndIf:
  
  b While
  EndWhile:
  MOV R0, R2

  @ End of program ... check your result

End_Main:
  BX    lr

.end
