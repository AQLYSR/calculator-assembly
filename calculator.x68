*-----------------------------------------------------------
* Title      : CALCULATOR
* Written by : Muhammad Aqil Bin Mohd Yusri
* Date       : 23/5/2025
* Description: Calculator that run basic arithmetic and logical operations
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
MAIN_LOOP:		; ask user to do arithmetic or logical operations
        LEA ASK, A1
        BSR OUTSTRING
        BSR INNUM
        CMP.L #0, D1
        BEQ EXIT
        CMP.L #1, D1
        BEQ MATH_LOOP
        CMP.L #2, D1        
        BEQ LOGIC_LOOP
        BRA MAIN_LOOP
        
LOGIC_LOOP:		; ask user to do AND or OR or NOT or XOR operations
        LEA LOGIC_MENU, A1
        BSR OUTSTRING
        BSR INNUM
        CMP.L #1, D1
        BEQ AND
        CMP.L #2, D1
        BEQ OR
        CMP.L #3, D1
        BEQ NOT
        CMP.L #4, D1
        BEQ XOR
        BRA LOGIC_LOOP
        
MATH_LOOP:		; ask user to do addition or subtraction or multiplication or division operations
        LEA MATH_MENU, A1
        BSR OUTSTRING
        BSR INNUM
        CMP.L #1, D1
        BEQ ADDITION
        CMP.L #2, D1
        BEQ SUBTRACTION
        CMP.L #3, D1
        BEQ MULTIPLICATION
        CMP.L #4, D1
        BEQ DIVISION
        BRA MATH_LOOP
        
ADDITION:		; label marking the beginning of the addition routine
        LEA PROMPT1, A1 ; prompt for first number
        BSR OUTSTRING	
        BSR INNUM	; read first number into D1
        MOVE.L D1, D2	; save first number from D1 to D2
        LEA PROMPT2, A1	; prompt for second number
        BSR OUTSTRING
        BSR INNUM 	; read first number into D1
        MOVE.L D1, D3	; save second number from D1 to D3
        BSR ADD_NUMS	; call subroutine to perform addition (result in D4)
        LEA RESULT, A1	; display 'The result is:'
        BSR OUTSTRING
        BSR OUTNUM	; display the numerical result from D4
        LEA REPEAT, A1	; print newlines for formatting
        BSR OUTSTRING	
        BRA MAIN_LOOP	; return to main loop
        
SUBTRACTION:		; label marking the beginning of subtraction routine
        LEA PROMPT1, A1	
        BSR OUTSTRING
        BSR INNUM	
        MOVE.L D1, D2
        LEA PROMPT2, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D3
        BSR SUB_NUMS	; call subroutine to perform subtraction (result in D4)
        LEA RESULT, A1
        BSR OUTSTRING
        BSR OUTNUM
        LEA REPEAT, A1
        BSR OUTSTRING
        BRA MAIN_LOOP
        
MULTIPLICATION:		; label marking the beginning of multiplication routine
        LEA PROMPT1, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D2
        LEA PROMPT2, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D3
        BSR MUL_NUMS	; call subroutine to perform multiplication (result in D4)
        LEA RESULT, A1
        BSR OUTSTRING
        BSR OUTNUM
        LEA REPEAT, A1
        BSR OUTSTRING
        BRA MAIN_LOOP
        
DIVISION:
        LEA PROMPT1, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D2
        LEA PROMPT2, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D3
        BSR DIV_NUMS	; call subroutine to perform division (quotient in lower word of D4, remainder in upper word)
        LEA QUO, A1	; display 'Quotient: '
        BSR OUTSTRING
        MOVE.L D4, D1	; move D4 to D1
        MOVE.W D1, D1	; clear upper word of D1
        EXT.L D1	; sign-extent the quotient to long word for output
        MOVE.W #3, D0	; set d0 for outputting the a number
        TRAP #15	; call to output quotient
        LEA REM, A1	; display "Remainder; "
        BSR OUTSTRING
        MOVE.L D4, D1	; move D4 to D1
        SWAP D1		; swap words in d1
        MOVE.W D1, D1	; clear upper word
        EXT.L D1	; sign-extend remainder
        MOVE.B #3, D0	; set d0 for outputting a number
        TRAP #15	; call to output remainder
        LEA REPEAT, A1
        BSR OUTSTRING
        BRA MAIN_LOOP
        
AND:
    LEA BIN_PROMPT1, A1 ;prompt for first binary number
    BSR OUTSTRING
    BSR INNUMBIN	; read first binary string into a buffer and convert to D1
    BSR CHECKBIN	; validate binary input and convert to D1 (if valid)
    MOVE.L D1, D4	; save first binary number from D1 to D4
    LEA BIN_PROMPT2, A1	; prompt for second binary number
    BSR OUTSTRING
    BSR INNUMBIN	;read second binary number
    BSR CHECKBIN	; validate and conveert
    MOVE.L D1, D5	; save esecond binary number from D1 to D4
    MOVE.L D4, D6	; copy first number to D6 for operation
    AND.L D5, D6	; perform bitwise AND operation 
    LEA RESULT, A1
    BSR OUTSTRING
    BSR OUTNUMBIN	; display binary result
    LEA REPEAT, A1
    BSR OUTSTRING
    BRA MAIN_LOOP
    
OR:
    LEA BIN_PROMPT1, A1	; prompt for first binary number
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D4	; save first binary number
    LEA BIN_PROMPT2, A1	; prompt for second binary number
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D5	; save second binary number
    MOVE.L D4, D6	; copy first number
    OR D5, D6		; perform bitwise OR operation
    LEA RESULT, A1
    BSR OUTSTRING
    BSR OUTNUMBIN	; display binary result
    LEA REPEAT, A1
    BSR OUTSTRING
    BRA MAIN_LOOP
    
NOT: 
    LEA BIN_PROMPT1, A1	; prompt for single binary number
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D4	; save binary number
    MOVE.L D4, D6	; copy to D6
    NOT D6		; perform bitwise NOT operation
    LEA RESULT, A1
    BSR OUTSTRING
    BSR OUTNUMBINNOT	; display binary result
    LEA REPEAT, A1
    BSR OUTSTRING
    BRA MAIN_LOOP
    
XOR:
    LEA BIN_PROMPT1, A1	; prompt for first binary number
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D4	; save first binary number
    LEA BIN_PROMPT2, A1	; prompt for second binary number 
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D5	; save second binary number
    MOVE.L D4, D6	; copy first number to D6
    EOR D5, D6		; perform bitwise XOR operation 
    LEA RESULT, A1
    BSR OUTSTRING
    BSR OUTNUMBIN	; display binary result
    LEA REPEAT, A1
    BSR OUTSTRING
    BRA MAIN_LOOP
    
        

EXIT:
    SIMHALT             ; halt simulator

* --- Subroutine for I/O and Arithmetic Operations ---

OUTSTRING:
    MOVE.B #14, D0	; Display string on I/O (address in A1)
    TRAP #15		
    RTS
    
INNUM:
    MOVE.B #4, D0	; Read number (result in D1)
    TRAP #15
    RTS
    
OUTNUM:
    MOVE.L D4, D1	; move number to be output from D4 to D1
    MOVE.B #3, D0	; printing number from D1
    TRAP #15
    RTS
    
ADD_NUMS:
    MOVE.L D2, D4	; copy first operand (from D2) to D4
    ADD.L D3, D4	; add second operand (from D3) to D4
    RTS			; return from subroutine
   
SUB_NUMS:
    MOVE.L D2, D4	; copy first operand (from D2) to D4
    SUB.L D3, D4	; subtract second operand (from D3) to D4
    RTS
    
MUL_NUMS:
    MOVE.L D2, D4	; copy first operand from D2 to D4
    MULS D3,D4		; signed mutiply D4 by D3
    RTS		
    
DIV_NUMS:
    MOVE.L D2, D4	; copy dividend from D2 to D4
    DIVS D3, D4		; signed divide D4 by D3
    RTS

* --- subroutines for binary input ---

INNUMBIN:
    LEA BUFFER, A1	; load address of input buffer for binary string
    MOVE.L #2, D0	; read string and store in BUFFER
    TRAP #15		
    CLR.L D1		; clear D1 to accumulate binary value
    CLR.L D2		; clear D2 as an index/counter for buuffer
    RTS
   
CHECKBIN:
    MOVE.B (A1, D2.W), D3	;read byte from bufffer at A1+D2 into D3
    CMP.B #0, D3		; check for null terminator
    BEQ CHECKDONE		; if end, go to CHECKDONE
    CMP.B #'0', D3		; check if character is '0'
    BEQ VALID_BIT		; if '0', it's a valid bit
    CMP.B #'1', D3		; check if character is '1'
    BEQ VALID_BIT		; if '1', it's a valid bit
    
    LEA INVALID_BIT, A1		; if not '0' or '1', display error message
    BSR OUTSTRING
    BRA MAIN_LOOP		; go back to main loop after invalid input
    
VALID_BIT:
    LSL.L #1, D1		; shift accumulated binary value in D1 left by 1 (make space for new bit)
    CMP.B #'1', D3		; check if current character is '1'
    BNE NO_ADD			; if not'1', skip adding1
    ADDI.L #1, D1		; if '1', add 1 to d1 (set the new bitl)
NO_ADD:
    ADDI.L #1, D2		; increment buffer index
    BRA CHECKBIN		; loop back to process next character
    
CHECKDONE:
    RTS				; return from binary input validation

* --- subroutines for binary output ---

OUTNUMBIN:
    LEA BUFFIER, A0	; load address of output buffer fro binary string
    MOVE.L D6, D3	; copy the number result from D6 to D3 for conversion
    MOVE.L #0, D2	; initialize bit counter

DECTOBIN:
    BTST #31, D3	; test the most significant bit (bit 31) of D3
    BEQ ADD_ZERO	; if bit 31 is 0, append '0' to buffer
    MOVE.B #'1', (A0)+	; if bit 31 is 1, append '1' to buffer and increment buffer
    BRA SHIFT		; got to SHIFT
    
ADD_ZERO:
    MOVE.B #'0', (A0)+	; append '0' to buffer and increment buffer pointer
    
SHIFT:
    LSL.L #1, D3	; shift D3 left by 1 (move next bit to position 31)
    ADDI.L #1, D2	; increment bit counter
    CMP.L #32, D2	; check if all 32 bits have been processed
    BLT DECTOBIN	; if not, loop back to DECTOBIN
    MOVE.B #0, (A0)	; null-terminate the string in the buffer
    
    LEA BUFFIER, A0	; reload buffer address into A0
    MOVEA.L A0, A1	; copy buffer address to A1 for trimming
    
TRIM:
    MOVE.B (A1), D0	; read character from buffer
    CMP.B #0, D0	; check for null terminator
    BEQ DONE_ZERO	; if string is all zeros, go to DONE_ZERO
    CMP.B #'1', D0	; check if current character is '1'
    BEQ IS_ONE		; if '1', we've found the first significantt bit, start copying
    ADDQ.L #1, A1	; if '0'(leading zero), incremetn A1 to skip it
    BRA TRIM		; loop to next character
    
IS_ONE:
    LEA TRIMMED, A2	; load address of final trimmed output buffer
COPY_LOOP:
    MOVE.B (A1)+, D0	; read character from source buffer (and A1)
    MOVE.B D0, (A2)+	; write character to destination buffeer (and increment A2)
    CMP.B #0, D0	; check for null terminator
    BEQ DONE		; if end of string, go to DONE
    BRA COPY_LOOP	; loop to copy the next character
    
DONE:
    LEA TRIMMED, A1	; load address of the trimmed string
    BSR OUTSTRING	; prin the trimmed binary string
    RTS
    
DONE_ZERO
    LEA ZERO, A1	; load address of the single '0' string
    BSR OUTSTRING	; print '0' (for cases where the result is zero)
    RTS
    
OUTNUMBINNOT:		; similar to OUTNUMBIN, but for negative numbers/leading '1's for NOT
     LEA BUFFIER, A0	
    MOVE.L D6, D3
    MOVE.L #0, D2

DECTOBINNOT:
    BTST #31, D3
    BEQ ADD_ZERONOT
    MOVE.B #'1', (A0)+
    BRA SHIFTNOT
    
ADD_ZERONOT:
    MOVE.B #'0', (A0)+
    
SHIFTNOT:
    LSL.L #1, D3
    ADDI.L #1, D2
    CMP.L #32, D2
    BLT DECTOBINNOT
    MOVE.B #0, (A0)
    
    LEA BUFFIER, A0
    MOVEA.L A0, A1
    
TRIM_ZERO:		; trim leading zeros in a way that handles results from NOT operation
    MOVE.B (A1), D0
    CMP.B #0, D0
    BEQ DONE_ZERO	; if entire string is null, it's zero
    CMP.B #'1', D0
    BEQ TRIM_ONE	; if '1', move to TRIM_ONE to find starting point
    ADDQ.L #1, A1
    BRA TRIM_ZERO
    
TRIM_ONE:		; trim leading 1's
    MOVE.B (A1), D0
    CMP.B #0, D0
    BEQ DONE_ZERO
    CMP.B #'0', D0	;if '0', it means the leading '1's have been trimmed
    BEQ IS_ZERO
    ADDQ.L #1, A1
    BRA TRIM_ONE
    
IS_ZERO:
    LEA TRIMMED, A2
COPY_LOOPNOT:		; copy loop for NOT result
    MOVE.B (A1)+, D0
    MOVE.B D0, (A2)+
    CMP.B #0, D0
    BEQ DONENOT
    BRA COPY_LOOP
    
DONENOT:
    LEA TRIMMED, A1
    BSR OUTSTRING
    RTS

* --- data declarations ---
ASK DC.B 'Enter 1 for arithmetic operation, 2 for logical operation, 0 to quit: ', 0
MATH_MENU DC.B 'Enter 1 for addition, 2 for subtraction, 3 for multiplication, 4 for division: ', 0
LOGIC_MENU DC.B 'Enter 1 for AND, 2 for OR, 3 for NOT, 4 for XOR: ', 0
PROMPT1 DC.B 'Enter the first number: ', 0
PROMPT2 DC.B  'Enter the second number: ', 0
REPEAT DC.B 13, 10, 13, 10, 0
RESULT DC.B 'The result is: ', 0
QUO DC.B 'Quotient: ', 0 
REM DC.B ' Remainder: ', 0
BIN_PROMPT1 DC.B 'Enter the first binary number: ', 0
BIN_PROMPT2 DC.B 'Enter the second binary number: ', 0
INVALID_BIT DC.B 'Invalid binary number! Try again. ', 10, 0
ZERO DC.B '0', 0

* --- memory allocations for buffer ---
    ORG $2000
BUFFER DS.B 32		; reserve 32 bytes for input binary string buffer

    ORG $2050
BUFFIER DS.B 32		; reserve 32 bytes for temporary binary output string buffer

    ORG $3000
TRIMMED DS.B 33		; reserve 33 bytes for the final trimmed binary output string (32 bits + null terminator)

    END    START        ; last line of source


