; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

include irvine32.inc

.data
val1 SDWORD 8
val2 SDWORD -15
val3 SDWORD 20

.code
main proc
	mov ebx,1
	mov eax,0
	call writeInt
	mov ecx,10
	ETIQUETA1:
		add eax,ebx
		mov ebx,eax

		call writeInt
		dec ecx		
	jnz ETIQUETA1
	
	
	
	
	


	invoke ExitProcess,0
main endp
end main
