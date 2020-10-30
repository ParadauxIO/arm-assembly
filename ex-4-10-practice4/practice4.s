  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ if (ch >= 'A' && ch <= 'Z') {
  @ 	ch = ch + 0x20;
  @ }

  @ *** your solution goes here ***

  @ CH = R0
  CMP R0, #'A'
  BLO End_Main
  CMP R0, #'Z'
  BHI End_Main
  ADD R0, R0, #0x20

  @ End of program ... check your result

End_Main:
  BX    lr

.end