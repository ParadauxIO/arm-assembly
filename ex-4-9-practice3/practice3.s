  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ while (h >= 13) {
  @ 	h = h - 12;
  @ }

  @ *** your solution goes here ***

  While:
    CMP R0, #13
    BLE EndWhile

    SUB R0, R0, 12
    b While
  EndWhile:

  @ End of program ... check your result

End_Main:
  BX    lr

.end