  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main
  .global  CleanString
  
  .equ NULL, 0                    @ Represents the character which marks the end of a string.
  .equ TRUE, 1                    @ Represents boolean true 
  .equ FALSE, 0                   @ Represents boolean false

  .data
CleanStringSpace:
  .space 256                      @ Extra space to store our sanitised String. 

  .text
Main:

  LDR R0, =TRUE                   @ Palindrome = true
  MOV R2, R1                      @ Copy of the address 
  LDR R12, =0                     @ Length of String
  LDR R11, =CleanStringSpace
  
  @ Creates a copy of the string with only it's alphabetic characters
CleanString: 
  LDRB R4, [R2], #1  

  CMP R4, #NULL                   @ If at the end of the string.
  BEQ EndCleanString

  ORR R4, R4, #0x20               @ Make lowercase

  CMP R4, #97                     @ If Alphabetic
  BLO CleanString

  CMP R4, #122
  BHI CleanString                 @ End If Alphabetic

  STRB R4, [R11], #1              @ Store the alphabetic character in the space in memory allocated above
  ADD R12, R12, #1                @ Increment Clean String Length
  b CleanString
EndCleanString:
  LDR R8, =0
  STRB R8, [R11], #-1             @ Null-terminate our new, clean string.

IfLengthOne:
  CMP R12, #1
  BEQ End_Main
EndIfOne:

  LDR R2, =CleanStringSpace       @ Cursor1
  ADD R3, R2, R12                 
  SUB R3, R3, #1                  @ Cursor2

DetermineIfPalindrome:

IfNotPalindrome:
  CMP R0, #FALSE                  @ If it isn't a palindrome, exit
  BEQ End_Main
EndIfNotPalindrome:

  LDRB R4, [R2], #1               @ Load the next character and go towards the middle of the string.
  LDRB R5, [R3] , #-1             @ Load next character @ cursor2 into memory and go towards the centre.

  
  CMP R4, R5                      @ Compare the characters, If they aren't the same then the string can't be a palindrome.
  BNE NotPalindrome

IfMiddle:
  CMP R2, R3                      @ Checks to see if the cursors are at the middle, or have exceeded the middle of the string.
  BEQ End_Main                    @ Cursor1 = Cursor2
                                  @ ||
  ADD R11, R2, #1                 @ ||
  CMP R11, R3                     @ Cursor1 = Cursor2 + 1
  BEQ End_Main
EndIfMiddle:
  b DetermineIfPalindrome
  
NotPalindrome:
  LDR R0, =FALSE                 @

  @ End of program ... check your result

End_Main:
  BX    lr

