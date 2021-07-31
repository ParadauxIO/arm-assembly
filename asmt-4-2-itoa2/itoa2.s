  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @ Java-like pseudocode without type declarations. 
  @ TEN = 10;
  @ input = 3547;
  @ digit = 0;
  @ strlength = 0;

  @ powerOf10 = 1000000000;

  @ if (input == 0) {
  @     digit = '0';
  @     word[address] = digit;
  @     address++;
  @     goto nullTerminate;
  @ } else if (input > 0) {
  @     digit = '+';
  @ } else {
  @     digit = '-';
  @     input = Math.abs(input);                        // the sign has already been catered for
  @ }

  @ word[address] = digit;
  @ address++;

  @ while(input < powerOf10) {
  @     powerOf10 /= TEN;
  @     strlength++;
  @ }

  @ strlength = 10 - strlength;                       // Actually get the string length as we perform the divide operaiton in reverse.

  @ while (strlength > 0 ) {
  @     digit = (int) input / powerOf10;              // Truncate by casting (i.e whole number part)
  @     input = (input - (digit * powerOf10));        // Get the remainder

  @     digit += 0x30;                                // converts from integer to char
  @     word[address] = digit;
  @     address++;
  @ }

  @                                                   // Null Terminate (goto nullTerminate would go here.)
  @ word[address] = 0x0;

  @ Sign
  LDR R2, =10                 @ Constant
  LDR R3, =1000000000
  LDR R5, =0                  @ Length the string will be 

SetSign:
  CMP R1, #0
  BNE NotZero
ZeroCase:
  LDR R4, ='0'
  STRB R4, [R0]
  ADD R0, R0, #1
  b EndWhile

NotZero:
  CMP R1, #0                  @ If it's greater than or equal to zero it's positive.
  BLT NegativeCase
PositiveCase:
  LDR R4, ='+'
  B EndSetSign

NegativeCase:
  LDR R4, ='-'
  NEG R1, R1                  @ The Sign has already been catered for, so we can negate the value.

EndSetSign:
  STRB R4, [R0]               @ Store the sign in the first place in memory.
  ADD R0, R0, #1

GetLargestPower10: 
  CMP R1, R3                  @ I did this in the reverse order as suggested so I wouldn't have to revert my string.
  BHS EndLargestPower10       @ Registers can only store 32-bit values and my constant powerOf10 is the highest possible.

  UDIV R3, R3, R2             @ Get 10^(n-1)
  ADD R5, R5, #1
  B GetLargestPower10

EndLargestPower10:

  SUB R5, R2, R5              @ Actually get the string length as we perform the divide operaiton in reverse.

While:
  CMP R5, #0               
  BLS EndWhile

  UDIV R4, R1, R3             @ Get the digit itself 
  MLS R1, R4, R3, R1          @ Get the remainder (i.e if the number is 3567 get 567)

  ADD R4, #0x30               @ Convert the digit to a char and put it into memory
  STRB R4, [R0]  

  ADD R0, R0, #1            
  UDIV R3, R3, R2             @ Get 10^(n-1)

  SUB R5, R5, #1
  B While
EndWhile:
  LDR R4, =0x0                @ Null terminate my String.
  STRB R4, [R0]

  @ End of program ... check your result

End_Main:
  BX    lr

