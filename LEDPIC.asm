
    LIST p=16f887

    
LED EQU 0
BOTON EQU 0
 
    ORG 0
		    ;inicio de instrucciones 
    
    bsf STATUS,RP0
    bsf TRISA,0
    bcf TRISB,0
    bcf STATUS,RP0
    bcf PORTB,LED
inicio btfsc PORTA,BOTON
    goto encender
    bcf  PORTB,LED
    goto inicio

encender bsf PORTB,LED
    goto inicio
	    
END    
    


