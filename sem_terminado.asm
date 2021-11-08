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
m equ 0x33
;inicio del programa: 
START
	MOVLW 0x07 ;Apagar comparadores
	MOVWF CMCON
	BCF STATUS, RP1 ;Cambiar al banco 1
	BSF STATUS, RP0 
	MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
	MOVWF TRISB 
	BCF STATUS, RP0 ;Regresar al banco 0
	;nop
	clrf PORTB
	ciclo:
        movlw b'00100001'
        movwf PORTB
        call cinco
	movlw b'00100010'
	movwf PORTB
	call uno
          nop
          nop
	movlw b'00001100'
	movwf PORTB
	call cinco
	movlw b'00010100'
	movwf PORTB
	call uno
	goto ciclo
	
	cinco:
           nop
	   nop
	call tiempo1
	 
	 
	tiempo1:
        movlw d'47'
        movwf m
    
        mloop1:
        decfsz m,f
        goto mloop1
    
        movlw d'101'
        movwf i
    
        iloop1:
          nop
          nop
          nop
          nop
          nop
        movlw d'89'
        movwf j
    
        jloop1:
        nop
        movlw d'91'
        movwf k
    
        kloop1:
        decfsz k,f
        goto kloop1
        decfsz j,f
        goto jloop1
        decfsz i,f
        goto iloop1
        return
    
    
        uno:
        call tiempoc
	
	
	tiempoc:
        movlw d'20'
	movwf m
	
	mloop:
        decfsz m,f
	goto mloop
	movlw d'108'
	movwf i
	
	iloop:
        nop
	nop
	nop
	nop
	nop
	movlw d'60'
	movwf j
	
	jloop:
        nop
	movlw d'24'
	movwf k
	
	kloop:
        decfsz k,f
	goto kloop
	decfsz j,f
	goto jloop
	decfsz i,f
	goto iloop
	return
	
	end