COMMENT °

| Programa para demostrar la bandera de acarreo y sus cambios utilizando suma y resta
| Erick Renato Vega Cerón
| Ingeniería en Sistemas Computacionales

°

include irvine32.inc

.code
main proc


		mov eax,0FFFFFFFFH	;se llena el registro con 32 bits de datos
		call dumpregs	;se muestran en pantalla las banderas previo a saturar el registro

		add eax,1 ;se suma 1 al registro eax para saturar el registro y activar la bandera CF (acarreo)

		call dumpregs	;se muestran en pantalla las banderas
		
		sub eax,1 ;se resta 1 al registro eax para limpiar la bandera de acarreo

		call dumpregs	;se muestran en pantalla las banderas

		sub eax,1 ;se resta 1 al registro eax para limpiar la bandera de acarreo

		call dumpregs	;se muestran en pantalla las banderas


	
	call writeInt	;se manda el resultado del registro eax a pantalla

	invoke ExitProcess,0
main endp
end main
