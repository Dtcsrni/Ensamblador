; Configuración de los bits del PIC16F887

; CONFIG1
  CONFIG  FOSC = INTRC_NOCLKOUT   ; Oscillator Selection bits (INTOSC oscillator: CLKOUT function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
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

#include <xc.inc> 

PSECT   MainCode,global,class=CODE,delta=2

MAIN:  
  ; Configura los pines de los LEDs como salida
  bsf STATUS, 5 ; Cambia al banco de registros 1
  BCF TRISB,0
  BCF TRISB,1
  BCF TRISB,2
  BCF TRISB,7
  BANKSEL PORTB
  CLRF PORTB
  ; Configura los pines de los botones como entrada
  bsf STATUS, 5 ; Cambia al banco de registros 1
  BSF TRISC,0
  BSF TRISC,1
  BANKSEL PORTC
  CLRF PORTC
   
  ; Configura los LEDs como salida
  bsf STATUS, 5 ; Cambia al banco de registros 1
  BCF TRISA, 0
  BCF TRISA, 1
  BCF TRISA, 2
  BCF TRISA, 3
  BCF TRISA, 4
  BCF TRISA, 5
  BCF TRISA, 6
  BCF TRISA, 7
  BANKSEL PORTA
  CLRF PORTA
   
  ; Configura los LEDs de PORTE como salida
  bsf STATUS, 5 ; Cambia al banco de registros 1
  BCF TRISE, 0
  BCF TRISE, 1
  BCF TRISE, 2
  BANKSEL PORTE
  CLRF PORTE
   
; Configura el oscilador interno para funcionar a 8 MHz
  bsf STATUS, 5 ; Cambia al banco de registros 1
  movlw 0b01110000 ; Configura el IRCF para una frecuencia de 8 MHz
  movwf OSCCON
  bcf STATUS, 5 ; Cambia al banco de registros 0
  
   CREDITO EQU 0x20 ;Crear variable Credito y asignarla al registro de uso general 0x20
    CLRF CREDITO ;Limpio la variable NUMERO
    MOVLW 0 ;Se coloca la literal 4 en el registro de trabajo
    MOVWF CREDITO ;Mover el contenido del registro de trabajo W, a variable numero
    CLRW ;Limpiar registro de trabajo
    
    MODO EQU 0x21 ;Crear variable NUMERO y asignarla al registro de uso general 0x21
    CLRF MODO ;Limpio la variable NUMERO
    
    ; Define la variable MY_BYTE
    MY_BYTE EQU 0x20
; Define las variables

  ; Configura los registros para la comunicación serial
  bsf STATUS, 5 ; Cambia al banco de registros 1
  movlw 0b00100000 ; Configura el TXSTA para la transmisión serial
  movwf TXSTA
  movlw 0b10000000 ; Configura el RCSTA para la recepción serial
  movwf RCSTA
  bcf STATUS, 5 ; Cambia al banco de registros 0
  movlw 25 ; Configura el SPBRG para una velocidad de baudios de 9600
  movwf SPBRG
  bsf PIE1, 5 ; Habilita la interrupción de recepción

  bsf INTCON, 6 ; Habilita las interrupciones periféricas
; Habilita las interrupciones en cambio de estado para los pines de los botones
; Habilita las interrupciones en cambio de estado para los pines de los botones

  bsf INTCON, 7 ; Habilita las interrupciones globales
MainLoop:  
  CLRWDT
  CALL BLINK_LED      ; Parpadea el LED de estado    
 ; Espera a que se presione un botón
  ; La detección del botón se manejará en la rutina de servicio de interrupción (ISR)
; Rutina de servicio de interrupción (ISR)
       ; Aplicar la máscara al puerto A
   ; Rutina de servicio de interrupción (ISR) para los botones
BOTONES:
    BTFSS PORTC, 0 ;Si se presiona el botón en RD0...
    GOTO INCREMENTO
    BTFSC PORTD, 0 ;Si se presiona el botón en RD0...
    GOTO INCREMENTO2
    BTFSC PORTC, 1 ;Si se presiona el botón en RD0...
    GOTO DESPACHAR

  ; Limpia la bandera de interrupción en cambio de estado



          
  ;Inicio de sección botones y condiciones
   
       
  GOTO	    MainLoop            ; Una vez que se completa el retraso, el programa vuelve al bucle principal y repite el proceso.
  

; Rutina para enviar un byte utilizando EUSART
SEND_BYTE:
  MOVF   MY_BYTE, W  ; Mueve el byte que quieres enviar al registro W
  MOVWF  TXREG       ; Mueve el byte del registro W al registro de transmisión TXREG
SEND_BYTE_WAIT:
  btfss  PIR1, 4 ; Espera a que se establezca la bandera de interrupción de transmisión TXIF
  goto   SEND_BYTE_WAIT
  return
; Subrutina para parpadear un LED
BLINK_LED:
  BSF   PORTB,7       ; Enciende el LED de estado
  CALL DELAY          ; Espera
  BCF PORTB,7         ; Apaga el LED de estado
  CALL DELAY          ; Espera
  RETURN

; Rutina para recibir un byte utilizando EUSART
RECEIVE_BYTE:
RECEIVE_BYTE_WAIT:
  btfss PIR1, 5 ; Espera a que se establezca la bandera de interrupción de recepción RCIF
  goto RECEIVE_BYTE_WAIT
  movf RCREG, W ; Mueve el byte recibido del registro de recepción RCREG al registro W
  movwf MY_BYTE ; Mueve el byte del registro W a tu variable MY_BYTE
  return

DESPACHAR:
    CALL DELAY
    MOVLW 0     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar MODO de W y almacenar el resultado en W
    btfsc STATUS, 2    ; Saltar si el resultado es igual a cero (Z = 1)
    GOTO MainLoop
    
    MOVLW 1     ; Cargar el valor 1 en el registro W
    SUBWF MODO, W    ; Restar MODO de W y almacenar el resultado en W
    btfsc STATUS, 2    ; Saltar si el resultado es igual a cero (Z = 1)
    GOTO CHECK_CREDITO1
    
    MOVLW 2     ; Cargar el valor 2 en el registro W
    SUBWF MODO, W    ; Restar MODO de W y almacenar el resultado en W
    btfsc STATUS, 2    ; Saltar si el resultado es igual a cero (Z = 1)
    GOTO CHECK_CREDITO5
    
    MOVLW 3     ; Cargar el valor 3 en el registro W
    SUBWF MODO, W    ; Restar MODO de W y almacenar el resultado en W
    btfsc STATUS, 2    ; Saltar si el resultado es igual a cero (Z = 1)
    GOTO CHECK_CREDITO10
    
CHECK_CREDITO1:
    MOVLW 1     ; Cargar el valor 1 en el registro W
    SUBWF CREDITO, W    ; Restar CREDITO de W y almacenar el resultado en W
    btfsc STATUS, 2    ; Saltar si el resultado es igual a cero (Z = 1)
    GOTO DESPACHAR1
    GOTO MainLoop
    
CHECK_CREDITO5:
    MOVLW 5     ; Cargar el valor 5 en el registro W
    SUBWF CREDITO, W    ; Restar CREDITO de W y almacenar el resultado en W
    btfsc STATUS, 2    ; Saltar si el resultado es igual a cero (Z = 1)
    GOTO DESPACHAR2
    GOTO MainLoop
    
CHECK_CREDITO10:
    MOVLW 10    ; Cargar el valor 10 en el registro W
    SUBWF CREDITO, W    ; Restar CREDITO de W y almacenar el resultado en W
    btfsc STATUS, 2    ; Saltar si el resultado es igual a cero (Z = 1)
    GOTO DESPACHAR2
    GOTO MainLoop

    
    
    
DESPACHAR1:
       CALL DELAY
 MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
   MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto   
 
   MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
 MOVLW   0b00000001  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
 CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
 
 MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
 
  MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
   MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto   
 
 CLRF CREDITO
 CLRF MODO
 CLRF PORTA
 CLRF PORTB
 CLRF PORTE
  CALL DELAY
 GOTO BOTONES
 
 DESPACHAR2:   
       CALL DELAY
 MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
  CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
  CALL DELAY
   MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto   
 CALL DELAY
  CALL DELAY
 MOVLW   0b00011111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
  CALL DELAY
   CALL DELAY
 MOVLW   0b00001111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
  CALL DELAY
   CALL DELAY
 MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
  CALL DELAY
   CALL DELAY
 MOVLW   0b00000011  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
 CALL DELAY
  CALL DELAY
 MOVLW   0b00000001  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
 CALL DELAY
  CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
 CALL DELAY
  CALL DELAY
  MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
  CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
  CALL DELAY
   MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto   
 CALL DELAY
 CLRF CREDITO
 CLRF MODO
 CLRF PORTA
 CLRF PORTB
 CLRF PORTE
GOTO BOTONES
    
INCREMENTO:
    CALL DELAY
    ; Comparar si NUMERO es igual a 0
    MOVLW 11     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSS STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    INCF CREDITO ;Si los valores no son iguales, entonces no es 4, y debe incrementar
    MOVF CREDITO, 0 ;Mover el contenido de la variable NUMERO a W, para monitoreo
     CALL DELAY
   ; Llamar a la subrutina si NUMERO es igual a 0
    GOTO CALCULARLEDS
INCREMENTO2:
    CALL DELAY
    ; Comparar si NUMERO es igual a 0
    MOVLW 4     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSS STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    INCF MODO ;Si los valores no son iguales, entonces no es 4, y debe incrementar
    MOVF MODO, 0 ;Mover el contenido de la variable NUMERO a W, para monitoreo
     CALL DELAY
   ; Llamar a la subrutina si NUMERO es igual a 0
    GOTO CALCULARLEDSMODO    
    
DECREMENTO:
    CALL DELAY
    ; Comparar si NUMERO es igual a 0
    MOVLW 0     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSS STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    DECF CREDITO
    MOVF CREDITO, 0
     CALL DELAY
     GOTO CALCULARLEDS
   ; Llamar a la subrutina si NUMERO es igual a 0

CALCULARLEDSMODO:
    CALL DELAY
    ; Comparar si NUMERO es igual a 0
    MOVLW 0     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLEDMODO0
    
     MOVLW 1     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLEDMODO1
    
     MOVLW 2     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLEDMODO2
    
    MOVLW 3     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLEDMODO3
    
    MOVLW 4     ; Cargar el valor 0 en el registro W
     SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLEDMODO0

    
       GOTO MainLoop
    
CALCULARLEDS:
    CALL DELAY
    ; Comparar si NUMERO es igual a 0
    MOVLW 0     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED0
    
   
    
     ; Comparar si NUMERO es igual a 0
    MOVLW 1     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED1
  
   
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 2     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED2
   
   
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 3     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED3
    
    
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 4     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED4
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 5     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED5
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 6     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED6
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 7     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED7
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 8     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED8
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 9     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED9
    
     ; Comparar si NUMERO es igual a 0
    MOVLW 10     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED10
    
         ; Comparar si NUMERO es igual a 0
    MOVLW 11     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED11
    
   
    
    
    GOTO MainLoop

ENCENDERLEDMODO0:
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto 
 CLRF MODO 
GOTO BOTONES
ENCENDERLEDMODO1:
 MOVLW   0b00000001  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto A
GOTO BOTONES
 
ENCENDERLEDMODO2:
 MOVLW   0b00000010  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto A
GOTO BOTONES
ENCENDERLEDMODO3:
 MOVLW   0b00000100  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto A
GOTO BOTONES
 
ENCENDERLED0:
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop   
    
ENCENDERLED1:
 MOVLW   0b00000001  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop   
    
ENCENDERLED2:
 MOVLW   0b00000011  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop   
    
ENCENDERLED3:
 MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop   

ENCENDERLED4:
 MOVLW   0b00001111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop   
    
 ENCENDERLED5:
 MOVLW   0b00011111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop  
 
  ENCENDERLED6:
 MOVLW   0b00111111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop  
 
  ENCENDERLED7:
 MOVLW   0b01111111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop  
 
  ENCENDERLED8:
 MOVLW   0b11111111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto A
 GOTO MainLoop  
 
  ENCENDERLED9:
 MOVLW   0b00000001  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTB        ; Aplicar la máscara al puerto A
 GOTO MainLoop  
 
  ENCENDERLED10:
 MOVLW   0b00000011  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTB        ; Aplicar la máscara al puerto A
 GOTO MainLoop  
 
   ENCENDERLED11:
 CLRF CREDITO
 CLRF PORTA
 CLRF PORTB
 CALL DELAY
 GOTO MainLoop  
    

   
 
DELAY: ;Start DELAY subroutine here
        movlw 500 ;Load initial value for the delay
        movwf 0x10 ;Copy the value from working reg to the file register 0x10
        movwf 0x11 ;Copy the value from working reg to the file register 0x11

DELAY_LOOP: ;Start delay loop
        decfsz 0x10, F ;Decrement the f register 0x10 and check if not zero
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP labe
        decfsz 0x11, F ;Else decrement the f register 0x11, check if it is not 0
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP label
        retlw 0 ;Else return from the subroutine
	


    END     MAIN
