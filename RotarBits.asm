; PIC16F84A Configuration Bit Settings

; Assembly source line config statements

#include "p16f84a.inc"

; CONFIG
; __config 0xFFF9
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF



    LIST p=16f84A

    ORG 0
		    ;inicio de instrucciones 
    

    BSF STATUS, RP0
    
    bsf PORTA,0
    bsf PORTA,1
    bsf PORTA,2
    bsf PORTA,3
    bsf PORTA,4
    
    bcf PORTB,0
    bcf PORTB,1
    bcf PORTB,2
    bcf PORTB,3
    bcf PORTB,4
    bcf PORTB,5
    bcf PORTB,6
    bcf PORTB,7
    
    bcf STATUS,RP0
    
   
    
    
inicio 
    MOVFW PORTA
    goto rotar   
  
   
rotar
    RLF	PORTA,0
    MOVWF PORTB
    goto inicio

END    
    
