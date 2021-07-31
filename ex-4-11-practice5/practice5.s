  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  R1 = e
  if (ch=='a' || ch=='e' || ch=='i' || ch=='o' || ch=='u')
  {
  	v = 1;
  }
  else {
  	v = 0;
  }

  @ *** your solution goes here ***

  CMP R1, #'a'
  BEQ Then
  CMP R1, #'e'
  BEQ Then
  CMP R1, #'i'
  BEQ Then
  CMP R1, #'o'
  BEQ Then
  CMP R1, #'u'
  BEQ Then

  MOV R0, #0
  b End_Main

  Then:
    MOV R0, 1
  @ End of program ... check your result

End_Main:
  BX    lr

.end