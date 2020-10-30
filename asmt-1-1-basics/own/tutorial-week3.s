  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

    @ This is a solution sheet for Tutorial Week 3. 
    ; https://tcd.blackboard.com/bbcswebdav/pid-1642121-dt-content-rid-9677781_1/courses/CSU11021-A-SEM101-202021/tutorial1.pdf
    
    @ Initialise Constants
    ; X = R1; Y = R2 

    LDR R1, = 5   @ X
    LDR R2, = 6   @ Y

    @ 1. (a) -> Store x+7 in R0

    ADD R0, R1, #7 

    @ 1. (b) -> Store x+y in R0

    ADD R0, R1, R2

    @ 1. (c) -> Store y-3 in R0

    SUB R0, R2, #3 

    @ 1. (d) -> Store x-y in R0

    SUB R0, R1, R2

    @ 1. (e) -> Store 5-x in R0

    RSB R0, R1, #5

    @ 1. (f) -> Store x^2 in R0

    MUL R0, R1, R1

    @ 1. (g) -> Store 5y in R0

    LDR R3, =5
    MUL, R0, R2, R3

    @ 1. (h) Store 3x + y in R0
    ; Using R3 as a temporary register for the purposes of multiplying
    
    LDR, R3, =3
    MUL R0, R1, R3      @ Evaluate 3x
    
    ADD R0, R0, R2      @ Add 3x to y 

    @ 1. (i) Evaluate 3x^2 + 5x in R0
    ; Using R3 as a temporary register for the purposes of multiplying

    MUL R0, R1, R1      @ Evaluate X^2

    LDR R3. =3          @ Stores 3 in R3 for the purposes of multiplying
    MUL R0, R0, R3      @ Evaluating 3x^2 

    LDR R3, =5          @ Storing 5 in R3 for the purposes of multiplying
    MUL R3, R1, R3      @ Evaluating 5x
                        
    ADD R0, R0, R3      @ Adding the answer of LN44 and 47, or 3x^2 + 5y storing the answer in R0

    @ 1. (j) Evaluate 2x^2 + 6xy + 3y^2
    ; Using R3, R4 and R5 as temporary registers for storing each component, and for the purposes of multiplication.


    MUL R0, R1, R1      @ Evaluate X^2

    LDR R3, =2          @ Storing 2 in R3 for the purposes of multiplying
    MUL R0, R0, R3      @ Evaluate 2x^2

    LDR R3, =6          @ Storing 6 in R3 for the purposes of multiplying
    MUL R4, R1, R2      @ Evaluate xy 
    MUL R3, R3, R4      @ Evaluate 6xy

    LDR R4, =3          @ Storing 6 in R3 for the purposes of multiplying
    MUL R5, R2, R2      @ Evaluate y^2
    MUL R4, R3, R5      @ Evaluate 3y^2

    ADD R0, R0, R3      @ Evaluate 2x^2 + 6xy
    ADD R0, R0, R4      @ Evaluate 2x^2 + 6xy + 3y^2

    @ 2. (a) (i) Bytes in 1 KiB, (ii) Bytes in 4.5 MiB, (iii) Bits in 16MiB
    ; 1024, 4.5x2^20, 134,200,000 , 128x2^20

    @ 2. (b) How many 4-byte integers can be stored in (i) 1 MiB, (ii) 1022 bytes 
    ; 262144, 255 (N.B Ignore the remainder)

    @ 2. (c) An image, at 640 * 480 pixels with each color being stored as a 24 bit (4-bit) value, with no compression, how much memory is required (in bytes) to store the image in memory and in KiB
    ; 921,600 bytes, 900KiB

End_Main:
  BX    lr

.end
