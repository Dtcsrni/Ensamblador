
; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

; CONFIG1
  CONFIG  FOSC = INTRC_CLKOUT   ; Oscillator Selection bits (INTOSC oscillator: CLKOUT function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = ON             ; Watchdog Timer Enable bit (WDT enabled)
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
   BANKSEL PORTA ;Seleccionar banco de memoria puerto A
   CLRF PORTA	;Limpiar puerto A
   BANKSEL TRISA ;Selecciono banco de memoria de pines del puero A
   BCF TRISA,0 ;Definir el pin 0 del puerto A como salida (0)
   ;Configurar pin 0 del PORTB como salida
   BANKSEL PORTB
   CLRF PORTB
   BANKSEL TRISB
   BCF TRISB,0
   ;Configurar pines 0 y 1 como entrada en el PORTC
   BANKSEL PORTC
   CLRF PORTC
   BANKSEL TRISC
   BSF TRISC,0
   BSF TRISC,1
  

MainLoop:
    
   CLRW; ;Limpiar registro de trabajo
   
    BTFSC PORTC, 0	;Se revisa si PORTC,0 está presionado
	GOTO ENCENDERLED1; ;Si está presionado, ir a ENCENDERLED1
    BTFSC PORTC, 1	;Se revisa si PORTC,1 está presionado
	GOTO ENCENDERLED2;Si está presionado, ir a ENCENDERLED2
    BTFSS PORTC,0
	GOTO APAGARLED1;
    BTFSS PORTC,1
	GOTO APAGARLED2;

GOTO MainLoop;Se reinicia iteración principal
	
;Funciones modulares
ENCENDERLED1:
    BSF PORTA, 0;Cambiar a 1 PORTA,0 (Encender LED en PORTA,0)
    
    GOTO MainLoop;Regresar a iteración principal
ENCENDERLED2:
    BSF PORTB,0;
    GOTO MainLoop;
    
APAGARLED1:
    BCF PORTA,0;Cambiar a 0 PORTA,0 (Apagar LED en PORTA,0)
    GOTO MainLoop;Regresar a iteración principal
    
APAGARLED2:
    BCF PORTB,0;
    GOTO MainLoop;
    
    
    
    
