#include "p16F628a.inc"
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

RES_VECT CODE 0x0000 ; processor reset vector
 BCF PORTA,0 ;reset
 MOVLW 0x01
 MOVWF PORTB
 BSF PORTA,1 ;exec
 CALL time
 BCF PORTA,1
 CALL time
 GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main programi EQU 0x20
i EQU 0x20
j EQU 0x21
k EQU 0x30
m EQU 0x31
n EQU 0x32
p EQU 0x33
q EQU 0x34
START
 MOVLW 0x07
 MOVWF CMCON
 BCF STATUS, RP1
 BSF STATUS, RP0
 CLRF TRISB
 MOVLW b'00100000'
 MOVWF TRISA
 BCF STATUS, RP0
 BCF PORTA,1
 BCF PORTA,0
INITLCD
 BCF PORTA,0 ;reset
 MOVLW 0x01
 MOVWF PORTB
 BSF PORTA,1 ;exec
 CALL time
 BCF PORTA,1
 CALL time
 MOVLW 0x0C ;first line
 MOVWF PORTB
 BSF PORTA,1 ;exec
 CALL time
 BCF PORTA,1
 CALL time
 MOVLW 0x3C ;cursor mode
 MOVWF PORTB
 BSF PORTA,1 ;exec
 CALL time
 BCF PORTA,1
 CALL time
Main
 movlw 0xCF
 movwf n
 movlw 0x10
 movwf p
 movlw 0x8F
 movwf q
 call Nombre
 DECF q
 DECF n
 call segundo
 DECFSZ p
 GOTO $-5
 GOTO $
Nombre
 BCF PORTA,0 ;command mode
 CALL time
 MOVFW q ;LCD position
 MOVWF PORTB
 CALL exec
 BSF PORTA,0 ;data mode
 CALL time
 MOVLW 'M'
 MOVWF PORTB
 CALL exec
 MOVLW 'i'
 MOVWF PORTB
 CALL exec
 MOVLW 'c'
 MOVWF PORTB
 CALL exec 
 MOVLW 'r'
 MOVWF PORTB
 CALL exec
 MOVLW 'o'
 MOVWF PORTB
 CALL exec
 MOVLW 's'
 MOVWF PORTB
 CALL exec
 MOVLW ' '
 MOVWF PORTB
 CALL exec
 MOVLW '5'
 MOVWF PORTB
 CALL exec
 MOVLW '0'
 MOVWF PORTB
 CALL exec
 MOVLW '1'
 MOVWF PORTB
 CALL exec
 MOVLW ' '
 MOVWF PORTB
 CALL exec
 MOVLW ' '
 MOVWF PORTB
 CALL exec
 MOVLW ' '
 MOVWF PORTB
 CALL exec
 MOVLW ' '
 MOVWF PORTB
 CALL exec 
 BCF PORTA,0 ;command mode
 CALL time
 MOVFW n ;LCD position
 MOVWF PORTB
 CALL exec
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 BSF PORTA,0 ;data mode
 CALL time
 MOVLW 'R'
 MOVWF PORTB
 CALL exec
 MOVLW 'a'
 MOVWF PORTB
 CALL exec
 MOVLW 'm'
 MOVWF PORTB
 CALL exec
 MOVLW 'o'
 MOVWF PORTB
 CALL exec
 MOVLW 'n'
 MOVWF PORTB
 CALL exec
 MOVLW ' '
 MOVWF PORTB
 CALL exec
 MOVLW 'H'
 MOVWF PORTB
 CALL exec
 MOVLW 'e'
 MOVWF PORTB
 CALL exec
 MOVLW 'r'
 MOVWF PORTB
 CALL exec
 MOVLW 'n'
 MOVWF PORTB
 CALL exec
 MOVLW 'a'
 MOVWF PORTB
 CALL exec
 MOVLW 'n'
 MOVWF PORTB
 CALL exec
 MOVLW 'd'
 MOVWF PORTB
 CALL exec
 MOVLW 'e'
 MOVWF PORTB
 CALL exec
 MOVLW 'z'
 MOVWF PORTB
 CALL exec
 MOVLW ' '
 MOVWF PORTB
 CALL exec
 BCF PORTA,0 ;command mode
 CALL time
 return
exec BSF PORTA,1 ;exec
 CALL time
 BCF PORTA,1
 CALL time
 RETURN
time
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
mloopcorto
;nop
 decfsz m,f
 goto mloopcorto 
 movlw d'42' ;establecer valor de la variable i
 movwf i
iloopcorto
 nop ;NOPs de relleno (ajuste de tiempo)
 movlw d'68' ;establecer valor de la variable j
 movwf j
jloopcorto
;nop ;NOPs de relleno (ajuste de tiempo)
 movlw d'75' ;establecer valor de la variable k
 movwf k
kloopcorto
 nop
 decfsz k,f
 goto kloopcorto
 decfsz j,f
 goto jloopcorto
 decfsz i,f
 goto iloopcorto
 return ;salir de la rutina de tiempo y regresar allimpiar
 BCF PORTA,0 ;reset
 MOVLW 0x01
 MOVWF PORTB
 BSF PORTA,1 ;exec
 CALL time
 BCF PORTA,1
 CALL time
 MOVLW 0x0C ;first line
 MOVWF PORTB
 BSF PORTA,1 ;exec
 CALL time
 BCF PORTA,1
 CALL time
 MOVLW 0x3C ;cursor mode
 MOVWF PORTB
 BSF PORTA,1 ;exec
 CALL time
 BCF PORTA,1
 CALL time
 GOTO Main
 END

