;=============================================================
; Práctica 1 - "Hola Mundo" con PIC16F887 en ensamblador pic-as
; Objetivo:
;   - Configurar oscilador interno a 8 MHz
;   - Desactivar funciones analógicas
;   - Poner RB0 como salida y parpadear un LED con delay por software
;=============================================================

        PROCESSOR   16F887
        #include    <xc.inc>            ; SFRs, bits y macros (BANKSEL)

;-------------------------------------------------------------
; CONFIG (fuses) — perfil de laboratorio
;   Nota: En pic-as se usa CONFIG, no __CONFIG
;-------------------------------------------------------------
        CONFIG  FOSC   = INTRC_NOCLKOUT ; Oscilador interno, sin CLKOUT
        CONFIG  WDTE   = OFF            ; Watchdog deshabilitado (por ahora)
        CONFIG  PWRTE  = ON             ; Power-up Timer habilitado
        CONFIG  MCLRE  = ON             ; MCLR como reset externo
        CONFIG  CP     = OFF            ; Sin protección de código
        CONFIG  CPD    = OFF            ; Sin protección de EEPROM
        CONFIG  BOREN  = ON             ; Brown-out Reset habilitado
        CONFIG  BOR4V  = BOR40V         ; Umbral BOR ~4.0V
        CONFIG  FCMEN  = OFF            ; Fail-Safe Clock Monitor desactivado
        CONFIG  IESO   = OFF            ; Int. Switchover desactivado
        CONFIG  LVP    = OFF            ; Programación de baja tensión off
        CONFIG  WRT    = OFF            ; Sin write-protect

;-------------------------------------------------------------
; VECTORES
;   0x0000: reset  -> saltamos a INIT
;   0x0004: int    -> no usamos interrupciones (RETFIE)
;-------------------------------------------------------------
        PSECT   resetVec, class=CODE, delta=2
        ORG     0x0000
        GOTO    INIT

        PSECT   intVec, class=CODE, delta=2
        ORG     0x0004
        RETFIE                      ; Placeholder de ISR (sin interrupciones)

;-------------------------------------------------------------
; VARIABLES (RAM en bank0)
;-------------------------------------------------------------
        PSECT   udata_bank0, space=1
R0:     DS 1                         ; Contador externo para delay
R1:     DS 1                         ; Contador interno para delay

;-------------------------------------------------------------
; CÓDIGO PRINCIPAL
;-------------------------------------------------------------
        PSECT   code, class=CODE, delta=2

;-------------------- INIT --------------------
INIT:
        ; 1) Reloj interno a 8 MHz:
        ;    En pic-as usa literales C: 0b..., 0x..., decimales
        BANKSEL OSCCON
        MOVLW   0b01110000           ; IRCF=111 (8MHz), SCS=00
        MOVWF   OSCCON

        ; 2) Todo digital (ANSEL/ANSELH=0)
        BANKSEL ANSEL
        CLRF    ANSEL
        CLRF    ANSELH

        ; 3) Puerto B como salida (RB0->LED)
        BANKSEL TRISB
        CLRF    TRISB                ; 0=salida
        BANKSEL PORTB
        CLRF    PORTB                ; arranca con LED apagado
	
	BANKSEL TRISC 
	MOVLW	0x01
	MOVWF	TRISC
	BANKSEL PORTC
	MOVWF	PORTC

;-------------------- MAIN LOOP --------------------
MAIN:
	BTFSC PORTC, 0
	BSF     PORTB, 0
	
	BTFSS PORTC, 0
	BCF     PORTB, 0
	
	
        ; Enciende LED en RB0
 
        CALL    DELAY
        GOTO    MAIN

	

;-------------------------------------------------------------
; DELAY3000MS (aprox) a Fosc=8MHz (Tcy=0.5us)
; - Doble bucle 250x250 con sobrecarga ~500 ms
; - En pic-as no uses d'250' → usa 250 (decimal)
;-------------------------------------------------------------
DELAY:
        MOVLW   500                  ; W = 250
        MOVWF   R0                   ; R0 = 250 (externo)
OUTER:
        MOVLW   500                ; W = 250
        MOVWF   R1                   ; R1 = 250 (interno)
INNER:
        NOP                           ; 1 ciclo -> relleno
        DECFSZ  R1, F                ; R1-- ; salta si llega a 0
        GOTO    INNER
        DECFSZ  R0, F                ; R0-- ; salta si llega a 0
        GOTO    OUTER
        RETURN	
        END



