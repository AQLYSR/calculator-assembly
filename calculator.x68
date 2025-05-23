*-----------------------------------------------------------
* Title      : CALCULATOR
* Written by : Muhammad Aqil Bin Mohd Yusri
* Date       : 23/5/2025
* Description: Calculator that run basic arithmetic and logical operations
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
MAIN_LOOP:
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
        
LOGIC_LOOP:
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
        
MATH_LOOP:
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
        
ADDITION:
        LEA PROMPT1, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D2
        LEA PROMPT2, A1
        BSR OUTSTRING
        BSR INNUM 
        MOVE.L D1, D3
        BSR ADD_NUMS
        LEA RESULT, A1
        BSR OUTSTRING
        BSR OUTNUM
        LEA REPEAT, A1
        BSR OUTSTRING
        BRA MAIN_LOOP
        
SUBTRACTION:
        LEA PROMPT1, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D2
        LEA PROMPT2, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D3
        BSR SUB_NUMS
        LEA RESULT, A1
        BSR OUTSTRING
        BSR OUTNUM
        LEA REPEAT, A1
        BSR OUTSTRING
        BRA MAIN_LOOP
        
MULTIPLICATION:
        LEA PROMPT1, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D2
        LEA PROMPT2, A1
        BSR OUTSTRING
        BSR INNUM
        MOVE.L D1, D3
        BSR MUL_NUMS
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
        BSR DIV_NUMS
        LEA QUO, A1
        BSR OUTSTRING
        MOVE.L D4, D1
        MOVE.W D1, D1
        EXT.L D1
        MOVE.W #3, D0
        TRAP #15
        LEA REM, A1
        BSR OUTSTRING
        MOVE.L D4, D1
        SWAP D1
        MOVE.W D1, D1
        EXT.L D1
        MOVE.B #3, D0
        TRAP #15
        LEA REPEAT, A1
        BSR OUTSTRING
        BRA MAIN_LOOP
        
AND:
    LEA BIN_PROMPT1, A1
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D4
    LEA BIN_PROMPT2, A1
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D5
    MOVE.L D4, D6
    AND.L D5, D6
    LEA RESULT, A1
    BSR OUTSTRING
    BSR OUTNUMBIN
    LEA REPEAT, A1
    BSR OUTSTRING
    BRA MAIN_LOOP
    
OR:
    LEA BIN_PROMPT1, A1
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D4
    LEA BIN_PROMPT2, A1
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D5
    MOVE.L D4, D6
    OR D5, D6
    LEA RESULT, A1
    BSR OUTSTRING
    BSR OUTNUMBIN
    LEA REPEAT, A1
    BSR OUTSTRING
    BRA MAIN_LOOP
    
NOT: 
    LEA BIN_PROMPT1, A1
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D4
    MOVE.L D4, D6
    NOT D6
    LEA RESULT, A1
    BSR OUTSTRING
    BSR OUTNUMBIN
    LEA BUFFIER, A1
    BSR OUTSTRING
    LEA REPEAT, A1
    BSR OUTSTRING
    BRA MAIN_LOOP
    
XOR:
    LEA BIN_PROMPT1, A1
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D4
    LEA BIN_PROMPT2, A1
    BSR OUTSTRING
    BSR INNUMBIN
    BSR CHECKBIN
    MOVE.L D1, D5
    MOVE.L D4, D6
    EOR D5, D6
    LEA RESULT, A1
    BSR OUTSTRING
    BSR OUTNUMBIN
    LEA REPEAT, A1
    BSR OUTSTRING
    BRA MAIN_LOOP
    
        

EXIT:
    SIMHALT             ; halt simulator

OUTSTRING:
    MOVE.B #14, D0
    TRAP #15
    RTS
    
INNUM:
    MOVE.B #4, D0
    TRAP #15
    RTS
    
OUTNUM:
    MOVE.L D4, D1
    MOVE.B #3, D0
    TRAP #15
    RTS
    
ADD_NUMS:
    MOVE.L D2, D4
    ADD.L D3, D4
    RTS
   
SUB_NUMS:
    MOVE.L D2, D4
    SUB.L D3, D4
    RTS
    
MUL_NUMS:
    MOVE.L D2, D4
    MULS D3,D4
    RTS
    
DIV_NUMS:
    MOVE.L D2, D4
    DIVS D3, D4
    RTS
    
INNUMBIN:
    LEA BUFFER, A1
    MOVE.L #2, D0
    TRAP #15
    CLR.L D1
    CLR.L D2
    RTS
   
CHECKBIN:
    MOVE.B (A1, D2.W), D3
    CMP.B #0, D3
    BEQ CHECKDONE
    CMP.B #'0', D3
    BEQ VALID_BIT
    CMP.B #'1', D3
    BEQ VALID_BIT
    
    LEA INVALID_BIT, A1
    BSR OUTSTRING
    BRA INNUMBIN
    
VALID_BIT:
    LSL.L #1, D1
    CMP.B #'1', D3
    BNE NO_ADD
    ADDI.L #1, D1
NO_ADD:
    ADDI.L #1, D2
    BRA CHECKBIN
    
CHECKDONE:
    RTS
    
OUTNUMBIN:
    LEA BUFFIER, A0
    MOVE.L D6, D3
    MOVE.L #0, D2

DECTOBIN:
    BTST #31, D3
    BEQ ADD_ZERO
    MOVE.B #'1', (A0)+
    BRA SHIFT
    
ADD_ZERO:
    MOVE.B #'0', (A0)+
    
SHIFT:
    LSL.L #1, D3
    ADDI.L #1, D2
    CMP.L #32, D2
    BLT DECTOBIN
    MOVE.B #0, (A0)
    
    LEA BUFFIER, A0
    
TRIM:
    MOVE.B (A0), D0
    CMP.B #0, D0
    BEQ DONE_ZERO
    CMP.B #'1', D0
    BEQ IS_ONE
    ADDQ.L #1, A0
    BRA TRIM
    
IS_ONE:
    MOVE.B (A0)+, D0
    MOVE.B D0, (A1)+
    CMP.B #0, D0
    BEQ DONE
    BRA IS_ONE
    
DONE:
    MOVEA.L A1, A2
    LEA RESULT, A1
    BSR OUTSTRING
    MOVEA.L A2, A1
    LEA TRIMMED, A1
    BSR OUTSTRING
    RTS
    
DONE_ZERO
    LEA ZERO, A1
    BSR OUTSTRING
    RTS
    
    
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

    ORG $2000
BUFFER DS.B 32

    ORG $2050
BUFFIER DS.B 32
TRIMMED DS.B 33

    END    START        ; last line of source

