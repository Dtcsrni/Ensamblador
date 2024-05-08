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
   BANKSEL TRISB
   BCF TRISB,0 ;Set RA0 to output
   BCF TRISB,1 ;Set RA0 to output
   BCF TRISB,2 ;Set RA0 to output
   BCF TRISB,3 ;Set RA0 to output
   BCF TRISB,4 ;Set RA0 to output
   BCF TRISB,5 ;Set RA0 to output
   BCF TRISB,6 ;Set RA0 to output
   BANKSEL PORTB
  
   
   BANKSEL TRISC
   BSF TRISC,0 ;Set RA0 to input
   BANKSEL PORTC
   CLRF PORTC
   
   BANKSEL TRISA;Se definen LEDS como salida
   BCF TRISA, 0
   BCF TRISA, 1
   BCF TRISA, 2
   BCF TRISA, 3
   BCF TRISA, 4
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
    NUMERO EQU 0x12 ;Crear variable NUMERO y asignarla al registro de uso general 0x12
    CLRF NUMERO ;Limpio la variable NUMERO
    MOVLW 0 ;Se coloca la literal 4 en el registro de trabajo
    MOVWF NUMERO ;Mover el contenido del registro de trabajo W, a variable numero
    CLRW ;Limpiar registro de trabajo
    

    
    
MainLoop:  
          
  ;Inicio de sección botones y condiciones
    BTFSS PORTC, 0 ;Si se presiona el botón en RD0...
    GOTO INCREMENTO
    


    CLRWDT
    GOTO	    MainLoop            ; Una vez que se completa el retraso, el programa vuelve al bucle principal y repite el proceso.

    
INCREMENTO:
    ; Comparar si NUMERO es igual a 0
    MOVLW 10     ; Cargar el valor 0 en el registro W
    SUBWF NUMERO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSS STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    INCF NUMERO ;Si los valores no son iguales, entonces no es 4, y debe incrementar
    MOVF NUMERO, 0 ;Mover el contenido de la variable NUMERO a W, para monitoreo
     CALL DELAY
   ; Llamar a la subrutina si NUMERO es igual a 0
    GOTO CALCULARLEDS
DECREMENTO:
    ; Comparar si NUMERO es igual a 0
    MOVLW 0     ; Cargar el valor 0 en el registro W
    SUBWF NUMERO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSS STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    DECF NUMERO
    MOVF NUMERO, 0
     CALL DELAY
     GOTO CALCULARLEDS
   ; Llamar a la subrutina si NUMERO es igual a 0
    
    
CALCULARLEDS:
    ; Comparar si NUMERO es igual a 0
    MOVLW 0     ; Cargar el valor 0 en el registro W
    SUBWF NUMERO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED0
    
   
    
     ; Comparar si NUMERO es igual a 0
    MOVLW 1     ; Cargar el valor 0 en el registro W
    SUBWF NUMERO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED1
  
   
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 2     ; Cargar el valor 0 en el registro W
    SUBWF NUMERO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED2
   
   
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 3     ; Cargar el valor 0 en el registro W
    SUBWF NUMERO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED3
    
    
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 4     ; Cargar el valor 0 en el registro W
    SUBWF NUMERO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED4
    
    ; Comparar si NUMERO es igual a 0
    MOVLW 5     ; Cargar el valor 0 en el registro W
    SUBWF NUMERO, W    ; Restar NUMERO de W y almacenar el resultado en W
    BTFSC STATUS, 2    ; Saltar si el resultado no es igual a cero (Z = 0)
    GOTO ENCENDERLED5
    
   
    
    
    GOTO MainLoop

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
    

   
 
DELAY: ;Start DELAY subroutine here
        movlw 400 ;Load initial value for the delay
        movwf 0x10 ;Copy the value from working reg to the file register 0x10
        movwf 0x11 ;Copy the value from working reg to the file register 0x11

DELAY_LOOP: ;Start delay loop
	CLRWDT
        decfsz 0x10, F ;Decrement the f register 0x10 and check if not zero
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP labe
        decfsz 0x11, F ;Else decrement the f register 0x11, check if it is not 0
        goto DELAY_LOOP ;If not then go to the DELAY_LOOP label
        retlw 0 ;Else return from the subroutine


    END     MAIN
