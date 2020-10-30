  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ if (v < 10) {
  @ 	a = 1;
  @ }
  @ else if (v < 100) {
  @ 	a = 10;
  @ }
  @ else if (v < 1000) {
  @ 	a = 100;
  @ }
  @ else {
  @ 	a = 0;
  @ }  

  @ *** your solution goes here ***
  @ V = R1

  IfPt1:@ v < 10
    CMP R1, #10
    BHS IfPt2

    MOV R0, #1
    b End_Main
  IfPt2:@ v < 100
    CMP R1, #100
    BHS IfPt3

    MOV R0, #10
    b End_Main
  IfPt3:@v < 1000
    CMP R1, #1000
    BHS Else

    MOV R0, #100
    b End_Main
  Else: 
    MOV R0, #0




  @ End of program ... check your result

End_Main:
  BX    lr

.end