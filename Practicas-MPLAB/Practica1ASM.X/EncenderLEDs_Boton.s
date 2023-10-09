
; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

; CONFIG1
  CONFIG  FOSC = INTRC_CLKOUT   ; Oscillator Selection bits (INTOSC oscillator: CLKOUT function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF             ; Watchdog Timer Enable bit (WDT enabled)
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

;   Section used for main code
PSECT   MainCode,global,class=CODE,delta=2
  ;Configurar pin 0 del PORTA como salida
    CLRF PORTA	;Limpiar puerto A
   BANKSEL PORTA ;Seleccionar banco de memoria puerto A
   BANKSEL TRISA ;Selecciono banco de memoria de pines del puero A
   BCF TRISA,0 ;Definir el pin 0 del puerto A como salida (0)
   BANKSEL PORTA
   ;Configurar pin 0 del PORTB como salida
    CLRF PORTB
   BANKSEL PORTB
   BANKSEL TRISB
   BCF TRISB,0
   BANKSEL PORTB
   ;Configurar pines 0 y 1 como entrada en el PORTC
   BANKSEL PORTC
   CLRF PORTC
   BANKSEL TRISC
   BCF TRISC,0
   BCF TRISC,1
   BANKSEL PORTC
  
   CLRF PORTC
   CLRF PORTB
   CLRF PORTA
   ;BSF PORTC,1
   BSF PORTC,0
   CLRW 
MainLoop:
  
   
    BTFSC PORTC, 0	;Se revisa si PORTC,0 está presionado
	GOTO ALTERNARLED1; ;Si está presionado, ir a ENCENDERLED1
    BTFSC PORTC,1	;Se revisa si PORTC,1 está presionado
	GOTO ALTERNARLED2;Si está presionado, ir a ENCENDERLED2
    

GOTO MainLoop;Se reinicia iteración principal
	
;Funciones modulares
ALTERNARLED1:
  BTFSS PORTA,0;Si el LED no está encendido, encender
  GOTO ENCENDERLED2
  BTFSC PORTA,0;Si el LED está encendido, apagar
  GOTO APAGARLED2
ALTERNARLED2:
    BTFSS PORTB,0;Si el LED no está encendido, encender
   GOTO ENCENDERLED1
    BTFSC PORTB,0;Si el LED está encendido, apagar
    GOTO APAGARLED1
   
    
   
    
    
    GOTO MainLoop;
    
    ENCENDERLED1:
     BSF PORTB,0
    GOTO MainLoop
    
    APAGARLED1:
     BCF PORTB, 0;Cambiar a 1 PORTA,0 (Encender LED en PORTA,0)
    GOTO MainLoop
    
    ENCENDERLED2:
     BSF PORTA,0
    GOTO MainLoop
    
    APAGARLED2:
     BCF PORTA, 0;Cambiar a 1 PORTA,0 (Encender LED en PORTA,0)
    GOTO MainLoop

 DELAY: ;Start DELAY subroutine here
        movlw 400 ;Load initial value for the delay
        movwf 0x10 ;Copy the value from working reg to the file register 0x10
        movwf 0x11 ;Copy the value from working reg to the file register 0x11

DELAY_LOOP: ;Start delay loop
        decfsz 0x10, F ;Decrement the f register 0x10 and check if not zero
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP labe
        decfsz 0x11, F ;Else decrement the f register 0x11, check if it is not 0
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP label
        retlw 0 ;Else return from the subroutine

    
    
    
