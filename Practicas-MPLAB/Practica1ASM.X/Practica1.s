
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


; Sección utilizada para el código principal
PSECT MainCode, global, class = CODE, delta = 2

; Inicializar el hardware del PIC

MAIN:  ; Etiqueta que marca el punto de inicio del programa principal

  ; Configuración de puertos como entradas
  BANKSEL TRISB ; Seleccionar el banco de registros para el puerto B
  BCF TRISB, 0 ; Configurar el primer bit del puerto B como salida

  BANKSEL TRISA
  BCF	TRISA, 0 ; Configurar el segundo bit del puerto A como salida

  BANKSEL TRISC
  BSF	TRISC, 0 ; Configurar el segundo bit del puerto A como entrada
  BANKSEL TRISC
  BSF	TRISC, 1 ; Configurar el segundo bit del puerto A como entrada
CicloPrincipal: ; Etiqueta que marca el inicio del ciclo principal
       CALL		ESPERA
    BCF			PORTB,0
	CALL		ESPERA
    BSF			PORTB,0 
	
    
    BTFSC PORTC,0
	BCF   PORTA,0
    
    BTFSC PORTC,0
	BSF   PORTA,0
	
    

  

  GOTO	CicloPrincipal ; Volver al ciclo principal



ESPERA: ; Subrutina ESPERA para generar un retardo
  movlw 10 ; Cargar el literal 10 en el registro de trabajo (W)
  movwf 0x10 ; Mover el valor del registro de trabajo a la dirección de memoria 0x10
  movwf 0x11 ; Mover el valor del registro de trabajo a la dirección de memoria 0x11

CICLO_ESPERA: ; Inicio del bucle de retardo
  decfsz 0x10, F ; Decrementar el valor del registro 0x10 y verificar si no es cero
  goto CICLO_ESPERA ; Si no es cero, volver al bucle de retardo
  decfsz 0x11, F ; Si es cero, decrementar el valor del registro 0x11 y verificar si no es cero
  goto CICLO_ESPERA ; Si no es cero, volver al bucle de retardo
  retlw 0 ; Retornar de la subrutina

END MAIN ; Finalizar la ejecución del programa