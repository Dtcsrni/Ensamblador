; Configuración de bits de configuración del PIC16F887

    
; Configuraciones de líneas de origen de código Assembly

; CONFIG1
  CONFIG  FOSC = INTRC_CLKOUT   ; Bits de selección del oscilador (oscilador INTOSC: función CLKOUT en pin RA6/OSC2/CLKOUT, función I/O en pin RA7/OSC1/CLKIN)
  CONFIG  WDTE = ON             ; Bit de habilitación del Watchdog Timer (WDT habilitado)
  CONFIG  PWRTE = OFF           ; Bit de habilitación del Power-up Timer (PWRT deshabilitado)
  CONFIG  MCLRE = ON            ; Bit de selección de función del pin RE3/MCLR (función del pin RE3/MCLR es MCLR)
  CONFIG  CP = OFF              ; Bit de protección de código (protección de código de memoria de programa deshabilitada)
  CONFIG  CPD = OFF             ; Bit de protección de código de datos (protección de código de memoria de datos deshabilitada)
  CONFIG  BOREN = OFF           ; Bits de selección de reinicio por falta de alimentación (BOR deshabilitado)
  CONFIG  IESO = OFF            ; Bit de conmutación interna/externa (modo de conmutación interna/externa deshabilitado)
  CONFIG  FCMEN = OFF           ; Bit de habilitación del Monitor de Reloj Seguro (Fail-Safe Clock Monitor deshabilitado)
  CONFIG  LVP = OFF             ; Bit de habilitación de programación a baja tensión (pin RB3 tiene I/O digital, se debe usar HV en MCLR para programación)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Bit de selección de reinicio por falta de alimentación (Brown-out Reset configurado a 4.0V)
  CONFIG  WRT = OFF             ; Bits de habilitación de escritura de memoria de programa Flash (protección de escritura desactivada)

; Las declaraciones de configuración deben preceder a las inclusiones de archivos del proyecto.
#include <xc.inc> ; Inclusión de la librería de compilador

; Sección utilizada para el código principal
PSECT MainCode, global, class = CODE, delta = 2

; Inicializar el hardware del PIC

MAIN:  ; Etiqueta que marca el punto de inicio del programa principal

MAIN:  ;Marca el punto de inicio del programa principal.
  ;serie de instrucciones BANKSEL que se utilizan para seleccionar 
  ;los bancos de registro adecuados antes de realizar operaciones 
  ;en puertos espec�ficos. 
  ;Por ejemplo, BANKSEL TRISB selecciona el banco de registro correcto 
  ;para configurar el puerto B como salida
  ;Las instrucciones BCF y BSF se utilizan para borrar y establecer bits 
  ;en los puertos seleccionados. 
  ;Por ejemplo, BCF TRISB, 0 configura el primer bit del puerto B como salida.
    BANKSEL TRISB
    BCF	TRISB,0     
    BANKSEL PORTB
    
    BANKSEL TRISA
    BCF	TRISA,0     
    BANKSEL PORTA
    
    BANKSEL TRISC
    BSF	TRISC,0     
    BANKSEL PORTC
    ;Despu�s de configurar los puertos, el programa entra en un bucle principal 
    ;etiquetado como MainLoop. Este bucle realiza una secuencia de encendido y apagado 
    ;de un pin espec�fico del puerto B, seguido de una llamada a la subrutina 
    ;DELAY para crear una pausa.
MainLoop:
    BTFSS		PORTC,0
    BCF			PORTA,0
    
    BCF			PORTB,0
	CALL		DELAY
    BSF			PORTB,0 
	CALL		DELAY
	
    BTFSC PORTC,0
    BSF	  PORTA,0
    
    GOTO	    MainLoop            ; Una vez que se completa el retraso, el programa vuelve al bucle principal y repite el proceso.
     
    ;La subrutina DELAY implementa un retraso utilizando un bucle de decremento 
    ;que espera hasta que los registros de trabajo 0x10 y 0x11 se vuelvan cero.
 
DELAY: ;Start DELAY subroutine here
        movlw 10 ;Load initial value for the delay
        movwf 0x10 ;Copy the value from working reg to the file register 0x10
        movwf 0x11 ;Copy the value from working reg to the file register 0x11

CICLO_ESPERA: ; Inicio del bucle de retardo
  decfsz 0x10, F ; Decrementar el valor del registro 0x10 y verificar si no es cero
  goto CICLO_ESPERA ; Si no es cero, volver al bucle de retardo
  decfsz 0x11, F ; Si es cero, decrementar el valor del registro 0x11 y verificar si no es cero
  goto CICLO_ESPERA ; Si no es cero, volver al bucle de retardo
  retlw 0 ; Retornar de la subrutina

END MAIN ; Finalizar la ejecución del programa
