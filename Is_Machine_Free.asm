; ================================================
; CS 61 <Winter 2010>
;
; Name: <Stenos, George>
; Username: stenosg
; Email address: gsten001@student.ucr.edu
;
;
;
;
;
; I hereby certify that the contents of this file
; are ENTIRELY my own original work.
;
;
; The program checks a list of machines to see if they are free or not. If a machine is free, the number of free machines is incremented.
; ================================================

.orig x3000

LD R4, count
LD R3, pointer

LOOP               ;Populates the array, stating if the 16 machines will be busy or free
 LD R1, busy
 STR R1, R3, #0
 ADD R3, R3, #1
 LD R1, free
 STR R1, R3, #0
 ADD R3, R3, #1
 ADD R4, R4, #-1
 BRz FILLED
BR LOOP

FILLED
 LD R1, block
 STR R1, R3, #0
 ADD R3, R3, #1
 LD R3, pointer
 LD R2, FREE_3200
 JSRR R2
 LD R2, BUSY_3400
 JSRR R2
 LD R2, CHECK_FREE_3600
 JSRR R2
 LD R2, CHECK_BUSY_3800
 JSRR R2
 LD R2, USER_FREE_5000
 JSRR R2
 LD R2, USER_BUSY_5200
 JSRR R2


HALT
;Data
USER_BUSY_5200 .fill x5200
USER_FREE_5000 .fill x5000
CHECK_BUSY_3800 .fill x3800
CHECK_FREE_3600 .fill x3600
FREE_3200 .fill x3200
BUSY_3400 .fill x3400
block .fill #13
count .fill #8
free .fill #1
busy .fill #0
pointer .fill x4001
.END


.orig x4001
array .blkw #16


;----------------------------------------------------------------
;Subroutine: FREE_3200
;Paramteres: Array of machines depicting if they are busy or not.
;Postcondition: Checks to see if all the machines are free.
;Return value: none
.orig x3200
;--------------------------------------------------------------

ST R7, BACKUP_R7_3200
ST R3, BACKUP_R3_3200


Loopx
 LDR R1, R3, #0
 ADD R1, R1, #-1
 BRn NO           ;If its negative that means a machine is busy
 ADD R1, R1, #1
 ADD R1, R1, #-13
 BRz YES          ;Never encountered a negative, all machines are free
 ADD R3, R3, #1
BR Loopx



 NO
 LEA R0, noout
 PUTS
 LD R7, BACKUP_R7_3200
 LD R3, BACKUP_R3_3200
 RET

 YES 
 LEA R0, yesout
 PUTS
 LD R7, BACKUP_R7_3200
 LD R3, BACKUP_R3_3200
 RET






;Data
yesout .stringz "\nYES\n"
noout .stringz "\nNO\n"
BACKUP_R7_3200 .blkw #1
BACKUP_R3_3200 .blkw #1


;----------------------------------------------------------------
;Subroutine: BUSY_3400
;Paramteres: Array of machines depicting if they are busy or not.
;Postcondition: Checks to see if all the machines are busy.
;Return value: none
.orig x3400
;--------------------------------------------------------------

ST R7, BACKUP_R7_3400
ST R3, BACKUP_R3_3400


Loopx2
 LDR R1, R3, #0
 ADD R1, R1, #-1
 BRz NO2          ;If zero, then a machine is free.
 ADD R1, R1, #1
 ADD R1, R1, #-13
 BRz YES2         ;No zero is encountered so everything is busy.
 ADD R3, R3, #1
BR Loopx2



 NO2
 LEA R0, noout2
 PUTS
 LD R7, BACKUP_R7_3400
 LD R3, BACKUP_R3_3400
 RET

 YES2
 LEA R0, yesout2
 PUTS
 LD R7, BACKUP_R7_3400
 LD R3, BACKUP_R3_3400
 RET






;Data
yesout2 .stringz "YES\n"
noout2 .stringz "NO\n"
BACKUP_R7_3400 .blkw #1
BACKUP_R3_3400 .blkw #1


;----------------------------------------------------------------
;Subroutine: CHECK_FREE_3600
;Paramteres: Array of machines depicting if they are busy or not.
;Postcondition: Checks to see the number of free machines.
;Return value: none
.orig x3600
;--------------------------------------------------------------

ST R7, BACKUP_R7_3600
ST R3, BACKUP_R3_3600
AND R4, R4, #0
AND R0, R0, #0
LD R5, converter

KKD
 LDR R1, R3, #0
 ADD R1, R1, #-1
 BRz INCREMENT         ;Increments R4 if machine is free.
 ADD R1, R1, #1
 ADD R1, R1, #-13
 BRz ENDED
 ADD R3, R3, #1
BR KKD



INCREMENT
ADD R4, R4, #1
ADD R3, R3, #1
BR KKD
 
ENDED              ;Label that prints out number of free machines lower than 9
ADD R4, R4, #-10
BRzp TENS
ADD R4, R4, #10
ADD R4, R4, R5
LD R0, zero
TRAP x21
AND R0, R0, #0
ADD R0, R0, R4
TRAP x21
LEA R0, newline
PUTS
LD R7, BACKUP_R7_3600
LD R3, BACKUP_R3_3600
RET


TENS            ;This label is used to print results that are higher than 9.
LD R0, one
TRAP x21
AND R0, R0, #0
ADD R0, R0, R4
ADD R0, R0, R5
TRAP x21
LEA R0, newline
PUTS
LD R7, BACKUP_R7_3600
LD R3, BACKUP_R3_3600
RET




;Data
BACKUP_R7_3600 .blkw #1
BACKUP_R3_3600 .blkw #1
newline .stringz "\n"
zero .fill #48
one .fill #49
converter .fill #48

;----------------------------------------------------------------
;Subroutine: CHECK_BUSY_3800
;Paramteres: Array of machines depicting if they are busy or not.
;Postcondition: Checks to see the number of busy machines.
;Return value: none
.orig x3800
;--------------------------------------------------------------

ST R7, BACKUP_R7_3800
ST R3, BACKUP_R3_3800
AND R4, R4, #0
AND R0, R0, #0
LD R5, converterx


KKDx
 LDR R1, R3, #0
 ADD R1, R1, #-1
 BRn INCREMENTx              ;Increments count of R4 is machine is busy
 ADD R1, R1, #1
 ADD R1, R1, #-13
 BRz ENDEDx
 ADD R3, R3, #1 
BR KKDx



INCREMENTx
ADD R4, R4, #1
ADD R3, R3, #1
BR KKDx

ENDEDx                     ;Label that prints out number of busy machines lower than 9
ADD R4, R4, #-10
BRzp TENSx
ADD R4, R4, #10
ADD R4, R4, R5
LD R0, zerox
TRAP x21
AND R0, R0, #0
ADD R0, R0, R4
TRAP x21
LEA R0, newlinex
PUTS
LD R7, BACKUP_R7_3800
LD R3, BACKUP_R3_3800
RET


TENSx                   ;This label is used to print results that are higher than 9
LD R0, onex
TRAP x21
AND R0, R0, #0
ADD R0, R0, R4
ADD R0, R0, R5
TRAP x21
LEA R0, newlinex
PUTS
LD R7, BACKUP_R7_3800
LD R3, BACKUP_R3_3800
RET




;Data
BACKUP_R7_3800 .blkw #1
BACKUP_R3_3800 .blkw #1
newlinex .stringz "\n"
zerox .fill #48
onex .fill #49
converterx .fill #48


;----------------------------------------------------------------
;Subroutine: USER_FREE_5000
;Paramteres: Array of machines depicting if they are busy or not.
;Postcondition: Checks to see if the machine at wherever user indicated is free.
;Return value: none
.orig x5000
;--------------------------------------------------------------

ST R7, BACKUP_R7_5000
ST R3, BACKUP_R3_5000

LEA R0, input
PUTS
LD R2, converterz

TRAP x20
TRAP x21
ADD R0, R0, R2
ADD R0, R0, #-1
BRz TENSz
ADD R0, R0, #1
TRAP x20
TRAP x21
ADD R0, R0, R2
AND R4, R4, #0
ADD R4, R4, R0
BR CHECK


TENSz                ;Stores numbers higher than 9 in R4
 AND R4, R4, #0
 ADD R4, R4, #10
 TRAP x20
 TRAP x21
 ADD R0, R0, R2
 ADD R4, R4, R0
 BR CHECK

CHECK
 LD R6, indicater
 NOT R4, R4
 ADD R4, R4, #1
 ADD R6, R6, R4     ;Checks how many spaces to advance in the array in order to check what machine is free.
 ADD R3, R3, R6
 LDR R1, R3, #0
 ADD R1, R1, #-1
 BRz YESS           ;If zero then the machine is free.
 LEA R0, noout4
 PUTS
 LD R7, BACKUP_R7_5000
 LD R3, BACKUP_R3_5000
 RET

YESS               ;Prints that machine is free.
 LEA R0, yessout
 PUTS
 LD R7, BACKUP_R7_5000
 LD R3, BACKUP_R3_5000
 RET



HALT
;Data
noout4 .stringz "\nNO\n"
yessout .stringz "\nYES\n"
indicater .fill #15
converterz .fill #-48
BACKUP_R7_5000 .blkw #1
BACKUP_R3_5000 .blkw #1
input .stringz "Enter machine you want to check: "


;----------------------------------------------------------------
;Subroutine: USER_BUSY_5200
;Paramteres: Array of machines depicting if they are busy or not.
;Postcondition: Checks to see if the machine at wherever user indicated is busy.
;Return value: none
.orig x5200
;--------------------------------------------------------------

ST R7, BACKUP_R7_5200
ST R3, BACKUP_R3_5200

LEA R0, inputxz
PUTS
LD R2, converterxz

TRAP x20
TRAP x21
ADD R0, R0, R2
ADD R0, R0, #-1
BRz TENSxz
ADD R0, R0, #1
TRAP x20
TRAP x21
ADD R0, R0, R2
AND R4, R4, #0
ADD R4, R4, R0
BR CHECKxz

 
TENSxz               ;Stores numbers higher than 9 in R4
 AND R4, R4, #0
 ADD R4, R4, #10
 TRAP x20
 TRAP x21
 ADD R0, R0, R2
 ADD R4, R4, R0
 BR CHECKxz

CHECKxz
 LD R6, indicaterxz
 NOT R4, R4
 ADD R4, R4, #1
 ADD R6, R6, R4      ;Checks how many spaces to advance in the array in order to check what machine is busy.
 ADD R3, R3, R6
 LDR R1, R3, #0
 ADD R1, R1, #-1
 BRn YESSxz          ;If negative than machine is busy.
 LEA R0, noout4xz
 PUTS
 LD R7, BACKUP_R7_5200
 LD R3, BACKUP_R3_5200
 RET

YESSxz              ;Prints that machine is busy
 LEA R0, yessoutxz
 PUTS
 LD R7, BACKUP_R7_5200
 LD R3, BACKUP_R3_5200
 RET



HALT
;Data
noout4xz .stringz "\nNO\n"
yessoutxz .stringz "\nYES\n"
indicaterxz .fill #15
converterxz .fill #-48
BACKUP_R7_5200 .blkw #1
BACKUP_R3_5200 .blkw #1
inputxz .stringz "Enter machine you want to check: "
 
