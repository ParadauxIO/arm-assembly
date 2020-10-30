  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ if (a < b)
  @ {
  @   r = a;
  @ }
  @ else {
  @   r = b;
  @ }  

  @ *** your solution goes here ***

  StartIf:
    CMP R1, R2
    BHS Else
    MOV R0, R1
    B End_Main
  Else:
    MOV R0, R2


  @ End of program ... check your result

End_Main:
  BX    lr

.end