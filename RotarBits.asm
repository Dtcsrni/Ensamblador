
; Programa para ingresar un numero de 5 bits en el puerto A,multiplicarlo por dos 
; y mandarlo al puerto B .
; Solución: Rotar los bits del puerto A a la izquierda (multiplicar por dos)
; Erick Renato Vega Cerón
; Ingeniería en Sistemas Computacionales

; PIC16F84A Configuration Bit Settings
#include "p16f84a.inc"					;definir la librería del pic a utilizar

; CONFIG
; __config 0xFFF9
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF	; definir el oscilador externo de cuarzo, apagar watchdog timer, apagar pwrte
 							; apagar protección de código



    LIST p=16f84A	;PIC a utilizar

    ORG 0		;origen 0
		    ;inicio de instrucciones 
    

    BSF STATUS, RP0	;definir el banco de memoria a utilizar en las siguientes operaciones 
    
    bsf PORTA,0		;mandar un 1 al puerto a, bit 0 para definirlo como entrada
    bsf PORTA,1		;mandar un 1 al puerto a, bit 1 para definirlo como entrada
    bsf PORTA,2		;mandar un 1 al puerto a, bit 2 para definirlo como entrada
    bsf PORTA,3		;mandar un 1 al puerto a, bit 3 para definirlo como entrada
    bsf PORTA,4		;mandar un 1 al puerto a, bit 4 para definirlo como entrada
    
    bcf PORTB,0		;mandar un 0 al puerto b, bit 0 para definirlo como salida
    bcf PORTB,1		;mandar un 0 al puerto b, bit 1 para definirlo como salida
    bcf PORTB,2		;mandar un 0 al puerto b, bit 2 para definirlo como salida
    bcf PORTB,3		;mandar un 0 al puerto b, bit 3 para definirlo como salida
    bcf PORTB,4		;mandar un 0 al puerto b, bit 4 para definirlo como salida
    bcf PORTB,5		;mandar un 0 al puerto b, bit 5 para definirlo como salida
    bcf PORTB,6		;mandar un 0 al puerto b, bit 6 para definirlo como salida
    bcf PORTB,7		;mandar un 0 al puerto b, bit 7 para definirlo como salida
    
    bcf STATUS,RP0	;limpiar el registro de status
    
   
    
    
inicio 
    MOVFW PORTA		;mover al registro de trabajo W el contenido completo del puerto A
    goto rotar   	;ir a la sección rotar
  
   
rotar
    RLF	PORTA,0		;rotar a la izquierda el contenido del puerto A, guardarlo en el registro de trabajo W
    MOVWF PORTB		;mover el registro de trabajo W al puerto B
    goto inicio		;regresar a inicio

END    
    
