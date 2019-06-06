COMMENT °

| Programa para demostrar la bandera zero y sus cambios con operaciones de suma y resta
| Erick Renato Vega Cerón
| Ingeniería en Sistemas Computacionales

°

include irvine32.inc

.code
main proc

		mov eax,0	;se guarda el valor 0 en eax
		call dumpregs	;se muestran en pantalla las banderas
		
		add eax,1 ;se suma 1 a eax

		call dumpregs	;se muestran en pantalla las banderas en la cual se mira que la bandera ZF ha cambiado a 0 puesto que el valor resultante de la operación aritmética no es cero
		sub eax,1	;se resta 1 a eax
		call dumpregs	;se muestran en pantalla las banderas en la cual se mira que la bandera ZF ha cambiado a 1 puesto que el valor de eax es 0

	call writeInt	;se manda el resultado del registro eax a pantalla

	invoke ExitProcess,0
main endp
end main
