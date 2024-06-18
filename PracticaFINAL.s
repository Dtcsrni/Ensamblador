; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

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
   BANKSEL TRISB
   BCF TRISB,0 ;Set RA0 to output
   BCF TRISB,1 ;Set RA0 to output
   BCF TRISB,2 ;Set RA0 to output
   BCF TRISB,7 ;Set RA0 to output
   BANKSEL PORTB
  
   
   BANKSEL TRISC
   BSF TRISC,0 ;Set RA0 to input
   BSF TRISC,1 ;Set RA0 to input
   BANKSEL PORTC
   CLRF PORTC
   
   BANKSEL TRISA;Se definen LEDS como salida
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
   
   BANKSEL TRISE;Se definen LEDS de PORTE
   BCF TRISE, 0 //Como salida
   BCF TRISE, 1 //Como salida
   BCF TRISE, 2 //Como salida
   BANKSEL PORTE
   CLRF PORTE
   
   
    ;Después de configurar los puertos, el programa entra en un bucle principal 
    ;etiquetado como MainLoop. Este bucle realiza una secuencia de encendido y apagado 
    ;de un pin específico del puerto B, seguido de una llamada a la subrutina 
    ;DELAY para crear una pausa.
    CREDITO EQU 0x20 ;Crear variable Credito y asignarla al registro de uso general 0x20
    CLRF CREDITO ;Limpio la variable NUMERO
    MOVLW 0 ;Se coloca la literal 4 en el registro de trabajo
    MOVWF CREDITO ;Mover el contenido del registro de trabajo W, a variable numero
    CLRW ;Limpiar registro de trabajo
    
    MODO EQU 0x21 ;Crear variable NUMERO y asignarla al registro de uso general 0x21
    CLRF MODO ;Limpio la variable NUMERO
    MOVLW 0 ;Se coloca la literal 4 en el registro de trabajo
    MOVWF MODO ;Mover el contenido del registro de trabajo W, a variable numero
    CLRW ;Limpiar registro de trabajo
    

    MOVLW   0b00000000  ; Limpiar puertos
    MOVWF   PORTA  
    MOVWF   PORTB
    MOVWF   PORTE
    
   MOVLW  0b00001000;Configurar el reloj para funcionar a 1 MHZ
   MOVWF OSCCON
MainLoop:  
    CLRWDT
  
    BSF   PORTB,7       ; Led de Estado
    CALL DELAY
    BCF PORTB,7
    CALL DELAY
    BSF PORTB,7
    
          ; Aplicar la máscara al puerto A
    SECCION2:
    BTFSS PORTC, 0 ;Si se presiona el botón en RD0...
    GOTO INCREMENTO
    BTFSC PORTD, 0 ;Si se presiona el botón en RD0...
    GOTO INCREMENTO2
    BTFSC PORTC, 1 ;Si se presiona el botón en RD0...
    GOTO DESPACHAR
          
  ;Inicio de sección botones y condiciones
   
       
    GOTO	    MainLoop            ; Una vez que se completa el retraso, el programa vuelve al bucle principal y repite el proceso.

DESPACHAR:
    MOVLW 0     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO MainLoop
    
    MOVLW 1     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO COMPARAR
    
    
    MOVLW 2     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO COMPARAR
    
    MOVLW 3     ; Cargar el valor 0 en el registro W
    SUBWF MODO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO COMPARAR
    
COMPARAR:
    MOVWF CREDITO    ; Cargar el valor 0 en el registro W
    SUBWF 1, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO DESPACHAR1
    
    MOVWF CREDITO    ; Cargar el valor 0 en el registro W
    SUBWF 5, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO DESPACHAR2
    
    MOVWF CREDITO    ; Cargar el valor 0 en el registro W
    SUBWF 10, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO DESPACHAR2
    
    
    
DESPACHAR1:
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
 GOTO SECCION2
 
 DESPACHAR2:   
 MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
   MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto   
 CALL DELAY
 MOVLW   0b00011111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
  CALL DELAY
 MOVLW   0b00001111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
  CALL DELAY
 MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
  CALL DELAY
 MOVLW   0b00000011  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
 CALL DELAY
 MOVLW   0b00000001  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
 CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTA        ; Aplicar la máscara al puerto 
 CALL DELAY
  MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto    
 CALL DELAY
   MOVLW   0b00000111  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto   
 CALL DELAY
 CLRF CREDITO
 CLRF MODO
 CLRF PORTA
 CLRF PORTB
 CLRF PORTE
 GOTO SECCION2
    
INCREMENTO:
    ; Comparar si NUMERO es igual a 0
    MOVLW 10     ; Cargar el valor 0 en el registro W
    SUBWF CREDITO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSS STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    INCF CREDITO ;Si los valores no son iguales, entonces no es 4, y debe incrementar
    MOVF CREDITO, 0 ;Mover el contenido de la variable NUMERO a W, para monitoreo
     CALL DELAY
   ; Llamar a la subrutina si NUMERO es igual a 0
    GOTO CALCULARLEDS
INCREMENTO2:
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
    
   
    
    
    GOTO MainLoop

ENCENDERLEDMODO0:
 MOVLW   0b00000000  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto 
 CLRF MODO 
 GOTO SECCION2 
ENCENDERLEDMODO1:
 MOVLW   0b00000001  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto A
 GOTO SECCION2  
 
ENCENDERLEDMODO2:
 MOVLW   0b00000010  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto A
 GOTO SECCION2  
ENCENDERLEDMODO3:
 MOVLW   0b00000100  ; Máscara para activar los bits 0, 1 y 2
 MOVWF   PORTE        ; Aplicar la máscara al puerto A
 GOTO SECCION2  
 
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
 CLRF CREDITO
 CLRF PORTA
 CALL DELAY
 GOTO MainLoop  
    

   
 
DELAY: ;Start DELAY subroutine here
        movlw 150 ;Load initial value for the delay
        movwf 0x10 ;Copy the value from working reg to the file register 0x10
        movwf 0x11 ;Copy the value from working reg to the file register 0x11

DELAY_LOOP: ;Start delay loop
        decfsz 0x10, F ;Decrement the f register 0x10 and check if not zero
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP labe
        decfsz 0x11, F ;Else decrement the f register 0x11, check if it is not 0
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP label
        retlw 0 ;Else return from the subroutine


    END     MAIN
