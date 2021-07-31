  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Convert the character in R0 to upper case

  @ *** your solution goes here ***

  @ if (r0 <= 65 && r0 >= 90) {
  @ UPPERCASE
  @ } else if (r0 <= 97 && r0 >= 122) {
  @ LOWERCASE
  @ SUB R0, R0, 0x20
  @ } else {
  @ NOT A LETTER
  @ }

  @ A = 65 Z = 90, a = 97 Z = 122
  @ Input = R0

  IfAlreadyUpperCase: 
    CMP R0, #65
    BGE NotUpperCase
    CMP R0, #90
    BLE NotUpperCase
    b End_Main
 
  NotUpperCase:

  IfLowerCase:
    CMP R0, #97
    BLE NotALetter
    CMP R0, #122
    BGE NotALetter
    SUB R0, R0, #0x20
    b End_Main
  NotALetter:

  @ End of program ... check your result

End_Main:
  BX    lr

.end