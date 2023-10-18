
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
  CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (RB3/PGM pin has PGM function, low voltage programming enabled)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
  CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

// config statements should precede project file includes.
#include <xc.inc>

;   Section used for main code
PSECT   MainCode,global,class=CODE,delta=2
  ;Configurar pin 0 del PORTA como salida
   ;Configurar pin 0 del PORTB como salida
   CLRF PORTB
   BANKSEL PORTB
   BANKSEL TRISB
   BCF TRISB,0
   BCF TRISB,1 
   BCF TRISB,2
   BANKSEL PORTB
   ;Configurar pines 0 y 1 como entrada en el PORTC
   CLRF PORTC
   BANKSEL PORTC
   BANKSEL TRISC
   BSF TRISC,0
   BSF TRISC,1
   BSF TRISC,2
   BSF TRISC,3
   BANKSEL PORTC
  
   CLRF PORTC
   CLRF PORTB
   BSF PORTB,2
   CLRW ;Se limpia w o registro de trabajo
MainLoop:
    
    
    BTFSC PORTC,0	;Se revisa si PORTC,0 está presionado
	GOTO ALTERNARLED1; ;Si está presionado, ir a ENCENDERLED1
    BTFSC PORTC,1	;Se revisa si PORTC,1 está presionado
	GOTO ALTERNARLED2;Si está presionado, ir a ENCENDERLED2
    BTFSC PORTC,2	;Se revisa si PORTC,1 está presionado
	GOTO BORRARMEMORIA;Si está presionado, ir a ENCENDERLED2
    BTFSC PORTC,3	;Se revisa si PORTC,1 está presionado
	GOTO ACTIVARTODOS;Si está presionado, ir a ENCENDERLED2

GOTO MainLoop;Se reinicia iteración principal

BORRARMEMORIA:
    BCF PORTB,0
    BCF PORTB,1
    GOTO MainLoop
ACTIVARTODOS:
   
    BSF PORTB,0
    BSF PORTB,1
    
    GOTO MainLoop
;Funciones modulares
ALTERNARLED1:
  BTFSS PORTB,0;Si el LED no está encendido, encender
    GOTO ENCENDERLED1
  BTFSC PORTB,0;Si el LED está encendido, apagar
    GOTO APAGARLED1
ALTERNARLED2:
  BTFSS PORTB,1;Si el LED no está encendido, encender
    GOTO ENCENDERLED2
  BTFSC PORTB,1;Si el LED está encendido, apagar
    GOTO APAGARLED2
    
    
    ENCENDERLED1:
     BSF PORTB,0
    GOTO MainLoop
    
    APAGARLED1:
     BCF PORTB, 0;Cambiar a 1 PORTA,0 (Encender LED en PORTA,0)
    GOTO MainLoop
    
    ENCENDERLED2:
     BSF PORTB,1
    GOTO MainLoop
    
    APAGARLED2:
     BCF PORTB, 1;Cambiar a 1 PORTA,0 (Encender LED en PORTA,0)
    GOTO MainLoop


    
    
    
