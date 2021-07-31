  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Arm Program which converts an integer into an ascii string, prefixing the absolute value of the integer with + or - depending on the sign, or a space if it's zero.

  @ Case 1 (Out of bounds)
  @ R3 = -100 || R3 = 100
  @ R1 = 'N', R2 = '/'', R3 = 'A'

  @ Case 2 (Positive)
  @ R3 = 50
  @ R1 = '+', R2 = '5', R3 = '0'

  @ Case 3 (Negative)
  @ R3 = -50
  @ R1 = '-', R2 = '5', R3 = '0'

  @ Case 4 (Zero)
  @ R3 = 0
  @ R1 = 0x20, R2 = '0', R3 = '0'

  @ R0 = Sign, R1 = Tens, R2 = Units, R3 = Input, R4 = 10 (constant)
  
  LDR R4, =10                  @ Used to divide by 10 later on.

  CMP R3, #99                  @ Check if greater than 99
  BGT InputOutOfRange

  CMN R3, #99                  @ Check if less than -99 (CM N where N means negative (a - (-b)))
  BLT InputOutOfRange

  PositiveCheck:
  CMP R3, #0                  @ If it's greater than or equal to zero it's positive.
  BGE IsPositive

  LDR R0, ='-'                @ Sets the sign to '-' as it failed the positive check.
  SDIV R1, R3, R4             @ Divides the input number by 10, puts the whole number in R1, and the remainder in R2 (SIGNED)
  MLS R2, R1, R4, R3          @ Remainder = (input - (quotient * divisor))

  NEG R1, R1                  @ Convert the negative results back into positive numbers, as their sign is accounted for in R1
  NEG R2, R2

  b ConvertToAscii            
  
  IsPositive:

  TST R3, R3                  @ Same as ANDS but disregards result. Simple/Efficient is Zero check
  BNE NotZero
  LDR R0, =0x20               @ Space (0x20)
  b SeperateNumbers

  NotZero:
  LDR R0, ='+' 

  SeperateNumbers:
  UDIV R1, R3, R4             @ Divides the input number by 10, puts the whole number in R1, and the remainder in R2 (UNSIGNED)
  MLS R2, R1, R4, R3          @ Remainder = (input - (quotient * divisor))

  ConvertToAscii:
  ADD R1, R1, #0x30           @ Integers are displaced by their char equivlants by 0x30 (48) places
  ADD R2, R2, #0x30

  b End_Main                  @ We're done here, we don't want to override our calculation with N/A

  InputOutOfRange:
  LDR R0, ='N' @ 0x4E         @ Return "N/A" if provided integer is out of range.
  LDR R1, ='/' @ 0x2F
  LDR R2, ='A' @ 0x41
  @ End of program ... check your result

End_Main:
  BX    lr

.end
