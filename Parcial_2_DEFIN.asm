#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program
i EQU 0x20
j EQU 0x21
k EQU 0x30
m EQU 0x31
q EQU 0x34
r EQU 0x35
s EQU 0x36
w EQU 0x37
w2 EQU 0x38
w3 EQU 0x40
w4 EQU 0x39
aux EQU 0x70
;----------------------------------------------------
t EQU 0x50
z1 EQU 0x51
z2 EQU 0x52
z3 EQU 0x53
z4 EQU 0x54
z5 EQU 0x55
z6 EQU 0x56
z7 EQU 0x57
z8 EQU 0x58
;------------------------------------------------------
aug EQU 0x41
var1 EQU 0x42
var2 EQU 0x43
var_aux EQU 0x44
var_aux2 EQU 0x45
var_aux3 EQU 0x46
var3 EQU 0x47
var4 EQU 0x48
var5 EQU 0x49
;-----------------------------------------------------



 
START

    BANKSEL PORTA 
    CLRF PORTA 
    BANKSEL ANSEL 
    CLRF ANSEL 
    CLRF ANSELH
    BANKSEL TRISA 
    CLRF TRISA
    CLRF TRISB
    CLRF TRISC
    MOVLW b'00000111'
    MOVWF TRISD
    CLRF TRISE
    BCF STATUS,RP1
    BCF STATUS,RP0
    MOVLW b'00101000'
    MOVWF TRISA
    CLRF TRISB
    CLRF TRISC
    CLRF TRISE
    
    INITLCD
    BCF PORTA,0		
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		
    CALL TIME
    BCF PORTA,1
    CALL TIME
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL TIME
    BCF PORTA,1
    CALL TIME
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		
    CALL TIME
    BCF PORTA,1
    CALL TIME
    
STARTL

    MOVLW d'0'
    MOVWF r
    MOVLW d'0'
    MOVWF s
    MOVLW 0x84
    MOVWF aug
    MOVLW 0x94
    MOVWF t
    MOVLW 0x42
    MOVWF COUNTER
    MOVLW b'00000001'
    MOVWF aux
   
    CALL PRINT_BANNER
    
MAIN

    BCF STATUS, C
    BTFSC PORTA, 5
    GOTO $+6
    RRF aux
    BTFSS STATUS, C
    GOTO $+3
    MOVLW 0x51
    MOVWF COUNTER
    MOVLW b'00101000'
    MOVWF PORTA
    MOVLW b'00010000'
    MOVWF PORTD
    CALL CONFIRM1
    RLF PORTD
    CALL CONFIRM4
    RLF PORTD
    CALL CONFIRM7
    RLF PORTD
    CALL COMMIT
    GOTO MAIN
    
CONFIRM1

    BTFSS PORTD, 0
    GOTO CONFIRM2
    GOTO PRINT_1ST

CONFIRM2

    BTFSS PORTD, 1
    GOTO CONFIRM3
    GOTO PRINT_2ND
 
CONFIRM3

    BTFSS PORTD, 2
    RETURN
    GOTO PRINT_3RD

CONFIRM4

    BTFSS PORTD, 0
    GOTO CONFIRM5
    GOTO PRINT_4TH

CONFIRM5

    BTFSS PORTD, 1
    GOTO CONFIRM6
    GOTO PRINT_5TH
 
CONFIRM6

    BTFSS PORTD, 2
    RETURN
    GOTO PRINT_6TH
    
CONFIRM7

    BTFSS PORTD, 0
    GOTO CONFIRM8
    GOTO PRINT_7TH

CONFIRM8

    BTFSS PORTD, 1
    GOTO CONFIRM9
    GOTO PRINT_8TH
 
CONFIRM9

    BTFSS PORTD, 2
    RETURN
    GOTO PRINT_9TH
    
CONFIRM0

    BTFSS PORTD, 1
    GOTO CONFIRM_RACK
    GOTO PRINT_0
    
COMMIT

    BTFSS PORTD, 0
    GOTO CONFIRM0
    GOTO CHECK
    
VALIDATE_X

    BTFSC PORTA, 3
    GOTO $+3
    CALL PRINT_UP_LCD
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    CALL PRINT_DOWN_LCD
    
    RETURN 
    
PRINT_UP_LCD

    BCF PORTA,0		
    CALL TIME
    
    MOVFW aug		
    MOVWF PORTB
   
    CALL exec
    
    BSF PORTA,0		
    CALL TIME
    
    RETURN
    
PRINT_DOWN_LCD

    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVFW t		    ;LCD position
    MOVWF PORTB
    
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    RETURN
    
    
PRINT_1ST

    CALL SHORT_DELAY_1S
    CALL LOAD_1
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    CALL SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
PRINT_2ND

    CALL SHORT_DELAY_1S
    CALL LOAD_2
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    CALL SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
PRINT_3RD

    CALL SHORT_DELAY_1S
    CALL LOAD_3
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    call SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
PRINT_4TH

    CALL SHORT_DELAY_1S
    CALL LOAD_4
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    CALL SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
 
PRINT_5TH

    CALL SHORT_DELAY_1S
    CALL LOAD_5
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    CALL SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
PRINT_6TH

    CALL SHORT_DELAY_1S
    CALL LOAD_6
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '6'
    MOVWF PORTB
    CALL exec
    call SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
PRINT_7TH

    CALL SHORT_DELAY_1S
    CALL LOAD_7
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    CALL SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
PRINT_8TH

    CALL SHORT_DELAY_1S
    CALL LOAD_8
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    CALL SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
PRINT_9TH
    CALL SHORT_DELAY_1S
    CALL LOAD_9
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '9'
    MOVWF PORTB
    CALL exec
    CALL SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
PRINT_0
    CALL SHORT_DELAY_1S
    CALL LOAD_0
    BTFSC PORTA, 3
    GOTO $+3
    INCF aug
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    INCF t
    CALL VALIDATE_X
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    call SHORT_DELAY_1S
    BTFSC PORTA, 3
    GOTO $+2
    CALL PRINT_SECRET
    
    GOTO MAIN
    
LOAD_1
    
    MOVLW d'1'
    MOVWF X_COUNTER
    INCF COUNTER
  
    RETURN
 
LOAD_2

    MOVLW d'2'
    MOVWF X_COUNTER
    INCF COUNTER
    
    RETURN
    
LOAD_3
    
    MOVLW d'3'
    MOVWF X_COUNTER
    INCF COUNTER
    
    RETURN
  
LOAD_4
 
    MOVLW d'4'
    MOVWF X_COUNTER
    INCF COUNTER
    
    RETURN
    
LOAD_5
   
    MOVLW d'5'
    MOVWF X_COUNTER
    INCF COUNTER
    
    RETURN
 
LOAD_6
  
    MOVLW d'6'
    MOVWF X_COUNTER
    INCF COUNTER
   
    RETURN
    
LOAD_7

    MOVLW d'7'
    MOVWF X_COUNTER
    INCF COUNTER
    
    RETURN
    
LOAD_8
    
    MOVLW d'8'
    MOVWF X_COUNTER
    INCF COUNTER
    
    RETURN
    
LOAD_9

    MOVLW d'9'
    MOVWF X_COUNTER
    INCF COUNTER
   
    RETURN
    
LOAD_0

    MOVLW d'0'
    MOVWF X_COUNTER
    INCF COUNTER
    
    RETURN
    
CONFIRM_RACK

    BTFSS PORTD, 2
    RETURN
    GOTO CLEAR
    
CHECK

    MOVFW var1
    XORWF z1
    BTFSS STATUS, Z
    CALL ERROR
    MOVFW var2
    XORWF z2
    BTFSS STATUS, Z
    CALL ERROR
    MOVFW var_aux
    XORWF z3
    BTFSS STATUS, Z
    CALL ERROR
    MOVFW var_aux2
    XORWF z4
    BTFSS STATUS, Z
    CALL ERROR
    MOVFW var_aux3
    XORWF z5
    BTFSS STATUS, Z
    CALL ERROR
    MOVFW var3
    XORWF z6
    BTFSS STATUS, Z
    CALL ERROR
    MOVFW var4
    XORWF z7
    BTFSS STATUS, Z
    CALL ERROR
    MOVFW var5
    XORWF z8
    BTFSS STATUS, Z
    CALL ERROR
    CALL SUCCESS
    GOTO MAIN
    
PRINT_SECRET

    BCF PORTA,0		
    CALL TIME
    
    MOVFW aug 
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL TIME
    
    MOVLW '/'
    MOVWF PORTB
    CALL exec
    
    GOTO MAIN
        
    
ERROR

    CALL SHORT_DELAY_1S
    BCF PORTA,0		
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL TIME
    BCF PORTA,1
    CALL TIME
    
    MOVLW 0x0C		
    MOVWF PORTB
    
    BSF PORTA,1		
    CALL TIME
    BCF PORTA,1
    CALL TIME
    
    DENIED
    
    MOVLW 0x3C		
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL TIME
    BCF PORTA,1
    CALL TIME
    
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0xC3	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    MOVLW '-'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'T'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW '-'
    MOVWF PORTB
    CALL exec

    
    GOTO MAIN
    
SUCCESS

    CALL SHORT_DELAY_1S
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL TIME
    BCF PORTA,1
    CALL TIME
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		
    CALL TIME
    BCF PORTA,1
    CALL TIME
     
    ACEPTED
    MOVLW 0x3C		
    MOVWF PORTB
    
    BSF PORTA,1		
    CALL TIME
    BCF PORTA,1
    CALL TIME
    
    BCF PORTA,0		
    CALL TIME
    
    MOVLW 0xC3		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    MOVLW 'V'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'L'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW '!'
    MOVWF PORTB
    CALL exec
    
    GOTO MAIN
          
CLEAR

    GOTO INITLCD
    
PRINT_BANNER

    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0x80		
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'T'
    MOVWF PORTB
    CALL exec
    
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		
    CALL TIME
    
    MOVLW 0x90		
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL TIME
    
    MOVLW 'F'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
   
    GOTO MAIN
    
exec

    BSF PORTA,1		;exec
    CALL TIME
    BCF PORTA,1
    CALL TIME
    RETURN

TIME
    CLRF i
    MOVLW d'10'
    MOVWF j
    
LOOP    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO LOOP
    RETURN
    
SHORT_DELAY_1S
NOP
NOP
movlw d'151'
movwf w
wLOOP
    decfsz w,f
    goto wLOOP
    movlw d'43'
    movwf w2
w2LOOP
    NOP
    movlw d'70' 
    movwf w3
w3LOOP
    movlw d'20' 
    movwf w4
w4LOOP
    NOP
    decfsz w4,f
    goto w4LOOP
    decfsz w3,f
    goto w3LOOP
    decfsz w2,f
    goto w2LOOP
    
    RETURN
    
 END