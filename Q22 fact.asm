DATA SEGMENT
	msg1 db,0dh,0ah,"Enter a number between 1-9: $"
	res db,0dh,0ah,"Factorial is: $"
DATA ENDS

CODE SEGMENT
	assume CS:code, DS:data
	
start:  mov ax,data
		mov DS,ax
		
		mov dx,offset msg1
		mov ah,09h
		int 21h
		
		call input
		
		mov bh,00h
		mov ax,bx
		dec bx
	 l1:mul bx
		dec bx
		jnz l1
		
		;store factorial in bx
		mov bx,ax
		
		mov dx,offset res
		mov ah,09h
		int 21h
		
		call disp
		
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
		
		disp proc
			;store copy in cx
			mov cx,bx
			
			and bx,0f000h
			ror bx,12
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx,00f00h
			ror bx,8
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx,000f0h
			ror bx,4
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx,0000fh
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
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