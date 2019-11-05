DATA SEGMENT
	msg1 db,0dh,0ah,"Enter 1st number: $"
	msg2 db,0dh,0ah,"Enter 2nd number: $"
	res db,0dh,0ah,"LCM is: $"
DATA ENDS

CODE SEGMENT
	assume CS:code, DS:data

start:  mov ax,data
		mov DS,ax
		
		mov dx,offset msg1
		mov ah,09h
		int 21h
		call input
		mov cl,bl
		mov ch,00h
		
		mov dx,offset msg2
		mov ah,09h
		int 21h
		call input
		mov bh,00h
		
		;multiply the two numbers
		mov ax,cx
		mul bl
		
	 l3:cmp bl,cl
		jnc l1
		sub cl,bl
		jmp l2
	 l1:sub bl,cl
	 l2:cmp bl,cl
		jnz l3
		
		;dividing product in ax by gcd
		div bl
		;storing quotient(lcm)in bx
		mov bx,ax
		
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
			
			mov dx,offset res 
			mov ah,09h
			int 21h
		
			mov cx, bx
			
			and bx, 0f000h
			ror bx,12
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx, 00f00h
			ror bx,8
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx, 000f0h
			ror bx,4
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bx,cx
			and bx, 0000fh
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
		