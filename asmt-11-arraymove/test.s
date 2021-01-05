  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global initArray
  .global array

  .section  .text

  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {R4-R7}

  @ Copy initial RAM contents from ROM
  LDR   R4, =initStart
  LDR   R5, =initEnd
  LDR   R6, =dataStart

whInit:
  CMP   R4, R5
  BHS   ewhInit
  LDR   R7, [R4], #4
  STR   R7, [R6], #4
  B     whInit
ewhInit:

  LDMFD SP!, {R4-R7}
  BX    LR


  .section  .rodata

initStart:
initArray:
  .word   3, 6, 1, 9, 0, 7, 2, 8, 6, 4
  .equ   sizeArray, .-initArray
initEnd:


  .section  .data
dataStart:
array:
  .space  sizeArray

.end