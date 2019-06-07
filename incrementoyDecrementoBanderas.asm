COMMENT °

| Programa para demostrar la bandera de acarreo y sus cambios utilizando incremento y decremento
| Erick Renato Vega Cerón
| Ingeniería en Sistemas Computacionales

°

include irvine32.inc

.code
main proc

		mov eax,0FFFFFFFFH	;se llena el registro con 32 bits de datos
		call dumpregs	;se muestran en pantalla las banderas
		inc eax	;se incrementa el registro eax una vez
				
		call dumpregs	;se muestran en pantalla las banderas

		mov eax,0

		dec eax ;se decrementa el registro eax una vez
		
		call dumpregs	;se muestran en pantalla las banderas

	call writeInt	;se manda el resultado del registro eax a pantalla

	invoke ExitProcess,0
main endp
end main
	invoke ExitProcess,0
main endp
end main
