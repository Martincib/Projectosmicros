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
up EQU 0x35
down EQU 0x36
cont EQU 0x37
dez EQU 0x38
diz EQU 0x23
aux EQU 0x39
gr EQU 0x22
decr EQU 0x24
o EQU 0x40
p EQU 0x43
v EQU 0x41
r EQU 0x42
 
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
    
main
    MOVLW d'0'
    MOVWF up
    MOVLW d'0'
    MOVWF down
    
    MOVLW b'00000000'
    MOVWF cont
    
    MOVLW 0x83
    MOVWF dez
    
    MOVLW 0xC3
    MOVWF diz
    
    MOVLW d'8'
    MOVWF decr
    
    CALL PRINTBIN
    
ROUTINE
    MOVLW b'00101000'
    MOVWF PORTA
    MOVLW b'00010000'
    MOVWF PORTD
    CALL REG1
    RLF PORTD
    RLF PORTD
    RLF PORTD
    CALL REG0
    GOTO ROUTINE
    
REG1
    BTFSS PORTD, 0
    return
    GOTO SAVE1
   
REG0
    BTFSS PORTD, 1
    GOTO ESP
    GOTO SAVE0
 
ESP
    BTFSS PORTD, 2
    RETURN
    GOTO GREY
    
    
SAVE1 
    CALL SHORT_TIME
    RLF cont
    MOVLW b'00000001'
    IORWF cont,0
    MOVWF cont 
    CALL PRINT1 
SAVE0
    CALL SHORT_TIME
    RLF cont
    CALL PRINT0

GREY
    CALL SHORT_TIME
    MOVFW cont
    MOVWF aux
    RRF aux
    
    MOVFW cont
    XORWF aux,0
    MOVWF aux   
rut
    BCF STATUS,C
    RLF aux
    BTFSS STATUS,C
    GOTO $+3
    CALL I1
    GOTO $+2
    CALL I0
    DECFSZ decr
    GOTO rut
    GOTO ROUTINE
    
    
;IMPRESIONES
    
PRINTBIN
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    MOVLW 'B'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVLW 0xC0		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    GOTO ROUTINE  
    
    
PRINTTOP
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVFW dez		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    RETURN
    
PRINTLOW
    BCF PORTA,0		;command mode
    CALL TIME
    
    MOVFW diz		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL TIME
    
    RETURN


 
PRINT1
    INCF dez
    CALL PRINTTOP
    MOVLW '1'
    MOVWF PORTB
    CALL exec
   
  
    GOTO ROUTINE
    
PRINT0
    INCF dez
    CALL PRINTTOP
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    

    GOTO ROUTINE
   
I0
    INCF diz
    CALL PRINTLOW
    MOVLW '0'
    MOVWF PORTB
    CALL exec
   
    
    return
    
I1
    INCF diz
    CALL PRINTLOW
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    
    
    return   
    
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
    
    
SHORT_TIME
nop
nop
movlw d'151' ;establecer valor de la variable k || cada uno vale 2--
movwf o
oloop
    decfsz o,f
    goto oloop
    movlw d'43' ;establecer valor de la variable i || vale 36088
    movwf p
ploop
    nop;27
    ;NOPs de relleno (ajuste de tiempo)    
    ;152
    movlw d'70' ;establecer valor de la variable j ||  15714
    movwf v
vloop
   
    movlw d'20' ;establecer valor de la variable k ||27,816
    movwf r
rloop
    nop
    decfsz r,f
    goto rloop
    decfsz v,f
    goto vloop
    decfsz p,f
    goto ploop
    return
 END