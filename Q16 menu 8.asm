DATA SEGMENT
	choice db 0dh,0ah,"Enter your choice: 1.Addition 2.Subtraction 3.Multiplication 4.Division 5.Exit $"
	msg1 db 0dh,0ah,"Enter first number: $"
	msg2 db 0dh,0ah,"Enter second number: $"
	result db 0dh,0ah,"Result is: $"
	r db 0dh,0ah,"Remainder is: $"
	q db 0dh,0ah,"Quotient is: $"
DATA ENDS

CODE SEGMENT
	assume CS:code, DS:data
	
start:	mov ax, data
		mov DS,ax
		
		;printing choice
		mov dx, offset choice
		mov ah,09h
		int 21h
		
		mov ah,01h
		int 21h
		
		cmp al,35h
		jnz skipe
		;terminate
		mov ah,4ch
		int 21h
		
skipe:  mov ch,al
		
		;input1
		mov dx, offset msg1
		mov ah,09h
		int 21h
		
		;1st char
		mov ah,01h
		int 21h
		call ASCIItoHEX
		mov bl,al
		rol bl,4
		;2nd char
		mov ah,01h
		int 21h
		call ASCIItoHEX
		add bl,al 	
		
		;input2
		mov dx, offset msg2
		mov ah,09h
		int 21h
		
		;1st char
		mov ah,01h
		int 21h
		call ASCIItoHEX
		mov cl,al
		rol cl,4
		;2nd char
		mov ah,01h
		int 21h
		call ASCIItoHEX
		add cl,al 	
		
		;moving choice back to al
		mov al,ch
		cmp al, 31h
		jnz skipa
		call myadd
		
  skipa:cmp al,32h
		jnz skips
		call mysub
		
  skips:cmp al,33h
		jnz skipm
		call mymul
	
  skipm:cmp al,34h
		jnz skipd
		call mydiv
		
  skipd:jmp start
  
  
		myadd proc
			add bl,cl
			
			mov dx, offset result
			mov ah,09h
			int 21h
			
			mov cl,bl
			
			and bl,0f0h
			ror bl,4
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bl,cl
			and bl,0fh
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			mov al,00h
			ret
		endp
		
		mysub proc
			sub bl,cl
			
			mov dx, offset result
			mov ah,09h
			int 21h
			
			mov cl,bl
			
			and bl,0f0h
			ror bl,4
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			
			mov bl,cl
			and bl,0fh
			call HextoASCII
			mov dl,bl
			mov ah,02h
			int 21h
			mov al,00h
			ret
		endp		
		
		mymul proc
			mov dx, offset result
			mov ah,09h
			int 21h
		
			mov ah,00h
			mov al,bl
			mul cl
			mov cx,ax
			
			mov bx,ax 
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
			
			mov al,00h
			ret
		endp
		
		mydiv proc
			mov ah,00h
			mov al,bl
			div cl
			mov cx,ax
			mov bx,ax 
			
			mov dx, offset r
			mov ah,09h
			int 21h
			
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
			
			mov dx, offset q
			mov ah,09h
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
			
			mov al,00h
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
	
Code ends
end start
		
		