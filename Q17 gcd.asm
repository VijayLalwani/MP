DATA SEGMENT
	gcd db ?
	N1 db 12 
	N2 db 16 
	msg1 db,0dh,0ah,"Enter 1st number: $"
	msg2 db,0dh,0ah,"Enter 2nd number: $"
	res db,0dh,0ah,"GCD is: $"
DATA ENDS

CODE SEGMENT
	assume CS:code, DS:data

start:  mov ax,data
		mov DS,ax
		
		;mov dx,offset msg1
		;mov ah,09h
		;int 21h
		;call input
		;mov cl,bl
		
	;	mov dx,offset msg2
	;	mov ah,09h
	;	int 21h
	;	call input
	
		mov bl,n1
		mov cl,n2
	
	 l3:cmp bl,cl
		jnc l1
		sub cl,bl
		jmp l2
	 l1:sub bl,cl
	 l2:cmp bl,cl
		jz l4
		cmp cl,00h
		jz l4
		cmp bl,00h
		jnz l3
		
	 l4:mov gcd,bl
		
		mov dx,offset res 
		mov ah,09h
		int 21h
		
		mov bl,gcd
		and bl,0f0h
		ror bl,4
		call HextoASCII
		mov dl,bl
		mov ah,02h
		int 21h
		
		mov bl,gcd
		and bl,0fh
		call HextoASCII
		mov dl,bl
		mov ah,02h
		int 21h
		
		mov ah,4ch
		int 21h
		
		input proc
			mov ah,01h
			int 21h
			call ASCIItoHex
			mov bl,al
			rol bl,4
			mov ah,01h
			int 21h
			call ASCIItoHex
			add bl,al
			ret
		endp
		
		ASCIItoHex proc
			cmp al,41h
			jc lbl1
			sub al,07h
	   lbl1:sub al,30h
			ret
		endp
		
		HextoASCII proc
			cmp bl,0ah
			jc lbl2
			add bl,07h
	   lbl2:add bl,30h
			ret
		endp
		
code ends
end start
		