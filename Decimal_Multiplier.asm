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
; Implementation of multiplier that does not allow for more than triple digit decimal numbers.
; ================================================

.orig x3000
LD R1, checkerpos
LD R2, checkerneg
LD R3, pointer
LD R4, converter
LD R5, digits
LD R6, count

LEA R0, message
PUTS

TRAP x20
TRAP x21
ADD R0, R0, R1
BRz POSITIVE   ;Checks sign
NOT R1, R1
ADD R1, R1, #1
ADD R0, R0, R1
ADD R0, R0, R2
BRz NEGATIVE    ;Checks sign
NOT R2, R2
ADD R2, R2, #1
ADD R0, R0, R2
ADD R0, R0, R4
LD R1, even     ;Adds 2, meaning it is even
STR R1, R3, #0
ADD R3, R3, #1
STR R0, R3, #0  ;Store Input into Array
ADD R3, R3, #1
LOOP
TRAP x20
TRAP x21
ADD R0, R0, R4
ADD R0, R0, R5
BRp INVALID      ;Checks if input is invalid
NOT R5, R5
ADD R5, R5, #1
ADD R0, R0, R5
STR R0, R3, #0
ADD R3, R3, #1
ADD R6, R6, #-1  ;Loops until 3 digits are entered
BRz END_LOOP
NOT R5, R5
ADD R5, R5, #1
LD R0, zero
BR LOOP

END_LOOP
LD R1, INPUTTWO_3400 ;Gets 2nd Input
JSRR R1
LD R3, pointer
ADD R3, R3, #1  ;Makes sure to increment so sign is not read
LD R2, CONVERTER_3600
JSRR R2
LD R3, pointerx
ADD R3, R3, #1 ;Makes sure to increment so sign is not read
LD R5, zero
ADD R5, R6, #0
LD R2, CONVERTER_3600
JSRR R2
LD R2, MULTIPLIER_3800
JSRR R2
LD R2, PRINTER_6000
JSRR R2


NEGATIVE
LD R3, pointer
LD R0, odd ;Adds 1, meaning its odd
STR R0, R3, #0
ADD R3, R3, #1 ;Makes sure to increment so sign is not read
LD R1, INPUTONE_3200
JSRR R1
LD R1, INPUTTWO_3400
JSRR R1
LD R3, pointer
ADD R3, R3, #1 ;Makes sure to increment so sign is not read
LD R2, CONVERTER_3600
JSRR R2
LD R3, pointerx
ADD R3, R3, #1 ;Makes sure to increment so sign is not read
LD R5, zero
ADD R5, R6, #0
LD R2, CONVERTER_3600
JSRR R2
LD R2, MULTIPLIER_3800
JSRR R2
LD R2, PRINTER_6000
JSRR R2

POSITIVE
LD R3, pointer 
LD R0, even ;Adds 2, meaning its even
STR R0, R3, #0
ADD R3, R3, #1 ;Makes sure to increment so sign is not read
LD R1, INPUTONE_3200
JSRR R1
LD R1, INPUTTWO_3400
JSRR R1 
LD R3, pointer
ADD R3, R3, #1 ;Makes sure to increment so sign is not read
LD R2, CONVERTER_3600
JSRR R2
LD R3, pointerx
ADD R3, R3, #1 ;Makes sure to increment so sign is not read
LD R5, zero
ADD R5, R6, #0
LD R2, CONVERTER_3600
JSRR R2
LD R2, MULTIPLIER_3800
JSRR R2
LD R2, PRINTER_6000
JSRR R2


INVALID
HALT


;Data
PRINTER_6000 .fill x6000
even .fill #2
odd .fill #1
pointerz .fill x4100
pointerx .fill x4050
MULTIPLIER_3800 .fill x3800
CONVERTER_3600 .fill x3600
INPUTONE_3200 .fill x3200
INPUTTWO_3400 .fill x3400
zero.fill #0
count .fill #2
message .stringz "\nPlease type in a number no big than three digits: \n"
pointer .fill x4000
converter .fill #-48
digits .fill #-9
checkerpos .fill #-43
checkerneg .fill #-45



.orig x4000
array1 .blkw #10
.orig x4050
array2 .blkw #10
.orig x4100
array3 .blkw #10




;--------------------------------------------------------------
; Subroutine: INPUTONE_3200
; Parameters: Input from user
; Postcondition: Stores numbers in array
; Return value: none
.orig x3200
;--------------------------------------------------------------
ST R7, BACKUP_R7_3200
ST R3, BACKUP_R3_3200
LD R6, count1


NOT R2, R2
ADD R2, R2, #1
ADD R0, R0, R2
LOOP1
TRAP x20
TRAP x21
ADD R0, R0, R4
ADD R0, R0, R5
BRp INVALID1
NOT R5, R5
ADD R5, R5, #1
ADD R0, R0, R5
STR R0, R3, #0
ADD R3, R3, #1
ADD R6, R6, #-1
BRz END_LOOP1
NOT R5, R5
ADD R5, R5, #1
LD R0, zero1
BR LOOP1

END_LOOP1
LD R7, BACKUP_R7_3200
RET


INVALID1
HALT
;Data
BACKUP_R7_3200 .blkw #1
BACKUP_R3_3200 .blkw #1
zero1.fill #0
count1 .fill #3
pointer1 .fill x4000
converter1 .fill #-48
digits1 .fill #-9
checkerpos1 .fill #-43
checkerneg1 .fill #-45

.orig x4000
array1 .blkw #10
.end

;--------------------------------------------------------------
; Subroutine: INPUTTWO_3400
; Parameters: Input from user
; Postcondition: Stores numbers in array
; Return value: none
.orig x3400
;--------------------------------------------------------------

ST R7, BACKUP_R7_3400
ST R3, BACKUP_R3_3400
LD R1, checkerpos2
LD R2, checkerneg2
LD R3, pointer2
LD R4, converter2
LD R5, digits2
LD R6, count2

LEA R0, message2
PUTS


TRAP x20
TRAP x21
ADD R0, R0, R1
BRz POSITIVE3
NOT R1, R1
ADD R1, R1, #1
ADD R0, R0, R1
ADD R0, R0, R2
BRz NEGATIVE3
NOT R2, R2
ADD R2, R2, #1
ADD R0, R0, R2
ADD R0, R0, R4
LD R1, even2
STR R1, R3, #0 ;Adds 2, meaning its even
ADD R3, R3, #1
STR R0, R3, #0
ADD R3, R3, #1
LOOP2
TRAP x20
TRAP x21
ADD R0, R0, R4
ADD R0, R0, R5
BRp INVALID2
NOT R5, R5
ADD R5, R5, #1
ADD R0, R0, R5
STR R0, R3, #0
ADD R3, R3, #1
ADD R6, R6, #-1
BRz END_LOOP2
NOT R5, R5
ADD R5, R5, #1
LD R0, zero2
BR LOOP2

POSITIVE3
LD R6, countx
LD R3, pointer2
LD R1, even2 
STR R1, R3, #0 ;Adds 2, meaning its even
ADD R3, R3, #1
LOOP3
TRAP x20
TRAP x21
ADD R0, R0, R4
ADD R0, R0, R5
BRp INVALID3
NOT R5, R5
ADD R5, R5, #1
ADD R0, R0, R5
STR R0, R3, #0
ADD R3, R3, #1
ADD R6, R6, #-1
BRz END_LOOP3
NOT R5, R5
ADD R5, R5, #1
LD R0, zero2
BR LOOP3

NEGATIVE3
LD R6, countx
LD R3, pointer2
LD R1, odd2 ;Adds 1, meaning its odd
STR R1, R3, #0
ADD R3, R3, #1
LOOP4
TRAP x20
TRAP x21
ADD R0, R0, R4
ADD R0, R0, R5
BRp INVALID4
NOT R5, R5
ADD R5, R5, #1
ADD R0, R0, R5
STR R0, R3, #0
ADD R3, R3, #1
ADD R6, R6, #-1
BRz END_LOOP4
NOT R5, R5
ADD R5, R5, #1
LD R0, zero2
BR LOOP4


END_LOOP4
END_LOOP3
END_LOOP2
LD R7, BACKUP_R7_3400
RET

INVALID4
INVALID3
INVALID2
HALT
;Data
odd2 .fill #1
even2 .fill #2
countx .fill #3
BACKUP_R7_3400 .blkw #1
BACKUP_R3_3400 .blkw #1
zero2.fill #0
count2 .fill #2
pointer2 .fill x4050
converter2 .fill #-48
digits2 .fill #-9
checkerpos2 .fill #-43
checkerneg2 .fill #-45
message2 .stringz "\nPlease type in a number no big than three digits: \n"
.orig x4050
array1 .blkw #10
.end


;--------------------------------------------------------------
; Subroutine: CONVERTER_3600
; Parameters: Array of numbers
; Postcondition: Stores numbers in register
; Return value: R6
.orig x3600
;--------------------------------------------------------------
ST R7, BACKUP_R7_3600
ST R3, BACKUP_R3_3600
ST R5, BACKUP_R5_3600
LD R6, zerox
LD R4, first
LD R1, zerox
LDR R6, R3, #0
LDR R5, R3, #0
LOOPx
ADD R6, R6, R5
ADD R4, R4, #-1
BRz NEXT
BR LOOPx

NEXT
ADD R3, R3, #1
LD R4, second
LDR R5, R3, #0
LDR R1, R3, #0
LOOPz
ADD R1, R1, R5
ADD R4, R4, #-1
BRz END
BR LOOPz

END
ADD R6, R6, R1
ADD R3, R3, #1
LDR R5, R3, #0
ADD R6, R6, R5
LD R7, BACKUP_R7_3600
LD R5, BACKUP_R5_3600
RET


;Data
first .fill #99
second .fill #9
zerox .fill #0
BACKUP_R7_3600 .blkw #1
BACKUP_R3_3600 .blkw #1
BACKUP_R5_3600 .blkw #1

;--------------------------------------------------------------
; Subroutine: MULTIPLIER_3800
; Parameters: R5 and R6
; Postcondition: Multiply R6 by R5
; Return value: R6
.orig x3800
;--------------------------------------------------------------
ST R7, BACKUP_R7_3800
ST R3, BACKUP_R3_3800
ST R5, BACKUP_R5_3800
ST R6, BACKUP_R6_3800

LD R4, zeroz
ADD R4, R4, R6

LOOP_x ;Loop that multiplies the numbers
ADD R5, R5, #-1
BRz STOP
ADD R6, R6, R4
BR LOOP_x

STOP
LD R7, BACKUP_R7_3800
LD R5, BACKUP_R5_3800
RET


;Data
zeroz .fill #0
BACKUP_R7_3800 .blkw #1
BACKUP_R3_3800 .blkw #1
BACKUP_R5_3800 .blkw #1
BACKUP_R6_3800 .blkw #1


;--------------------------------------------------------------
; Subroutine: PRINTER_6000
; Parameters: R6 and arrays containing signs
; Postcondition: Will correctly output product with correct sign.
; Return value: Output to console.(none)
.orig x6000
;--------------------------------------------------------------

ST R7, BACKUP_R7_6000
ST R3, BACKUP_R3_6000
ST R5, BACKUP_R5_6000
ST R6, BACKUP_R6_6000

LD R3, zero7
LD R1, tenprint
LD R2, countprint
ADD R3, R3, R6      ;If the number is negative that means it has overflown
BRn OVERFLOW
 
 

LD R3, gekas
LD R2, henry
LDR R1, R3, #0 ;Loads sign of first decimal number.
LDR R4, R2, #0 ;Loads sign of second decimal number.
ADD R4, R4, R1
ADD R4, R4, #-3 ;If its 0, then its Negative, if its 1, then its Positive
BRz NEG
BRnp POS

NEG  ;Output for Negative
LD R2, countprint
LD R4, converterv
LD R5, tenkprint
LEA R0, displayneg
PUTS
LOOPx1              ;Checks to see how many 10k's should be output
ADD R6, R6, R5
BRzp MORE
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
LD R0, zero7
ADD R0, R0, R2
ADD R0, R0, R4
TRAP x21

LD R5, onekprint
LD R2, countprint

LOOPx2               ;Checks to see how many 1k's should be output
ADD R6, R6, R5
BRzp MORE2
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
LD R0, zero7
ADD R0, R0, R2
ADD R0, R0, R4
TRAP x21

LD R5, hundprint
LD R2, countprint

LOOPx3            ;Checks to see how many 100's should be output
ADD R6, R6, R5
BRzp MORE3
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
LD R0, zero7
ADD R0, R0, R2
ADD R0, R0, R4
TRAP x21

LD R5, tenprint
LD R2, countprint

LOOPx4            ;Checks to see how many 10's should be output
ADD R6, R6, R5
BRzp MORE4
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
LD R0, zero7
ADD R0, R0, R2
ADD R0, R0, R4
TRAP x21
LD R0, zero7
ADD R0, R0, R6    ;Adds the 1's place to be output
ADD R0, R0, R4
TRAP x21
BR SUB_ZERO_WINS

MORE4
ADD R2, R2, #1
BR LOOPx4

MORE3
ADD R2, R2, #1
BR LOOPx3

MORE
ADD R2, R2, #1
BR LOOPx1

MORE2
ADD R2, R2, #1
BR LOOPx2



POS
LD R2, countprint
LD R4, converterv
LD R5, tenkprint
LEA R0, displaypos
PUTS
KKDx1
ADD R6, R6, R5
BRzp KKD
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
LD R0, zero7
ADD R0, R0, R2
ADD R0, R0, R4
TRAP x21

LD R5, onekprint
LD R2, countprint

KKDx2
ADD R6, R6, R5
BRzp KKD2
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
LD R0, zero7
ADD R0, R0, R2
ADD R0, R0, R4
TRAP x21

LD R5, hundprint
LD R2, countprint

KKDx3
ADD R6, R6, R5
BRzp KKD3
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
LD R0, zero7
ADD R0, R0, R2
ADD R0, R0, R4
TRAP x21

LD R5, tenprint
LD R2, countprint

KKDx4
ADD R6, R6, R5
BRzp KKD4
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
LD R0, zero7
ADD R0, R0, R2
ADD R0, R0, R4
TRAP x21
LD R0, zero7
ADD R0, R0, R6
ADD R0, R0, R4
TRAP x21
BR FATALITY

KKD4
ADD R2, R2, #1
BR KKDx4

KKD3
ADD R2, R2, #1
BR KKDx3

KKD
ADD R2, R2, #1
BR KKDx1

KKD2
ADD R2, R2, #1
BR KKDx2


OVERFLOW
LEA R0, errorm
PUTS
SUB_ZERO_WINS
FATALITY
HALT


;Data
megax .fill #
converterv .fill #48
tenkprint .fill #-10000
onekprint .fill #-1000
hundprint .fill #-100
tenprint .fill #-10
countprint .fill #0
errorm .stringz "\nError: Cannot output, overflow."
BACKUP_R7_6000 .blkw #1
BACKUP_R3_6000 .blkw #1
BACKUP_R5_6000 .blkw #1
BACKUP_R6_6000 .blkw #1
displaypos .stringz "\nThe Product is: "
displayneg .stringz "\nThe Product is: -"
zero7 .fill #0
gekas .fill x4000
henry .fill x4050

.orig x4000
array7 .fill x4000

.orig x4070
array8 .fill x4050
.END

