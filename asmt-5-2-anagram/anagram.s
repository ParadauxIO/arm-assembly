  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ Based on the "check off" / "mark off" algorithm 
  @ Whereby you iterate over each letter in one string, then iterate over the second inside of that.
  @ When/if you find the letter in String B in String A, mark it as "found" then move onto the next letter
  @ if everything has been marked off, then it's an anagram! 

  @ Initialise Registers
  LDR R0, =0
  LDR R3, =0
  LDR R8, =0 @ Length of A
  LDR R9, =0 @ Length of B
  LDR R12, ='/' @ used to mark a letter as found.

  @ R0 = result
  @ R1 = String A
  @ R2 = String B
  @ R3 = letterFound boolean
  @ R4 = destructible address A
  @ R5 = destructible adress B
  @ R6 = LDR/STR TMP
  @ R7 = LDR/STR TMP
  @ R8 = Length of String A
  @ R9 = Length of String B
  @ R12 = '/' constant to "mark off" 

  @ get length of b

  MOV R5, R2 

  @ Get The Length of B
FindLengthOfB: 
  LDRB R6, [R5]

  CMP R6, #0x0
  BEQ EndFindLengthOfB

  ADD R9, R9, #1
  ADD R5, R5, #1

  b FindLengthOfB
EndFindLengthOfB:

  @ For every letter in String A
  MOV R4, R1
ForAllInStringA:
  LDRB R6, [R4], #1
  BIC R6, R6, #0x20 @ Make it uppercase

  CMP R6, #0x0
  BEQ EndForAllInStringA

  LDR R3, =0 @ found flag

  MOV R5, R2
  @ For every letter in String B
ForAllInStringB:
  LDRB R7, [R5]
  BIC R7, R7, #0x20 @ Make it uppercase

  CMP R7, #0x0
  BEQ EndForAllInStringB

IfInString:
  CMP R6, R7 
  BNE NotInString

  STRB R12, [R5]
  LDR R3, =1
  b EndForAllInStringB
NotInString:

  ADD R5, R5, #1
  b ForAllInStringB
EndForAllInStringB:

IfNotFound:
  @ already increased
  ADD R8, R8, #1 @ Increase length of A
  b ForAllInStringA
EndForAllInStringA:

  CMP R8, R9
  BNE NotTheSameLength
  MOV R0, R3

  LDR R10, =0
  LDR R11, =0
  MOV R5, R2
  @ This makes sure double-letter non-anagrams are marked as such.
CheckIfAllHaveBeenMarked:
  CMP R10, R8
  BEQ EndCheckIfAllHaveBeenMarked

  LDRB R6, [R2], #1
IfCheckedOff:
  CMP R6, #'/'
  BNE EndIfCheckedOff
  ADD R11, R11, #1
EndIfCheckedOff:
  ADD R10, R10, #1
  
  b CheckIfAllHaveBeenMarked
EndCheckIfAllHaveBeenMarked:

AllCheckedOff:
  CMP R11, R10
  BEQ End_Main
  LDR R0, =0
NotTheSameLength:

  @ End of program ... check your result

End_Main:
  BX    lr

