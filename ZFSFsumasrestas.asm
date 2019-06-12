COMMENT °

| Programa para demostrar la bandera zero y signo sus cambios con operaciones de suma y resta
| Erick Renato Vega Cerón
| Ingeniería en Sistemas Computacionales

°

include irvine32.inc

.data
var1 SByte 01111111b

.code
main proc

		mov al,var1	;se guarda el valor 0 en eax
		call dumpregs	;se muestran en pantalla las banderas
		
		add al,1 ;se suma 1 a eax

		call dumpregs	;se muestran en pantalla las banderas en la cual se mira que la bandera ZF ha cambiado a 0 puesto que el valor resultante de la operación aritmética no es cero
		sub al,1	;se resta 1 a eax
		call dumpregs	;se muestran en pantalla las banderas en la cual se mira que la bandera ZF ha cambiado a 1 puesto que el valor de eax es 0

		sub al,1	;se resta 1 a eax

		call dumpregs	;se muestra el cambio en la bandera de signo puesto que el valor ahora es negativo
		
	call writeInt	;se manda el resultado del registro eax a pantalla

	invoke ExitProcess,0
main endp
end main
