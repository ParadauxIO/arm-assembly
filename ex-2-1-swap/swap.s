  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Given two registers, R0 and R1, swap their contents. 
  @ Option 1: Using a temporary (TMP) register (R2)
  @ TMP = X
  @ X = Y 
  @ Y = TMP

  MOV R2, R0
  MOV R0, R1
  MOV R1, R2

  @ Option 2: Using the XOR Swap Algorithm
  @ Source "Bit Twiddling Hacks": http://graphics.stanford.edu/~seander/bithacks.html#SwappingValuesXOR
  @ Commenting out for the purposes of Submitty

  @ EOR R0, R1, R2 
  @ EOR R1, R1, R2
  @ EOR R1, R1, R2 (Untested, but should work, classic!)

End_Main:
  BX    lr

.end
