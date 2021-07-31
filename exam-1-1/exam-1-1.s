  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main


  
  @ I only used this second submission to add comments.

  @ JAVA PSEUDOCODE -> Fully works! 

  @ // My approach for this was heavily influenced by the union assignment
  @ // No external resources necessary

  @ int[] setA = {4, 10, 12, -14, 16};
  @ int[] setB = {4, 8, 12, 18, 16};
  @ int[] setC = new int[64];

  @ int nextAddressInC = 1;

  @ // for every element in setA
  @ for (int k = 0; k <= setA[0]; k++) {

  @   int found = 0;

  @   // for every element in setB
  @   for (int l = 0; l <= setB[0]; l++) {
  @       if (setA[k] == setB[l]) {
  @           // found
  @           found = 1;
  @           break;
  @       }
  @   }

  @   // if this element was not in the other set, add it to the third.
  @   if (found == 0) {
  @       setC[0]++;
  @       setC[nextAddressInC] = setA[k];
  @       nextAddressInC++;
  @   }

  @ }

  @ // For every element in setB
  @ for (int k = 0; k <= setB[0]; k++) {
  @   int found = 0;
  @   // for every element in setB
  @   for (int l = 0; l <= setA[0]; l++) {
  @       if (setB[k] == setA[l]) {
  @           // found
  @           found = 1;
  @           break;
  @       }
  @   }

  @   // if this element was not in the other set, add it to the third.
  @   if (found == 0) {
  @       setC[0]++;
  @       setC[nextAddressInC] = setB[k];
  @       nextAddressInC++;
  @   }

  @ }

  @    REGISTER USAGE
  @ -------------------
  @ R00 | Address of Set C
  @ R01 | Address of Set A
  @ R02 | Address of Set B
  @ R03 | Whether or not we found a match (boolean 0/1)
  @ R04 | Copy of Address 1 (So we can change it without loosing the origin)
  @ R05 | Copy of Address 2 (So we can change it without loosing the origin)
  @ R06 | Constant 4 (For multiplication -> word sized values)
  @ R07 | LDR/STR Temporary variable
  @ R08 | LDR/STR Temporary variable
  @ R09 | Final Address of Set A
  @ R10 | Final Address of Set B
  @ R11 | Size of Set C
  @ R12 | Final address of Set C
  @ -------------------

  @ SETUP -> Setup registers for use in both for loops.
Main:
    LDR     R6, =4              @ Used for multiplication (as values are in 4-space intervals)
    LDR     R11, =0             @ Used to store the amount of values in Set C

    LDR     R7, [R1]
    MUL     R7, R7, R6
    ADD     R9, R1, R7          @ Address of the last value in set A

    LDR     R7, [R2]
    MUL     R7, R7, R6
    ADD     R10, R2, R7         @ Address of the last value in set B

    ADD     R12, R0, #4         @ Address of the last value in set C

    ADD     R4, R1, #4          @ Prepare first address in setA (skip size)

ForEachInA:                     @ Checks every value in setA against setB
    CMP     R4, R9              @ If a duplicate is found, continue until we 
    BGT     EndForEachInA       @ have found (AnB)' i.e what is only in set A or setB

    LDR     R3, =0              @ Set found to false
    LDR     R7, [R4], #4
    ADD     R5, R2, #4          @ Go back to the start of b
CheckIfItsInSetB:
    CMP     R5, R10             @ Checks to see if we've gone past the last value in setB
    BGT     EndCheckIfItsInSetB

    LDR     R8, [R5], #4

    CMP     R7, R8              @ Compare the current value in A against the current value of B
    BNE     CheckIfItsInSetB

    MOV     R3, #1              @ It is equal, found to be true

EndCheckIfItsInSetB:
    CMP     R3, #0              @ If we did not find this element of A in B
    BNE     ForEachInA

    ADD     R11, R11, #1        @ Increase of size C (the amount of elements within it)
    STR     R7, [R12], #4       @ Store the new value in C

    B       ForEachInA
EndForEachInA:

  @ This second for loop is a mirror of the first, swapping A for B and vice versa to chec
  @ What is in B but not A.

    ADD     R4, R2, #4          @ Prepare first address in setB (skip size)
ForEachInB:
    CMP     R4, R10
    BGT     EndForEachInB

    LDR     R3, =0              @ Set found to false
    LDR     R7, [R4], #4
    ADD     R5, R1, #4          @ Go to the start of B
CheckIfItsInSetA:
    CMP     R5, R9                  
    BGT     EndCheckIfItsInSetA

    LDR     R8, [R5], #4

    CMP     R7, R8              @ Compare current value of B to the current value of A
    BNE     CheckIfItsInSetA 

    MOV     R3, #1              @ It is equal, found to be true

EndCheckIfItsInSetA:

    CMP     R3, #0
    BNE     ForEachInB

    ADD     R11, R11, #1        @ Increase of Size C
    STR     R7, [R12], #4       @ Store the value in B that wasn't in set A into set C

    B       ForEachInB
EndForEachInB:

    STR     R11, [R0]           @ Store the amount of elements in C into the first space of Set C

End_Main:
  BX    lr

