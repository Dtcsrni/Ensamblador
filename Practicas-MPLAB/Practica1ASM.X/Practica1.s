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

  ; Configuración de puertos como entradas
  BANKSEL TRISB ; Seleccionar el banco de registros para el puerto B
  BSF	TRISB, 0 ; Configurar el primer bit del puerto B como entrada

  BANKSEL TRISA
  BSF	TRISA, 1 ; Configurar el segundo bit del puerto A como entrada

CicloPrincipal: ; Etiqueta que marca el inicio del ciclo principal

  ; Apagar, esperar y encender LED 1
  BCF	PORTB, 0 ; Colocar en 0 el primer bit del puerto B (Apagar LED)
  CALL	ESPERA ; Llamar a la subrutina ESPERA

  BSF	PORTB, 0 ; Colocar en 1 el primer bit del puerto B (Encender LED)
  CALL	ESPERA ; Llamar a la subrutina ESPERA

  BTFSS	PORTA, 1 ; Saltar a la etiqueta REVISARBTN1 si el segundo bit del puerto A es 0 lógico
  GOTO	REVISARBTN1

  BTFSC	PORTA, 1 ; Saltar a la etiqueta REVISARBTN2 si el segundo bit del puerto A es 1 lógico
  GOTO	REVISARBTN2

  GOTO	CicloPrincipal ; Volver al ciclo principal

REVISARBTN1:
  ; Revisar si el botón 1 está presionado
  BTFSC PORTC, 0 ; Revisar el primer bit del puerto C
  BSF   PORTA, 1 ; Si el bit es 0 lógico, no realizar la instrucción BSF

REVISARBTN2:
  ; Revisar si el botón 2 está presionado
  BTFSC PORTC, 1 ; Revisar el segundo bit del puerto C
  BCF   PORTA, 1 ; Si el bit es 0 lógico, no realizar la instrucción BCF

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
