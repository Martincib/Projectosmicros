#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
;inicio del programa: 
START
	MOVLW 0x07 ;Apagar comparadores
	MOVWF CMCON
	BCF STATUS, RP1 ;Cambiar al banco 1
	BSF STATUS, RP0 
	MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
	MOVWF TRISB 
	BCF STATUS, RP0 ;Regresar al banco 0
	
	
INICIO	BTFSS PORTA,0
	GOTO $-2
	MOVLW D'6'
	BTFSS PORTA,0
	GOTO INICIO
	MOVWF PORTB
	MOVLW D'5'
	BTFSS PORTA,0
	GOTO INICIO
	MOVWF PORTB
	MOVLW D'4'
	BTFSS PORTA,0
	GOTO INICIO
	MOVWF PORTB
	MOVLW D'3'
	BTFSS PORTA,0
	GOTO INICIO
	MOVWF PORTB
	MOVLW D'2'
	BTFSS PORTA,0
	GOTO INICIO
	MOVWF PORTB
	MOVLW D'1'
	BTFSS PORTA,0
	GOTO INICIO
	MOVWF PORTB
	GOTO INICIO
			
    END
    