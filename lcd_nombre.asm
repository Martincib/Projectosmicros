#include "p16F628a.inc"    
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    

RES_VECT  CODE    0x0000            ; processor reset vector
    
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
  
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

i EQU 0x20
j EQU 0x21

START
    MOVLW 0x07
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0 
    CLRF TRISB
    CLRF TRISA
    BCF STATUS, RP0
    
    BCF PORTA,1
    BCF PORTA,0
    
INITLCD
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    
INICIO	  
   
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode ;El PORTA limpia? prepara o inicializa el LCD?
    CALL time
    
    MOVLW 'R'
    MOVWF PORTB         ;El PORTB definitivamente envia las letras al LCD
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
    
    CALL time
    CALL time
    CALL time

    BCF PORTA,0		;command mode ;esto sirve para saltar de renglon??
    CALL time           ;esto es un delay obviamente
    
    MOVLW 0xC0		;LCD position ;El cambio de renglon? en nueva posicion en el LCD
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'r'
    MOVWF PORTB
    CALL exec
    
    MOVLW 't'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'i'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'n'
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
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    CALL time
    CALL time
    CALL time
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x81		;LCD position
    MOVWF PORTB
    CALL exec
    
    ;------------------------------------------------------------------------------------------------------
     BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode ;El PORTA limpia? prepara o inicializa el LCD?
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
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    CALL time
    CALL time
    CALL time
    
    BCF PORTA,0		;command mode ;esto sirve para saltar de renglon??
    CALL time           ;esto es un delay obviamente
    
    MOVLW 0xC0		;LCD position ;El cambio de renglon? en nueva posicion en el LCD
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'B'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'n'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'i'
    MOVWF PORTB
    CALL exec
    
    MOVLW 't'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'o'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'r'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'n'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'd'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'o'
    MOVWF PORTB
    CALL exec
    
    MOVLW 's'
    MOVWF PORTB
    CALL exec
    
    CALL time
    CALL time
    CALL time
    
    ;---------------------------------------------------------------------------------------------------------
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode ;El PORTA limpia? prepara o inicializa el LCD?
    CALL time
    
    MOVLW 'M'
    MOVWF PORTB         ;El PORTB definitivamente envia las letras al LCD
    CALL exec
    
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'n'
    MOVWF PORTB
    CALL exec

    MOVLW 's'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'j'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'd'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 't'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    
    MOVLW 's'
    MOVWF PORTB
    CALL exec
    
    MOVLW 't'
    MOVWF PORTB
    CALL exec
    
    CALL time
    CALL time
    CALL time

    BCF PORTA,0		;command mode ;esto sirve para saltar de renglon??
    CALL time           ;esto es un delay obviamente
    
    MOVLW 0xC0		;LCD position ;El cambio de renglon? en nueva posicion en el LCD
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
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
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    CALL time
    CALL time
    CALL time
    
    GOTO INICIO

exec

    BSF PORTA,1		;exec ;Que hace exec? Prende y apaga el PORTA 1 al parecer, lo inicializa?
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time                    ;rutina de delay
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
			
			
    END