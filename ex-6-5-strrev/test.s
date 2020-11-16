  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global strA
  .global strB

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set R1 to the start address of the test string
  LDR   R0, =strB
  LDR   R1, =strA
  BX    LR


  .section  .rodata

strA:
  .asciz  "Do not test with a palindrome"


  .section  .data

strB:
  .space  256


.end