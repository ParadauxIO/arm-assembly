  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main
  
@     ------- Begin Java Pseudocode -------
    @ public static void main(String[] args) {

    @     // Mocking memory as an array
    @     int[] AuB = new int[256];
    @     int[] a = {10, 32, 57, -18, 81, 99, -5, 0, 13, -70, 7};
    @     int[] b = {8, -7, 14, 44, 81, -5, 15, 0, 2};

    @     // Copy Everyfrom in set A into Set C (AuB)
    @     for (int k = 0; k <= a[0]; k++) {
    @         AuB[k] = a[k];
    @     }

    @     int finalAuB = a[0] + 1;

    @     System.out.println(Arrays.toString(AuB));

    @     int found = 0; // Used to determine if the for loop discovered the number in the set.
    @     for (int i = 1; i <= b[0]; i++) { // For everything in B
    @         for (int j = 1; j <= a[0]; j++) { // for everything in A
    @             if (b[i] == a[j]) { // We found the number in B already in the set.
    @                 System.out.println("in set");
    @                 found = 1;
    @                 break;
    @             }
    @         }
    @         
    @         // If it wasn't found, add it to AuB
    @         if (found == 0) {
    @             System.out.println("Adding..");
    @             AuB[finalAuB] = b[i];
    @             finalAuB++;
    @         }
    @         found = 0;
    @     }

    @     System.out.println(Arrays.toString(AuB));
    @ }
@     ------- End Java Pseudocode -------
  
Main:
    @ Register | Description          
    @ ----------------------------
    @ R0       | address of AuB      
    @ R1       | address of setA     
    @ R2       | address of setB      
    @ R3       | disposable address1
    @ R4       | disposable address2
    @ R5       | disposable address3
    @ R6       | LDR/STR
    @ R7       | LDR/STR
    @ R8       | temp
    @ R9       | found flag

    @ Copy everything (if anything) from set A into set AuB (C)
    
    @ Create disposable copies of R0 and R1
    MOV R3, R0
    MOV R4, R1 
    @ Move the size over (also used to iterate)

    @ Initialse iterators for this loop
    LDR R7, =0
    LDR R8, [R1] @ size of setA  
    ADD R8, R8, #1 @ Ensure last number is there.        
CopyAllFromA:            
    CMP R7, R8 
    BGE EndCopyAllFromA

    LDR R6, [R4], #4
    STR R6, [R3], #4
    
    ADD R7, R7, #1
    b CopyAllFromA
EndCopyAllFromA:

    LDR R9, =0 @ found flag

    LDR R6, =4
    LDR R7, [R2] @ size of b
    MUL R4, R6, R7     
    ADD R4, R4, R2 
    ADD R11, R4, #4  @ final address in B      

    @ Final Address in AuB
    MUL R10, R6, R8 
    ADD R10, R10, R0

    MOV R3, R2 @ start address
    ADD R3, R3, #4
    @ Everything in use: R0, R1, R2, R3, R4, R9

    @ Size of AuB
    LDR R12, [R1]

ForEverythingInB:           
    CMP R3, R11 
    BEQ EndForEverythingInB 

    LDR R7, [R1] 
    LDR R6, =4
    MUL R6, R6, R7 
    ADD R6, R6, R1 
    ADD R4, R4, #4 @ final address in A

    MOV R5, R1 @ start address
    ADD R5, R5, #4 @ skip size
    
    @ Everything in use R0, R1, R2, R3, R4, R5, R6, R9
ForEverythingInA:
    CMP R5, R6  
    BGE EndForEverythingInA

    @ R7, R8 
    LDR R7, [R3] @ b[i]
    LDR R8, [R5] @ a[j]
IfInSet:
    CMP R7, R8 
    BNE EndIfInSet

    LDR R9, =1
    B EndForEverythingInA
EndIfInSet:

    ADD R5, R5, #4
    b ForEverythingInA
EndForEverythingInA:

IfFound:
    CMP R9, #0
    BNE EndIfFound

    STR R7, [R10], #4
    ADD R12, R12, #1
EndIfFound:
    LDR R9, =0

    ADD R3, R3, #4
    b ForEverythingInB
EndForEverythingInB:
    STR R12, [R0]


  @ End of program ... check your result

End_Main:
  BX    lr

