COMMENT °
|Programa sobre operaciones aritméticas
|Erick Renato Vega Cerón
|Ingeniería en Sistemas Computacionales
°

include irvine32.inc	;se incluye la biblioteca irvine 32

.data
val1 SDWORD 8	;se define la variable 1 como palabra doble con signo, con el valor 8
val2 SDWORD -15	;se define la variable 2 como palabra doble con signo, con el valor -15
val3 SDWORD 20	; se define la variable 3 como palabra doble con signo, con el valor 20

.code
main proc
	mov	eax,val3 ;mover val3 a eax				
	mov	ebx,val1 ;mover val1 a ebx
	add eax,ebx  ;sumar val1 + val3 y guardarlo en eax
	
	mov ebx,eax ;intercambiar registros
	mov eax,7   ;asignar a eax 7
	sub eax,ebx  ;restar 7 a eax

	mov ebx,val2	;mover el valor de la segunda variable al registro ebx
	neg ebx	;convertir el registro ebx en su complemento a dos, para eliminar el signo 
	add ebx,eax	;sumar eax a ebx
	mov eax,ebx	;mover el resultado a eax
	



	
	
	
	
	call writeInt	;mostrar en pantalla el resultado


	invoke ExitProcess,0
main endp
end main
