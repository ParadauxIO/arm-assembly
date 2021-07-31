  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main
  
@ This is actually fully functioning Java code. This assignment hurt my 
@ poor brain, so I decided to mock memory using a char array
@ Java class: https://gist.github.com/ParadauxIO/448310c3c0aa69e3c13a073288050d04

@ ------------------------------------------------------------
@ char[] byteArray = "...ThIs Is A TeSt\0".toCharArray();
@ int currentCharCount = 0;
@ int value = 0;
@ int address = 0;
@ int address2 = 0;
@ int strLength = 0;
@ // Gets length of string

@ value = byteArray[address];
@ while(value != 0) {
@     address++;
@     strLength++;
@     value = byteArray[address];
@ }

@ address = address - (strLength);
@ strLength = address + strLength;

@ do {
@     System.out.println(address);
@     value = byteArray[address];
    
@     if (!((value >= 97 && value <= 122) || (value >= 65 && value <= 90) || value == 0 || value == ' ')) {
@         address++;
@         continue;
@     }

@     currentCharCount++;

@     if (value == 0x20 || value == 0x0) {
@         address2 = address - (currentCharCount-1);
@         currentCharCount = 0;

@         value = byteArray[address2];

@         if (value >= 97 && value <= 122) { // lowercase
@             value = value - 0x20;
@             byteArray[address2] = (char) value;
@         }

@         address2++;

@         while (value != 0 && address2 < address) {
@             value = byteArray[address2];

@             if (value >= 65 && value <= 90) { // uppercase
@                 value = value + 0x20;
@                 byteArray[address2] = (char) value;
@             }

@             address2++;
@         }

@         if (address == strLength) {
@             break;
@         }

@     }

@     address++;
@ } while (true);
@ System.out.println(byteArray);


@ ------------------------------------------------------------

@ R0 -> value
@ R1 -> address
@ R2 -> address2
@ R3 -> currentCharCount
@ R4 -> address marking end of string (address + length of string)
@ R5 -> temp register for arithmetic

@ ------------------------------------------------------------
Main:
  LDR R0, =0
  LDR R2, =0
  LDR R3, =0
  LDR R4, =0
  LDR R5, =0

  LDRB R0, [R1]
WhileStrLength: @ Gets the length of the string
  CMP R0, #0
  BEQ EndWhileStrLength
  ADD R4, R4, #1
  ADD R1, R1, #1
  LDRB R0, [R1]
  b WhileStrLength
EndWhileStrLength:

  SUB R1, R1, R4 @ Resets address
  ADD R4, R1, R4 @ Makes strlength now point to the final address

DoForever:
  LDRB R0, [R1]

@ This next block accomodates for test 8 
AlphabeticTestLC: 
  CMP R0, #97
  BLO EndAlphabeticTestLC
  CMP R0, #122
  BGT EndAlphabeticTestLC
  B IfSpaceOrZero
  @ is lowercase
EndAlphabeticTestLC:
  CMP R0, #65
  BLO EndAlphabeticTestUC
  CMP R0, #90
  BGT EndAlphabeticTestUC
  B IfSpaceOrZero
  @ is uppercase
EndAlphabeticTestUC:
  CMP R0, #0x0
  BEQ IfSpaceOrZero
  CMP R0, #' '
  BEQ IfSpaceOrZero
  ADD R1, R1, #1
  b DoForever

IfSpaceOrZero:
  ADD R3, R3, #1 @ charCount++

  CMP R0, #' '
  BEQ IsSpaceOrZero
  CMP R0, #0x0 
  BEQ IsSpaceOrZero
  b EndIfSpaceOrZero
IsSpaceOrZero:
  SUB R5, R3, #1 @ (currentCharCount-1)
  SUB R2, R1, R5 @ address - (currentCharCount-1)
  LDR R3, =0
  LDRB R0, [R2]

IfLowercase:
  CMP R0, #97
  BLO EndIfLowerCase
  CMP R0, #122
  BGT EndIfLowerCase
  SUB R0, R0, #0x20
  STRB R0, [R2]
EndIfLowerCase:
  ADD R2, R2, #1

// value != 0 && address2 < address
WhileNotZeroAndAdr2LTAdr1: 
  CMP R0, 0x0
  BEQ EndWhileNotZeroAndAdr2LTAdr1
  CMP R2, R1
  BHS EndWhileNotZeroAndAdr2LTAdr1

  LDRB R0, [R2]

IfUppercase: 
  CMP R0, #65
  BLO EndIfUppercase
  CMP R0, #90
  BGT EndIfUppercase
  ADD R0, R0, #0x20
  STRB R0, [R2]
EndIfUppercase:
  ADD R2, R2, #1
  b WhileNotZeroAndAdr2LTAdr1
EndWhileNotZeroAndAdr2LTAdr1:
  CMP R1, R4
  BEQ End_Main
  @ no code below here
EndIfSpaceOrZero:
  ADD R1, R1, #1
  b DoForever
End_Main:
  BX    lr

