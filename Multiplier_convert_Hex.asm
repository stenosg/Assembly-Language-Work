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
; Implementation of a multiplier using only a simple unsigned adder, the product will then be converted and output in hex.
; ================================================

.orig x3000

LD R3, pointer
LD R4, INPUT_3200
JSRR R4

LD R4, CONVERTER_3400
JSRR R4

LD R4, PRINTER_3600
JSRR R4

HALT
;Data
PRINTER_3600 .fill x3600
CONVERTER_3400 .fill x3400
INPUT_3200 .fill x3200
pointer .fill x4000

.END
;--------------------------------------------------------------
; Subroutine: INPUT_3200
; Parameters: Input from user
; Postcondition: Stores numbers in array
; Return value: none
.orig x3200
;--------------------------------------------------------------

ST R7, BACKUP_R7_3200
ST R3, BACKUP_R3_3200

LD R5, signcheck
LD R1, checke
LD R2, converterx
LEA R0, message1
PUTS

TRAP x20
TRAP x21
ADD R0, R0, R5
BRz SKIP
NOT R5, R5
ADD R5, R5, #1
ADD R0, R0, R5
ADD R0, R0, R2
STR R0, R3, #0
ADD R3, R3, #1

SKIP
KKD
 TRAP x20
 ADD R0, R0, R1
 BRz DONE
 NOT R1, R1
 ADD R1, R1, #1
 ADD R0, R0, R1
 TRAP x21
 ADD R0, R0, R2
 STR R0, R3, #0
 ADD R3, R3, #1
 NOT R1, R1
 ADD R1, R1, #1
 BR KKD
 
 


DONE

LD R6, block
STR R6, R3, #0
LD R7, BACKUP_R7_3200
LD R3, BACKUP_R3_3200
RET


;Data
signcheck .fill #-35
block .fill #13
checke .fill #-10
converterx .fill #-48
message1 .stringz "Please enter in a decimal number(Enter to stop): \n"
BACKUP_R7_3200 .blkw #1
BACKUP_R3_3200 .blkw #1
zero1.fill #0


.orig x4000
array .blkw #300



;--------------------------------------------------------------
; Subroutine: CONVERTER_3400
; Parameters: Array of numbers
; Postcondition: Stores numbers in register
; Return value: R6
.orig x3400
;--------------------------------------------------------------

ST R7, BACKUP_R7_3400
ST R3, BACKUP_R3_3400

LD R1, gekas
LD R4, multiply
LDR R6, R3, #0
LDR R5, R3, #0
LOOPx
ADD R6, R6, R5
ADD R4, R4, #-1
BRz NEXT
BR LOOPx

NEXT
 ADD R3, R3, #1
 LDR R5, R3, #0
 ADD R6, R6, R5
 LD R4, multiply
 ADD R3, R3, #1
 LDR R5, R3, #0
 ADD R5, R5, R1
 BRz FINISHED
 NOT R1, R1
 ADD R1, R1, #1
 ADD R5, R5, R1
 ADD R3, R3, #-1
 AND R5, R5, #0
 ADD R5, R5, R6
 NOT R1, R1
 ADD R1, R1, #1
 BR LOOPx
 
 

FINISHED
LD R7, BACKUP_R7_3400
RET

;Data
gekas .fill #-13
multiply .fill #9
zerox .fill #0
BACKUP_R7_3400 .blkw #1
BACKUP_R3_3400 .blkw #1


.orig x4000
array2 .blkw #300

;--------------------------------------------------------------
; Subroutine: PRINTER_3600
; Parameters: R6 and arrays containing signs
; Postcondition: Will correctly output product with correct sign.
; Return value: Output to console.(none)
.orig x3600
;--------------------------------------------------------------

ST R7, BACKUP_R7_3600
ST R6, BACKUP_R6_3600

LEA R0, output
PUTS
LD R4, converterxz
LD R5, hex1
LD R2, counti

Loopz
ADD R6, R6, R5
BRzp GEKAS1
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
AND R0, R0, #0
ADD R0, R0, R2
ADD R0, R0, #-10
BRz A
ADD R0, R0, #10
ADD R0, R0, #-11
BRz B
ADD R0, R0, #11
ADD R0, R0, #-12
BRz C
ADD R0, R0, #12
ADD R0, R0, #-13
BRz D
ADD R0, R0, #13
ADD R0, R0, #-14
BRz E
ADD R0, R0, #14
ADD R0, R0, #-15
BRz F
ADD R0, R0, #15

ADD R0, R0, R4
TRAP x21

NEXT1
LD R2, counti
LD R5, hex2

Loopz2
ADD R6, R6, R5
BRzp GEKAS2
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
AND R0, R0, #0
ADD R0, R0, R2
ADD R0, R0, #-10
BRz A2
ADD R0, R0, #10
ADD R0, R0, #-11
BRz B2
ADD R0, R0, #11
ADD R0, R0, #-12
BRz C2
ADD R0, R0, #12
ADD R0, R0, #-13
BRz D2
ADD R0, R0, #13
ADD R0, R0, #-14
BRz E2
ADD R0, R0, #14
ADD R0, R0, #-15
BRz F2
ADD R0, R0, #15
ADD R0, R0, R4
TRAP x21


NEXT2
LD R2, counti
LD R5, hex3

Loopz3
ADD R6, R6, R5
BRzp GEKAS3
NOT R5, R5
ADD R5, R5, #1
ADD R6, R6, R5
AND R0, R0, #0
ADD R0, R0, R2
ADD R0, R0, #-10
BRz A3
ADD R0, R0, #10
ADD R0, R0, #-11
BRz B3
ADD R0, R0, #11
ADD R0, R0, #-12
BRz C3
ADD R0, R0, #12
ADD R0, R0, #-13
BRz D3
ADD R0, R0, #13
ADD R0, R0, #-14
BRz E3
ADD R0, R0, #14
ADD R0, R0, #-15
BRz F3
ADD R0, R0, #15
ADD R0, R0, R4
TRAP x21

NEXT3
ADD R6, R6, #-10
BRz A4
ADD R6, R6, #10
ADD R6, R6, #-11
BRz B4
ADD R6, R6, #11
ADD R6, R6, #-12
BRz C4
ADD R6, R6, #12
ADD R6, R6, #-13
BRz D4
ADD R6, R6, #13
ADD R6, R6, #-14
BRz E4
ADD R6, R6, #14
ADD R6, R6, #-15
BRz F4
ADD R6, R6, #15
ADD R6, R6, R4
AND R0, R0, #0
ADD R0, R0, R6
TRAP x21
BR FINISHEDD



A
LD R0, hexA
TRAP x21
BR NEXT1

B
LD R0, hexB
TRAP x21
BR NEXT1

C
LD R0, hexC
TRAP x21
BR NEXT1

D
LD R0, hexD
TRAP x21
BR NEXT1

E
LD R0, hexE
TRAP x21
BR NEXT1

F
LD R0, hexF
TRAP x21
BR NEXT1

A2
LD R0, hexA
TRAP x21
BR NEXT2

B2
LD R0, hexB
TRAP x21
BR NEXT2

C2
LD R0, hexC
TRAP x21
BR NEXT2

D2
LD R0, hexD
TRAP x21
BR NEXT2

E2
LD R0, hexE
TRAP x21
BR NEXT2

F2
LD R0, hexF
TRAP x21
BR NEXT2

A3
LD R0, hexA
TRAP x21
BR NEXT3

B3
LD R0, hexB
TRAP x21
BR NEXT3

C3
LD R0, hexC
TRAP x21
BR NEXT3

D3
LD R0, hexD
TRAP x21
BR NEXT3

E3
LD R0, hexE
TRAP x21
BR NEXT3

F3
LD R0, hexF
TRAP x21
BR NEXT3

A4
LD R0, hexA
TRAP x21
BR FINISHEDD

B4
LD R0, hexB
TRAP x21
BR FINISHEDD

C4
LD R0, hexC
TRAP x21
BR FINISHEDD

D4
LD R0, hexD
TRAP x21
BR FINISHEDD

E4
LD R0, hexE
TRAP x21
BR FINISHEDD

F4
LD R0, hexF
TRAP x21
BR FINISHEDD


GEKAS1
ADD R2, R2, #1
BR Loopz

GEKAS2
ADD R2, R2, #1
BR Loopz2

GEKAS3
ADD R2, R2, #1
BR Loopz3

FINISHEDD
HALT
;Data
output .stringz "\nYour number in hex form is: x"
converterxz .fill #48
hexA .fill #65
hexB .fill #66
hexC .fill #67
hexD .fill #68
hexE .fill #69
hexF .fill #70
counti .fill #0
hex1 .fill #-4096
hex2 .fill #-256
hex3 .fill #-16
BACKUP_R7_3600 .blkw #1
BACKUP_R6_3600 .blkw #1



