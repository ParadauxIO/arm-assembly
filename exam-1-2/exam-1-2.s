  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main
  .equ NULL, 0 
Main:
  
  @ JAVA PSEUDOCODE -> Fully works! 

  @ public class LowerCamelCase {

  @     public static void main(String[] args) {

  @         // Mocking memory
  @         char[] sentence = "..Trinity  CollEge, DUblin\0".toCharArray();
  @         char[] ram = new char[200];

  @         // The address in the two sections of memory.
  @         int sentenceAddress = 0;
  @         int ramAddress = 0;
  @         char letter;

  @         // Skip non-alphabetic chars
  @         do {
  @             letter = Character.toLowerCase(sentence[sentenceAddress]);
  @             if (!((letter >= 97 && sentence[sentenceAddress] <= 122))) {
  @                 sentenceAddress++;
  @             }
  @         } while (!((letter >= 97 && sentence[sentenceAddress] <= 122)));

  @         // make first letter lowercase (*l*owerCamelCase)
  @         ram[ramAddress] = Character.toLowerCase(sentence[sentenceAddress]);
  @         ramAddress++;
  @         sentenceAddress++;

  @         while (sentence[sentenceAddress] != '\0') {
  @             if (sentence[sentenceAddress] == ' ') {
  @                 do {
  @                     letter = Character.toLowerCase(sentence[sentenceAddress]);
  @                     if (!((letter >= 97 && sentence[sentenceAddress] <= 122))) {
  @                         sentenceAddress++;
  @                     }
  @                 } while (!(letter >= 97 && sentence[sentenceAddress] <= 122));

  @                 ram[ramAddress] = Character.toUpperCase(sentence[sentenceAddress]);
  @                 ramAddress++;
  @                 sentenceAddress++;
  @                 continue;
  @             }

  @             // if not alphabetic
  @             if (!((sentence[sentenceAddress] >= 97 && sentence[sentenceAddress] <= 122) || (sentence[sentenceAddress] >= 65 && sentence[sentenceAddress] <= 90))) {
  @                 sentenceAddress++;
  @                 continue;
  @             }

  @             // to lowercase
  @             ram[ramAddress] = Character.toLowerCase(sentence[sentenceAddress]);
  @             ramAddress++;
  @             sentenceAddress++;
  @         }

  @         // Null-terminate
  @         ram[ramAddress] = '\0';

  @         // Output the two versions of the string.
  @         System.out.println(sentence);
  @         System.out.println(ram);
  @     }

  @ }

  @    REGISTER USAGE
  @ -------------------
  @ R0 | New String address
  @ R1 | Original String address
  @ R2 | LDR/STR Temp
  @ R3 | LDR/STR Temp

  @    EQU Directives    
  @ -------------------
  @ NULL | 0x0
  @ -------------------

    WhileFirstLetterNotAlphabetic:
        LDRB    R2, [R1], #1                     
        ORR     R2, R2, #0x20                   @ Force Lowercase 

    IfFirstLetterAlphabetic:    
        CMP     R2, #97                         @ Skip non-alphabetic
        BLO     WhileFirstLetterNotAlphabetic   @ characters.
        CMP     R2, #122
        BHI     WhileFirstLetterNotAlphabetic

    EndWhileFirstLetterNotAlphabetic:
        STRB    R2, [R0], #1                    @ Ensure first entry is lowercase.

    WhileStringHasntEnded:
        LDRB    R2, [R1], #1
        
        CMP     R2, #NULL
        BEQ     EndWhileStringHasntEnded

    IfSpace:
        CMP     R2, #' ' @ space                @ Detects the ending of the word
        BNE     EndIfSpace

    NextLetter:
        LDRB    R2, [R1], #1                    @ Get first letter of next word

        CMP     R2, #NULL
        BEQ     EndWhileStringHasntEnded        @ Ensure the string hasn't ended

        BIC     R2, R2, #0x20                   @ Make that UpperCase

        CMP     R2, #65                         @ Ensure it's actually a letter
        BLO     NextLetter
        CMP     R2, #90
        BHI     NextLetter

        STRB    R2, [R0], #1                    @ Store the new letter in the new string.
        B       WhileStringHasntEnded
    EndIfSpace:
        ORR     R2, R2, #0x20                   @ If it wasn't a space, lowercase whatever it was.
    
    IfNotAlphabetic:
        CMP     R2, #97                         @ Ensure that it's a letter
        BLO     WhileStringHasntEnded
        CMP     R2, #122
        BHI     WhileStringHasntEnded

    EndIfNotAlphabetic:
        STRB    R2, [R0], #1                    @ Store that letter in the new string.
        B       WhileStringHasntEnded

    EndWhileStringHasntEnded:
        LDR     R2, =0                          @ Explicitly Null terminate our new string.
        STRB    R2, [R0]

    End_Main:
        BX      lr                              @ Return

