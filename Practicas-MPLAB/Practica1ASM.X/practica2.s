; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

; CONFIG1
  CONFIG  FOSC = INTRC_CLKOUT   ; Oscillator Selection bits (INTOSC oscillator: CLKOUT function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = ON             ; Watchdog Timer Enable bit (WDT enabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
  CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
  CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
  CONFIG  BOREN = OFF           ; Brown Out Reset Selection bits (BOR disabled)
  CONFIG  IESO = OFF            ; Internal External Switchover bit (Internal/External Switchover mode is disabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
  CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
  CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

// config statements should precede project file includes.
#include <xc.inc> 
  ;directiva de inclusión para un archivo de encabezado específico 
  ;del compilador que proporciona definiciones y configuraciones específicas 
  ;del microcontrolador PIC16F887.

; PIC16F877A Configuration Bit Settings

;
;   Section used for main code
    PSECT   MainCode,global,class=CODE,delta=2
;  Etiqueta MainCode, es donde se encuentra el código principal.
; Initialize the PIC hardware
;

MAIN:  ;Marca el punto de inicio del programa principal.
  ;serie de instrucciones BANKSEL que se utilizan para seleccionar 
  ;los bancos de registro adecuados antes de realizar operaciones 
  ;en puertos específicos. 
  ;Por ejemplo, BANKSEL TRISB selecciona el banco de registro correcto 
  ;para configurar el puerto B como salida
  ;Las instrucciones BCF y BSF se utilizan para borrar y establecer bits 
  ;en los puertos seleccionados. 
  ;Por ejemplo, BCF TRISB, 0 configura el primer bit del puerto B como salida.
   BANKSEL TRISA
   BCF TRISA,0 ;Set RA0 to output
   BCF TRISA,1 ;Set RA0 to output
   BCF TRISA,2 ;Set RA0 to output
   BCF TRISA,3 ;Set RA0 to output
   BCF TRISA,4 ;Set RA0 to output
   BCF TRISA,5 ;Set RA0 to output
   BCF TRISA,6 ;Set RA0 to output
   
   BANKSEL TRISD
   BSF TRISD,0 ;Set RA0 to input
   BSF TRISD,1 ;Set RA0 to input
   BSF TRISD,2 ;Set RA0 to input
   
   BANKSEL TRISB;Se definen LEDS como salida
   BCF TRISB, 0
   BCF TRISB, 1
   BCF TRISB, 2
   BCF TRISB, 3
   
    ;Después de configurar los puertos, el programa entra en un bucle principal 
    ;etiquetado como MainLoop. Este bucle realiza una secuencia de encendido y apagado 
    ;de un pin específico del puerto B, seguido de una llamada a la subrutina 
    ;DELAY para crear una pausa.
    MOVLW b'00000000' ;  Se define el valor del registro de trabajo con la literal 0
MainLoop:
    
    
    
  ;Inicio de sección botones y condiciones
    BTFSC PORTD, 0 ;Si se presiona el botón en RD0...
    INCF W; Incrementar el valor de 0x10 en 1
    
    BTFSC PORTD, 1; Si se presiona el botón en RD1...
    DECF W ; Decrementar el valor de 0x10 en 1
    
    BTFSC PORTD, 2 ; Si se presiona el botón en RD2...
    GOTO BORRAR	; Ir a subrutina BORRAR
    ;Se limpia el estado de los botones
    
    CLRF PORTD
    
    GOTO CALCULARLEDS
    
    GOTO	    MainLoop            ; Una vez que se completa el retraso, el programa vuelve al bucle principal y repite el proceso.
     
CALCULARLEDS:
   
    
    SUBWF 1,W
    GOTO ACTIVARPORTB0
    
    SUBWF 2,W
    GOTO ACTIVARPORTB1
    
    SUBWF 3,W
    GOTO ACTIVARPORTB2
    
    SUBWF 4,W
    GOTO ACTIVARPORTB3
  
    
ACTIVARPORTB0:
    CLRF PORTB
    BSF PORTB, 0
    
ACTIVARPORTB1:    
    CLRF PORTB
    BSF PORTB, 1
    return
    
ACTIVARPORTB2:
    CLRF PORTB
    BSF PORTB, 2
    return
ACTIVARPORTB3:
    CLRF PORTB
    BSF PORTB, 3
    return
    
    ;La subrutina DELAY implementa un retraso utilizando un bucle de decremento 
    ;que espera hasta que los registros de trabajo 0x10 y 0x11 se vuelvan cero.
BORRAR:
    CLRW ;Limpiar registro de trabajo
    CLRF CNT ;Limpiar el valor en 0x10
    return
 
DELAY: ;Start DELAY subroutine here
        movlw 10 ;Load initial value for the delay
        movwf 0x10 ;Copy the value from working reg to the file register 0x10
        movwf 0x11 ;Copy the value from working reg to the file register 0x11

DELAY_LOOP: ;Start delay loop
        decfsz 0x10, F ;Decrement the f register 0x10 and check if not zero
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP labe
        decfsz 0x11, F ;Else decrement the f register 0x11, check if it is not 0
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP label
        retlw 0 ;Else return from the subroutine


    END     MAIN
