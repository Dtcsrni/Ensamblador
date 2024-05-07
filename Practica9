
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

    BANKSEL TRISA   ;Seleccionar el banco de memoria de programa TRISB
    BCF	TRISA,0     ;Configurar como salida A0
    BANKSEL PORTA   ;Seleccionar el banco de memoria PORTB
    
    BANKSEL TRISB
    BCF	TRISB,0   ;Configurar como salida A1
    BANKSEL PORTB
    
    BANKSEL TRISC
    BSF	TRISC,0     ;Configurar como Entrada C0
    BANKSEL PORTC
    
    BANKSEL TRISD
    BSF	TRISD,0     ;Configurar como entrada C1
    BANKSEL PORTD
    ;Después de configurar los puertos, el programa entra en un bucle principal 
    ;etiquetado como MainLoop. Este bucle realiza una secuencia de encendido y apagado 
    ;de un pin específico del puerto B, seguido de una llamada a la subrutina 
    ;DELAY para crear una pausa.
    NUMERO EQU 0x12 ;Crear variable NUMERO y asignarla al registro de uso general 0x12
 
MainLoop:
 
    
    BTFSC PORTC,0  ;Revisar si C0 es 1 (Si esta presionado)
    GOTO ENCENDERLED1
    SECCION2:
    BTFSC PORTD,0  ;Revisar si C0 es 1 (Si esta presionado)
    GOTO ENCENDERLED2
    SECCION3:
    CALL DELAY
    

    GOTO APAGARLEDS
        
    
   
    
    GOTO	    MainLoop            ; Una vez que se completa el retraso, el programa vuelve al bucle principal y repite el proceso.
ENCENDERLED1:
    BSF	  PORTA,0  ;En caso de que si, enviar 1 logico a A0
    INCF 
    GOTO SECCION2
ENCENDERLED2:
    BSF	  PORTB,0  ;En caso de que si, enviar 1 logico a A0
    INCF NUMERO2
   GOTO SECCION3
APAGARLEDS:
    BCF		    PORTA,0 ;Limpiar C0
    BCF		    PORTB,0 ;Limpiar C1
   GOTO LIMPIARPUERTOS
LIMPIARPUERTOS:
    BCF PORTC,0
    BCF PORTD,0
  GOTO MainLoop
    
    ;La subrutina DELAY implementa un retraso utilizando un bucle de decremento 
    ;que espera hasta que los registros de trabajo 0x10 y 0x11 se vuelvan cero.
 
DELAY: ;Start DELAY subroutine here
        movlw 100 ;Load initial value for the delay
        movwf 0x10 ;Copy the value from working reg to the file register 0x10
        movwf 0x11 ;Copy the value from working reg to the file register 0x11

DELAY_LOOP: ;Start delay loop
        decfsz 0x10, F ;Decrement the f register 0x10 and check if not zero
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP labe
        decfsz 0x11, F ;Else decrement the f register 0x11, check if it is not 0
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP label
        retlw 0 ;Else return from the subroutine


    END     MAIN
