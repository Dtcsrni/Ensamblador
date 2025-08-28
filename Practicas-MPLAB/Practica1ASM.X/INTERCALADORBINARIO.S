
;Practica 1 - Hola Mundo con PIC16F887

; PIC16F887 Configuration Bit Settings
  PROCESSOR 16F887
; Assembly source line config statements

; CONFIG1
  CONFIG  FOSC = INTRC_NOCLKOUT ; Oscillator Selection bits (INTOSCIO oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
  CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
  CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
  CONFIG  BOREN = ON            ; Brown Out Reset Selection bits (BOR enabled)
  CONFIG  IESO = ON             ; Internal External Switchover bit (Internal/External Switchover mode is enabled)
  CONFIG  FCMEN = ON            ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is enabled)
  CONFIG  LVP = ON              ; Low Voltage Programming Enable bit (RB3/PGM pin has PGM function, low voltage programming enabled)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
  CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

// config statements should precede project file includes.
#include <xc.inc>
  

;Vectores
; 0x0000 reset - Saltamos a INIT
; 0x0004 int -Definir interrupciones como deshabilitadas
PSECT resetVec, class=CODE, delta=2
ORG 0x0000
GOTO INIT
  
PSECT intVect, class=CODE, delta=2
ORG 0x0004
RETFIE
  
;Variables
PSECT udata_bank0, space=1
 RETARDO0: DS 1 ;Contador externo del retardo
 RETARDO1: DS 1 ;Contador interno del retardo

BANKSEL OSCCON
MOVLW 0b01110000
MHz, SCS=00
MOVWF OSCCON
    
BANKSEL ANSEL ;(ansel Y ANSELH = 0)
CLRF ANSEL
CLRF ANSELH
    
BANKSEL TRISB; 0 = SALIDA DE PUERTOS B
CLRF TRISB
BANKSEL PORTB
CLRF PORTB
  
    
;-----LOOP PRINCIPAL------
MAIN:
    ;ENCENDER LED EN RB0
    BSF PORTB, 0
    CALL DELAY500MS
    
    ;APAGAR LED EN RB0
    BCF PORTB, 0
    CALL DELAY500MS
    
    GOTO MAIN
    
;DELAY500MS APROXIMADAMENTE A FOSC=8MHZ EQUIVALE A 0-5US POR INSTRUCCIÓN
;BUCLE DOBLE 250X250 CON SOBRECARGA APROX 500US
    
DELAY500MS:
    MOVLW 250 ;MOVER A W = 250
    MOVWF RETARDO0
OUTER: 
    MOVLW 250
    MOVWF RETARDO1
INNER:
    NOP
    DECFSZ RETARDO1, F
    GOTO INNER
    DECFSZ RETARDO0, F
    GOTO OUTER
    RETURN
    
    END

    
  



