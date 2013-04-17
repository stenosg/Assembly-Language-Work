; ================================================
; CS 61 <Winter 2010>
;
; Name: <Stenos, George>
; Username: stenosg
; Email address: gsten001@student.ucr.edu
;
;
;
; I hereby certify that the contents of this file
; are ENTIRELY my own original work.
;
;
; The following code stores word input into an array and identifies which one is the longest.
; ================================================
.orig x3000

LD R1, pointer
LD R3, INPUT_3200
JSRR R3
LD R3, LONGEST_3400
JSRR R3

LD R3, PRINTER_3600
JSRR R3


HALT
;Data

PRINTER_3600 .fill x3600
LONGEST_3400 .fill x3400
INPUT_3200 .fill x3200
pointer .fill x4000
.END

;--------------------------------------------------------------
; Subroutine: INPUT_3200
; Parameters: Input from user
; Postcondition: Stores words in array
; Return value: none
.orig x3200
;-------------------------------------------------------------

 ST R7, BACKUP_R7_3200
 ST R1, BACKUP_R1_3200
 LEA R0, message
 PUTS
 
 LOOP                  ;This loop takes in input from user and terminates if enter is pushed. Stores words in array
 TRAP x20                
 ADD R0, R0, #-10
 BRz END
 ADD R0, R0, #10
 TRAP x21
 STR R0, R1, #0
 ADD R1, R1, #1
 BR LOOP

 END         
 LD R2, block2        ;Stores a space value in order to make up for if only one word is entered
 STR R2, R1, #0
 ADD R1, R1, #1
 LD R2, block         ;Stores negative value in order to know when to stop in later subroutines
 STR R2, R1, #0
 ADD R1, R1, #1
 LD R1, BACKUP_R1_3200
 LD R7, BACKUP_R7_3200
 RET
 
 ;Data
 block2 .fill #32
 BACKUP_R1_3200 .blkw #1
 BACKUP_R7_3200 .blkw #1
 block .fill #-1
 message .stringz "Please enter a string(enter to terminate): \n"

 .orig x4000
 array .blkw #300


 ;--------------------------------------------------------------
; Subroutine: LONGEST_3400
; Parameters: R1(Array of strings)
; Postcondition: Identifies longest word
; Return value: none
.orig x3400
;-------------------------------------------------------------

 ST R7, BACKUP_R7_3400
 ST R1, BACKUP_R1_3400
 LD R2, max
 LD R3, current
 LD R4, pointer2
 LD R6, space
 

 LOOP2              ;This loop traverses the array, adding 1 each time a letter is read to the current holder, R3
 LDR R5, R1, #0     ;The loop will jump if a space is encountered in order to maintain correct word values
 BRn FINISH
 ADD R5, R5, R6
 BRz NEXT
 NOT R6, R6
 ADD R6, R6, #1
 ADD R5, R5, R6
 NOT R6, R6
 ADD R6, R6, #1
 ADD R3, R3, #1
 ADD R1, R1, #1
 BR LOOP2

 NEXT
 NOT R3, R3
 ADD R3, R3, #1     
 ADD R2, R2, R3   ;Checks to see if the current word is bigger than the max word. If it is then max is erased and replaced with current
 BRn CHANGE
 NOT R3, R3
 ADD R3, R3, #1
 ADD R2, R2, R3
 AND R3, R3, #0
 BR DETOUR

 CHANGE           
 AND R2, R2, #0
 NOT R3, R3
 ADD R3, R3, #1
 ADD R2, R2, R3   ;Changes max(R2) to current.
 AND R3, R3, #0
 BR STORE

 STORE
 LD R6, space
 NOT R2, R2
 ADD R2, R2, #1
 ADD R1, R1, R2   ;This makes the array jump the length of the word in order to store it into a separate array
 NOT R2, R2
 ADD R2, R2, #1
 KKD
 LDR R5, R1, #0
 ADD R5, R5, R6
 BRz DETOUR
 NOT R6, R6
 ADD R6, R6, #1
 ADD R5, R5, R6
 STR R5, R4, #0  ;Stores the characters of the longest word into the second array
 ADD R1, R1, #1
 ADD R4, R4, #1
 NOT R6, R6
 ADD R6, R6, #1
 BR KKD

 DETOUR
 LD R4, pointer2  ;Makes sure to start R4 over that way a new bigger word can be entered over the old max word.
 ADD R1, R1, #1   ;Increments the array in order to make sure only characters and not spaces are being read.
 BR LOOP2



 FINISH
 LD R7, BACKUP_R7_3400
 LD R1, BACKUP_R1_3400
 RET
 
 ;Data
 space .fill #-32
 pointer2 .fill x5000
 max .fill #0
 current .fill #0
 BACKUP_R7_3400 .blkw #1
 BACKUP_R1_3400 .blkw #1

 .orig x5000
 array2 .blkw #100


;--------------------------------------------------------------
; Subroutine: PRINT_3600
; Parameters: R1 and R4, the array of string and longest word
; Postcondition: Outputs string in a list, and then longest word right after
; Return value: none
.orig x3600
;-------------------------------------------------------------

 ST R7, BACKUP_R7_3600
 ST R1, BACKUP_R1_3600
 ST R4, BACKUP_R4_3600

 LEA R0, output1
 PUTS
 LD R6, checkers
 LD R1, pointerz
 LD R4, pointerz2

 PRINTER          ;Loop that prints the current word and jumps in order to output a newline, making the output come out as a list
  LDR R0, R1, #0   
  BRn FINISHIM    ;Ends the output of list from when the array does not contain any new words.
  ADD R0, R0, R6
  BRz GANK        
  NOT R6, R6
  ADD R6, R6, #1
  ADD R0, R0, R6
  TRAP x21
  ADD R1, R1, #1
  NOT R6, R6
  ADD R6, R6, #1
  BR PRINTER



 GANK            ;Outputs a newline character in order to make sure the array of words is printed in a list
 LEA R0, newline
 PUTS
 ADD R1, R1, #1
 BR PRINTER
 



 FINISHIM         ;Outputs the longest word which is in the 2nd array
 LEA R0, output2
 PUTS
 AND R0, R0, #0
 ADD R0, R0, R4
 PUTS

 

 
 ;Data
 pointerz .fill x4000
 pointerz2 .fill x5000
 BACKUP_R7_3600 .blkw #1
 BACKUP_R1_3600 .blkw #1
 BACKUP_R4_3600 .blkw #1
 checkers .fill #-32
 newline .stringz "\n"
 output1 .stringz "\nOutput: \n"
 output2 .stringz "The longest word is: "
  

 .orig x4000
 arrayz .blkw #300

 .orig x5000
 array3 .blkw #100
