  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ Design and write an ARM Assembly Language program 
  @ that will compute the mode of a sequenceof word-size values 
  @ stored in memory.  (The mode is the value that appears most often.)
  @ 
  @ For example, given the values [5, 3, 7, 5, 3, 5, 1, 9], the mode would be
  @ 5. The  sequence  of  word-size  values  begins  at  the  address  in  R1.
  @    The  number  of  values  in  thesequence is stored in R2.  Store your 
  @    result in R0

  @ modeCount is the number of occurences
  @ mode is the mode itself

  @ R0 -> Mode (mode)
  @ R1 -> Address of Word-Sized values (address1)
  @ R2 -> Number of values in the sequence (N)
  @ R3 -> Number of occurences of the mode (modeCount)
  @ R4 -> Outer Iterator 
  @ R5 -> Value 1
  @ R6 -> Value 2
  @ R7 -> Address 2
  @ R8 -> Inner Iterator
  @ R9 -> count

  LDR R0, =0            @ mode = 0
  LDR R3, =0            @ modeocunt = 0
  LDR R4, =0            @ i1 = 0;


OuterWhile:
  CMP R4, R2            @ OuterIterator < N
  BHI EndOuterWhile     
  
  LDR R5, [R1]          @ value1 = word[address]
  ADD R7, R1, #4        @ address2 = address1 + 4
  ADD R8, R4, #1        @ InnerIterator = OuterIterator+1
  LDR R9, =0            @ Count = 0

InnerWhile: 
  CMP R8, R2            @ InnerIterator < N
  BHI EndInnerWhile

  LDR R6, [R7]          @ value2 = word[address2]

InnerIf:
  CMP R5, R6            @ value1 == value2
  BNE EndInnerIf
  ADD R9, R9, #1        @ count += 1
EndInnerIf:

  ADD R8, R8, #1        @ InnerIterator += 1
  ADD R7, R7, #4        @ Address2 += 4

  b InnerWhile

EndInnerWhile:

OuterIf:
  CMP R9, R3              @ count > modeCount
  BLO EndOuterIf        
  MOV R0, R5            @ mode = value1
  MOV R3, R9            @ modeCount = count
EndOuterIf:

  ADD R4, R4, #1        @ outeriterator += 1
  ADD R1, R1, #4        @ address1 += 4

  b OuterWhile
EndOuterWhile:
  @ End of program ... check your result

End_Main:
  BX    lr

