COMMENT °

| Programa cronómetro con subrutinas
| Erick Renato Vega Cerón
| Ingeniería en Sistemas Computacionales

°

include irvine32.inc

.data
	nombre BYTE "    Erick Vega ",0 ;define el contenido del nombre a mostrar
	materia BYTE "Lenguaje Ensamblador",0 ;define el contenido del nombre a mostrar
	mensaje BYTE "Acceder al cronometro?",0 ;define el contenido del nombre a mostrar
	siCadena DWORD 26995	; define el codigo ASCII para la cadena si para comparar con el input del usuario
	noCadena DWORD 28526	;define el codigo ASCII para la cadena no para comparar con el input del usuario
	salida BYTE " Hasta luego "	;define la cadena de salida
	segundos  BYTE	"seg transcurridos",0	;define el mensaje de segundos transcurridos
	MAX = 3                     ; el maximo de caracteres a leer
	stringIn DWORD MAX+1 DUP (?)  ; el tamaño de la variable de entrada, mas el simbolo null
	tiempo BYTE "Ingrese el tiempo en segundos: ",0
	numerotiempo DWORD ?
	transcurrido DWORD ?
	numero DWORD ?
	espacio BYTE " ",0
.code
main proc
	;escribir nombre
	  mov  edx,OFFSET nombre	;se mueve al registro edx el contenido del primer mensaje
      call WriteString	;se llama la instruccion escribir string con el contenido de edx
	  call Crlf	;se salta la linea
	  call Crlf	;se salta la linea
	;escribir materia
	  mov  edx,OFFSET materia	;se mueve al registro edx el contenido del segundo mensaje
      call WriteString	;se llama la instruccion escribir string con el contenido de edx
	  call Crlf	;se salta la linea
	;escribir pregunta de cronometro
	  mov  edx,OFFSET mensaje	;se mueve al registro edx el contenido del segundo mensaje
      call WriteString	;se llama la instruccion escribir string con el contenido de edx
	  call Crlf	;se salta la linea
	;leer cadena
	  mov  edx,OFFSET stringIn	;se mueve el offset de la variable stringIn al registro edx
      mov  ecx,MAX            ; tamaño del buffer
      call ReadString	;leer una cadena del usuario (el si o el no)
	
	  mov eax,stringIn	;mover el contenido de stringIN al registro eax

	;comparación
	   cmp siCadena, eax	;  comparar al registro eax con el valor ASCII de la palabra si

       JNC cronometro      ;salta a cronometro si el valor es si
	   JC salir	;salta a la salida si el valor es no
cronometro:
	   call cronometroSub
	   jmp fin

salir:																																																																						
	    mov  edx, OFFSET salida	;se mueve al registro edx el contenido del segundo mensaje
		call WriteString	;se llama la instruccion escribir string con el contenido de edx
fin:	
invoke ExitProcess,0
main endp


cronometroSub proc	;la subrutina del cronometro
 call Clrscr	;se limpia la pantalla
	   mov  edx,OFFSET tiempo	;se mueve al registro edx el contenido del segundo mensaje
       call WriteString	;se llama la instruccion escribir string con el contenido de edx
	   call ReadInt	;leer un entero referente a cuantos segundos se esperará
	   mov numerotiempo,eax	;mover el valor del entero a la variable numero tiempo

	   mov ecx,numerotiempo	;mover el tiempo indicado a esperar, al contador


	   mov eax,numerotiempo	;mover también el tiempo indicado al registro eax
	   mov numero,eax	;mover el contenido de eax a la variable numero

	   contador:	;inicio del bucle para contar el tiempo
	   mov eax,ecx	;mover el valor actual del contador al registro eax 
	   sub eax,numero	;restarle al registro eax el valor de la variable numero, que es el tiempo inicial indicado
	   neg eax	;convertir el registro eax a su complemento a dos para eliminar el signo
	   add eax,1	;sumar uno para que empiece desde un segundo

	   mov  edx,OFFSET espacio	;se mueve al registro edx el contenido del segundo mensaje
       call WriteString	;se llama la instruccion escribir string con el contenido de edx

	   call WriteDec	;mostrar el valor del tiempo en pantalla

	   mov  edx,OFFSET espacio	;se mueve al registro edx el contenido del segundo mensaje
       call WriteString	;se llama la instruccion escribir string con el contenido de edx
	   

	   mov  edx,OFFSET segundos	;se mueve al registro edx el contenido del segundo mensaje
       call WriteString	;se llama la instruccion escribir string con el contenido de edx
	   
	   
	   mov  eax,1000 ; esperar un segundo
       call Delay	;se procede a la espera
	   call Crlf	;se salta la linea
	   dec ecx	;se decrementa el contador
	   jnz contador	;regresa si el contador no vale cero aún
	   
	   

ret	;retorno (equivalente a return=0)
cronometroSub endp	

end main