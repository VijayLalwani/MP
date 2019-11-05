DATA SEGMENT 
	msg1 db,0dh,0ah,"Enter 10 numbers to be sorted: $"
	res db,0dh,0ah,"Numbers sorted in ascending order are: $"
DATA ENDS

CODE SEGMENT	
	assume CS:code, DS:data
	
start:  mov ax,data
		mov DS,ax
		
		;initialize counter cx to 10 
		mov cl,0ah 
		mov si,5000h
		
   lbla:mov dx,offset msg1
		mov ah,09h
		int 21h
		call input
		mov [si],bl
		inc si
		dec cl
		jnz lbla
		
		mov ch,0ah
   lblb:mov si,5000h
		mov cl,0ah
		
   lblc:mov al,[si]
		mov bl,[si+1]
	    cmp al,bl
		jc l1
		mov dl,[si+1]
		xchg [si],dl
		mov [si+1],dl
	 l1:inc si
		dec cl
		jnz lblc
		dec ch
		jnz lblb
		
		mov dx,offset res
		mov ah,09h
		int 21h
		
		mov si,5000h
		mov cl,0ah
		;display array
   lbld:mov bl,[si]
		and bl,0f0h
		ror bl,4
		call HextoASCII
		mov dl,bl
		mov ah,02h
		int 21h
		
		mov bl,[si]
		and bl,0fh
		call HextoASCII
		mov dl,bl
		mov ah,02h
		int 21h
		
		inc si
		dec cl
		jnz lbld
		
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