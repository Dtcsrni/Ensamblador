; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

include irvine32.inc

.data
val1 SDWORD 8
val2 SDWORD -15
val3 SDWORD 20

.code
main proc
	mov	eax,val3 ;mover val3 a eax				
	mov	ebx,val1 ;mover val1 a ebx
	add eax,ebx  ;sumar val1 + val3 y guardarlo en eax
	
	mov ebx,eax ;intercambiar registros
	mov eax,7   ;asignar a eax 7
	sub eax,ebx  ;restar 7 a eax

	mov ebx,val2
	neg ebx
	add ebx,eax
	mov eax,ebx
	



	
	
	
	
	call writeInt


	invoke ExitProcess,0
main endp
end main
