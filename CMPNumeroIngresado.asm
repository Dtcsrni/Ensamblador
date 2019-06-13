COMMENT °
| Programa de comparacion donde se le solicita un numero al usuario, si el numero es 
|mayor que 10, muestra "correcto" (etiqueta2), si no, regresa a etiqueta1
| Erick Renato Vega Cerón
| Ingeniería en Sistemas Computacionales
°
include irvine32.inc

.data
prompt BYTE "Ingrese otro numero: ",0 ;define el contenido del primer mensaje a mostrar
prompt2 BYTE "Numero correcto ",0	;define el contenido del segundo mensaje a mostrar
var BYTE 11	;	define la variable var con numero 10, a comparar, de tipp	Word
.code
main proc
etiqueta1: 
mov  edx,OFFSET prompt	;se mueve al registro edx el contenido en offset del primer mensaje
      call WriteString	;se llama la instruccion escribir string con el contenido de edx
      call ReadInt	;se llama a la instrucción para leer un numero y almacenarlo en ax
CMP var,al	;se compara var con ax
JBE etiqueta1	;si ax es menor que var, el programa regresa a etiqueta 1, si no avanza
;a partir de aquí el programa avanza solo si ax es mayor que var, o sea 10
mov  edx,OFFSET prompt2	;se mueve al registro edx el valor del segundo mensaje
       call WriteString	;se llama a la funcion WriteString para mostrar el mensaje guardado en edx
	  call writeInt	;se manda el resultado del registro ax a pantalla
	invoke ExitProcess,0	; se invoca el fin del proceso
main endp
end main
