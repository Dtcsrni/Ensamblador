
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
    
    bsf TRISA,0
    bsf TRISA,1
    bsf TRISA,2
    bsf TRISA,3
    bsf TRISA,4
    
    bcf TRISB,0
    bcf TRISB,1
    bcf TRISB,2
    bcf TRISB,3
    bcf TRISB,4
    bcf TRISB,5
    bcf TRISB,6
    bcf TRISB,7
    
    bcf STATUS,RP0
    
   
    
    
inicio 
    MOVLW PORTA
    goto rotar   
  
   
rotar
    RLF	W,0
    MOVWF PORTB
    goto inicio

END    
    

