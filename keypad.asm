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
t EQU 0x35
l EQU 0x36
START

    BANKSEL PORTA ;3
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
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
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
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
    
    BSF PORTA,1		;exec
    CALL TIME
    BCF PORTA,1
    CALL TIME
    
STARTL
    MOVLW d'0'
    MOVWF t
    MOVLW d'0'
    MOVWF l
ROUTINE
    MOVLW b'00101000'
    MOVWF PORTA
    MOVLW b'00010000'
    MOVWF PORTD
    CALL  CHECK1
    RLF PORTD
    CALL CHECK4
    RLF PORTD
    CALL CHECK7
    RLF PORTD
    CALL CHECK0
    GOTO EQUALS
   
EQUALS
    MOVFW t
    MOVWF t
    MOVFW l
    SUBWF t, 0
    ;MOVWF s
    BTFSS STATUS, Z
    GOTO $+2
    GOTO PRINTEQUAL
    BTFSS STATUS, C
    GOTO $+2
    GOTO PRINTGREATER
    BTFSC STATUS, C
    GOTO ROUTINE
    GOTO PRINTLESSER
    
CHECK1
    BTFSS PORTD, 0
    GOTO CHECK2
    GOTO PRINT1

CHECK2
    BTFSS PORTD, 1
    GOTO CHECK3
    GOTO PRINT2
 
CHECK3
    BTFSS PORTD, 2
    RETURN
    GOTO PRINT3

CHECK4
    BTFSS PORTD, 0
    GOTO CHECK5
    GOTO PRINT4

CHECK5
    BTFSS PORTD, 1
    GOTO CHECK6
    GOTO PRINT5
 
CHECK6
    BTFSS PORTD, 2
    RETURN
    GOTO PRINT6
    
CHECK7
    BTFSS PORTD, 0
    GOTO CHECK8
    GOTO PRINT7

CHECK8
    BTFSS PORTD, 1
    GOTO CHECK9
    GOTO PRINT8
 
CHECK9
    BTFSS PORTD, 2
    RETURN
    GOTO PRINT9
    
CHECK0
    BTFSS PORTD, 1
    RETURN
    GOTO PRINT0
    
PRINTEQUAL
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    MOVLW '='
    MOVWF PORTB
    CALL exec
    
    GOTO ROUTINE
 
PRINTLESSER
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    MOVLW '<'
    MOVWF PORTB
    CALL exec
    
    GOTO ROUTINE

PRINTGREATER
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0x87	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    MOVLW '>'
    MOVWF PORTB
    CALL exec
    
    GOTO ROUTINE
    
PRINTTOP
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0x85		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    RETURN
    
PRINTLOW
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0x89		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    RETURN

SAVETOP
    MOVWF t
    RETURN

SAVELOW
    MOVWF l
    RETURN
    
VALIDATEPOS
    BTFSC PORTA, 3
    GOTO $+3
    CALL PRINTTOP
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    CALL PRINTLOW
    RETURN
    
VALIDATEG
    BTFSC PORTA, 3
    GOTO $+3
    CALL SAVETOP
    GOTO $+4
    BTFSC PORTA, 5
    GOTO $+2
    CALL SAVELOW
    RETURN
    
PRINT1
    CALL VALIDATEPOS
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    MOVLW d'1'
    CALL VALIDATEG
    
    GOTO EQUALS
    
PRINT2
    CALL VALIDATEPOS
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    MOVLW d'2'
    CALL VALIDATEG
    
    GOTO EQUALS
    
PRINT3
    CALL VALIDATEPOS
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    MOVLW d'3'
    CALL VALIDATEG
    
    GOTO EQUALS
    
PRINT4
    CALL VALIDATEPOS
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    MOVLW d'4'
    CALL VALIDATEG

    GOTO EQUALS
 
PRINT5
    CALL VALIDATEPOS
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    MOVLW d'5'
    CALL VALIDATEG
    
    GOTO EQUALS
    
PRINT6
    CALL VALIDATEPOS
    MOVLW '6'
    MOVWF PORTB
    CALL exec
    MOVLW d'6'
    CALL VALIDATEG
    
    GOTO EQUALS
    
PRINT7
    CALL VALIDATEPOS
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    MOVLW d'7'
    CALL VALIDATEG
	
    GOTO EQUALS
    
PRINT8
    CALL VALIDATEPOS
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    MOVLW d'8'
    CALL VALIDATEG
    
    GOTO EQUALS
    
PRINT9
    CALL VALIDATEPOS
    MOVLW '9'
    MOVWF PORTB
    CALL exec
    MOVLW d'9'
    CALL VALIDATEG
    
    GOTO EQUALS
    
PRINT0
    CALL VALIDATEPOS
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    MOVLW d'0'
    CALL VALIDATEG

    GOTO EQUALS
    
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
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN
    
segundo
nop
movlw d'150' ;establecer valor de la variable m
movwf m
mloopcorto:
;nop
decfsz m,f
goto mloopcorto

 movlw d'42' ;establecer valor de la variable i
movwf i
iloopcorto:
nop ;NOPs de relleno (ajuste de tiempo)
movlw d'68' ;establecer valor de la variable j
movwf j
jloopcorto:
;nop ;NOPs de relleno (ajuste de tiempo)
movlw d'15' ;establecer valor de la variable k
movwf k
kloopcorto:
nop
decfsz k,f
goto kloopcorto
decfsz j,f
goto jloopcorto
decfsz i,f
goto iloopcorto
return ;salir de la rutina de tiempo y regresar al
 END