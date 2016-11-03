;MINISUMO CHAPIE - PIC 18F4550




LIST p=18F4550;
#include <p18F4550.inc>
CONFIG FOSC =HS;
CONFIG PWRT =ON;
CONFIG WDT =OFF;
CONFIG PBADEN =OFF;
CONFIG LVP =OFF;
CONFIG DEBUG=OFF;
CONFIG XINST=OFF;






;--------------------- REGISTER GPR - SFR--------------------
PC		EQU	0FF9H	; REGISTRO SFR PCL
STATUS	EQU	0FD8H	; REGISTRO SFR STATUS Y  FLAGS


REG1	EQU	0100H	; REGISTRO GPR


CONTA1	EQU	0101H	; REGISTRO GPR SUBRUTINA
CONTA2	EQU	0102H	; REGISTRO GPR SUBRUTINA
CONTA3	EQU	0103H	; REGISTRO GPR SUBRUTINA
;-------------------------------------------------------------
		ORG		0000H		;
		GOTO	CONFIG_PIC	;






;-------------------------------------------------------------
;	PROGRAMA
;-------------------------------------------------------------


PROGRAMA	
BTFSC  PORTD,2;
GOTO PROGRAMA;
GOTO ENCENDIDO;


ENCENDIDO	
			CALL RETARDO;
			CALL RETARDO;
			CALL RETARDO;
			CALL RETARDO;
			CALL RETARDO;
			CALL VERIFICAR_SENSOR_IZQ_AD;
			CALL VERIFICAR_SENSOR_DER_AD;
			CALL VERIFICAR_SENSOR_IZQ_AT;
			CALL VERIFICAR_SENSOR_DER_AT;
			CALL BUSCAR_ENEMIGO;
			GOTO ENCENDIDO;


;---------------------ACCIONES ROBOT--------------------------
BUSCAR_ENEMIGO
CALL GIRAR_IZQUIERDA;
CALL RETARDO;
CALL AVANZAR;
RETURN;


;---------------------VERIFICACION DE SENSORES--------------------
;-----------------------------------------------------------------
;			VERIFICA EL SENSOR DE ADELANTE, LADO IZQUIERDO
;-----------------------------------------------------------------
VERIFICAR_SENSOR_IZQ_AD 
BTFSS	PORTD,7;
CALL SENSOR_IZQ_AD_ACTIVADO;
CALL BUSCAR_ENEMIGO;
RETURN;
;-----------------------------------------------------------------
;			VERIFICA EL SENSOR DE ADELANTE, LADO DERECHO
;-----------------------------------------------------------------
VERIFICAR_SENSOR_DER_AD 
BTFSS	PORTD,6;
CALL SENSOR_DER_AD_ACTIVADO;
CALL BUSCAR_ENEMIGO;
RETURN;


;-----------------------------------------------------------------
;			VERIFICA EL SENSOR DE ATRAS, LADO IZQUIERDO
;-----------------------------------------------------------------
VERIFICAR_SENSOR_IZQ_AT 
BTFSS	PORTD,5;
CALL SENSOR_IZQ_AT_ACTIVADO;
CALL BUSCAR_ENEMIGO;
RETURN;


;-----------------------------------------------------------------
;			VERIFICA EL SENSOR DE ATRAS, LADO DERECHO
;-----------------------------------------------------------------
VERIFICAR_SENSOR_DER_AT 
BTFSS	PORTD,4;
CALL SENSOR_DER_AT_ACTIVADO;
CALL BUSCAR_ENEMIGO;
RETURN;


;---------------------SENSORES ACTIVADOS--------------------------
;-----------------------------------------------------------------
;			VERIFICA EL SENSOR DE ADELANTE, LADO IZQUIERDO
;-----------------------------------------------------------------
SENSOR_IZQ_AD_ACTIVADO
CALL FRENAR;
CALL GIRAR_IZQUIERDA;
CALL BUSCAR_ENEMIGO;
RETURN;


;-----------------------------------------------------------------
;			VERIFICA EL SENSOR DE ADELANTE, LADO DERECHO
;-----------------------------------------------------------------
SENSOR_DER_AD_ACTIVADO
CALL FRENAR;
CALL GIRAR_DERECHA;
CALL BUSCAR_ENEMIGO;
RETURN;


;-----------------------------------------------------------------
;			VERIFICA EL SENSOR DE ATRAS, LADO IZQUIERDO
;-----------------------------------------------------------------
SENSOR_IZQ_AT_ACTIVADO
CALL AVANZAR;
CALL BUSCAR_ENEMIGO;


;-----------------------------------------------------------------
;			VERIFICA EL SENSOR DE ATRAS, LADO DERECHO
;-----------------------------------------------------------------
SENSOR_DER_AT_ACTIVADO
CALL AVANZAR;
CALL BUSCAR_ENEMIGO;




;---------------------MOVIMIENTOS CARRO--------------------------


;-----------------------------------------------------------------
;			GIRAR_IZQUIERDA
;-----------------------------------------------------------------
GIRAR_IZQUIERDA
BSF PORTB,7;
BCF PORTB,6;
BSF PORTB,5;
BCF PORTB,4;
BTFSS PORTC,7;SI HAY UN 1, SALTO PORQUE NO DETECTO NADA
CALL AVANZAR;
BTFSS PORTC,6;
CALL GIRAR_DERECHA;
RETURN;




;-----------------------------------------------------------------
;			GIRAR_DERECHA
;-----------------------------------------------------------------
GIRAR_DERECHA
BCF PORTB,7;
BSF PORTB,6;
BCF PORTB,5;
BSF PORTB,4;
BTFSS PORTC,7;SI HAY UN 1, SALTO PORQUE NO DETECTO NADA
CALL	GIRAR_IZQUIERDA;
BTFSS PORTC,6;
CALL AVANZAR;
RETURN;




;-----------------------------------------------------------------
;			AVANZAR
;-----------------------------------------------------------------
AVANZAR
BSF PORTB,7;
BCF PORTB,6;
BCF PORTB,5;
BSF PORTB,4;
RETURN;


;-----------------------------------------------------------------
;			RETROCEDER
;-----------------------------------------------------------------
BCF PORTB,7;
BSF PORTB,6;
BSF PORTB,5;
BCF PORTB,4;
RETURN;




;-----------------------------------------------------------------
;		   FRENAR
;-----------------------------------------------------------------
FRENAR
BCF PORTB,7;
BCF PORTB,6;
BCF PORTB,5;
BCF PORTB,4;
RETURN;


;-------------------------------------------------------------
;	SUBRUTINA DE RETARDO
;-------------------------------------------------------------
RETARDO		MOVLW	0FFH	;
			MOVWF	CONTA1	;
CICLO3		MOVLW	0FFH	;
			MOVWF	CONTA2	;
CICLO2		MOVLW	01H		;
			MOVWF	CONTA3	;




CICLO1		DECFSZ	CONTA3,1	;CON 1 LO GUARDA EN EL MISMO REGISTRO, CON 0 SE GUARDA EN EL REGISTRO W (DE TRABAJO)
			GOTO	CICLO1		;


			DECFSZ	CONTA2,1	;
			GOTO	CICLO2		;


			DECFSZ	CONTA1,1	;
			GOTO	CICLO3		;


	


			RETURN


			


;------------------------------------------------------------------
;	CONFIGURACION DE LOS RECURSOS HARDWARE INTERNOS PIC 18F4550
;------------------------------------------------------------------
CONFIG_PIC	NOP					;
			CLRF	PORTB		;
			CLRF	LATB		;
			MOVLW	0EH			;
			MOVWF	ADCON1		;	
			MOVLW	b'00000000'	;
			MOVWF	TRISB		;	




		
			CLRF PORTC 			; 
			CLRF LATC 			; 
			MOVLW b'11111111' 	; 
			MOVWF TRISC 		; 


			CLRF PORTD 			; 
			CLRF LATD 			; 
			MOVLW b'11111111' 	; 
			MOVWF TRISD 		; 1




				
			GOTO	PROGRAMA	;
;------------------------------------------------------------------
END
