COMMENT °

| Programa para calcular secuencia de fibonacci en ensamblador
|Erick Renato Vega Cerón
| Ingeniería en Sistemas Computacionales

°

include irvine32.inc

.code
main proc
;valores iniciales
	mov edx,1	;primer valor
	mov ebx,0	;segundo valor

	mov eax,0
;variable contador
	mov ecx,10
;inicio del bucle
	ETIQUETA1:
		
		add edx,ebx ;se suman los dos valores y se guarda en reg edx
		mov eax,edx	;se manda el resultado de dx a registro ax para muestra en pantalla
		mov edx,ebx ;se recorre el segundo valor a la primera posición
		mov ebx,eax	; y el resultado ocupa la segunda posicion

		call writeInt	;se manda a pantalla
		dec ecx	;Se decrementa el contador
	jnz ETIQUETA1	;si el contador aún no es cero, el programa salta de regreso a la etiqueta
	
	

	invoke ExitProcess,0
main endp
end main
