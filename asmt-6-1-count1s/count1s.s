  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main
  .EQU NotSet, 0
Main:

@ inputNumber = 0b10000111111001001011010001000011
@ count = 0;

@ while (inputNumber != 0) {
@   temp = inputNumber << 1;
@   inputNumber = inputNumber & temp; // (inputNumber & (inputNumber << 1))
@   count++;
@ }

  LDR R0, =0 @ Count
  @ R1 is the binary input

WhileNotSet: 
  CMP R1, #NotSet
  BEQ EndWhileNotSet
  
  MOV R2, R1, LSL #1
  AND R1, R1, R2

  ADD R0, R0, #1
  b WhileNotSet
EndWhileNotSet:


  @ End of program ... check your result

End_Main:
  BX    lr

.end
