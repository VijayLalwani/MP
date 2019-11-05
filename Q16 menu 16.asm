DATA SEGMENT
	c db ?
	choice db,0dh,0ah,"Enter your choice: 1.Addition 2.Subtraction 3.Exit $"
	msg1 db 0dh,0ah,"Enter first 16 bit number: $"
	msg2 db 0dh,0ah,"Enter second 16 bit number: $"
	result db 0dh,0ah,"Result is: $"
DATA ENDS

CODE SEGMENT
	assume CS:code, DS:data
	
start:  mov ax,data
		mov DS,ax 
		
		mov dx, offset choice
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		
		cmp al,33h
		jnz skipe
		mov ah,4ch
		int 21h
		
skipe:  mov c,al

		;1st number
		mov dx, offset msg1
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		call ASCIItoHEX
		mov bh,al
		rol bh,4
		mov ah,01h
		int 21h
		call ASCIItoHEX
		add bh,al
		
		mov ah,01h
		int 21h
		call ASCIItoHEX
		mov bl,al
		rol bl,4
		mov ah,01h
		int 21h
		call ASCIItoHEX
		add bl,al
		
		;2nd number
		mov dx, offset msg2
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		call ASCIItoHEX
		mov ch,al
		rol ch,4
		mov ah,01h
		int 21h
		call ASCIItoHEX
		add ch,al
		
		mov ah,01h
		int 21h
		call ASCIItoHEX
		mov cl,al
		rol cl,4
		mov ah,01h
		int 21h
		call ASCIItoHEX
		add cl,al
		
		;moving choice back to al
		mov al,c
		cmp al,31h
		jnz skipa
		call myadd
		
  skipa:cmp al,32h
		jnz skips
		call mysub
		
  skips:jmp start
		
		myadd proc
			add bx,cx
			
			mov dx, offset result
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
		
		mysub proc
			sub bx,cx
			
			mov dx, offset result
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
			
		
		ASCIItoHEX proc
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