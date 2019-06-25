; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

#include "p16f887.inc"

; CONFIG1
; __config 0xFFD5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF


    LIST p=16f887
    numero EQU 0
    numero2 EQU 1
    ORG 0
		    ;inicio de instrucciones 
    
    bsf STATUS,RP0
    
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
    
    bcf STATUS,RP0
    
    
    
inicio 
    MOVLW PORTA
    
    
    
    bcf  PORTB,LED
    goto inicio


END    
    


