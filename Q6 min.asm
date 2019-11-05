DATA SEGMENT 
	msg1 db,0dh,0ah,"Enter 5 numbers : $"
	res db,0dh,0ah,"Minimum is: $"
DATA ENDS

CODE SEGMENT	
	assume CS:code, DS:data
	
start:  mov ax,data
		mov DS,ax
		
		;initialize counter cx to 5
		mov cx,0005h 
		mov si,5000h
		
   lbla:mov dx,offset msg1 
		mov ah,09h
		int 21h
		call input
		mov [si],bl
		inc si
		loop lbla
		
		mov cx,0005h
		mov si,5000h
		
		dec cx
		mov bl,[si]
   lblb:cmp bl,[si+1]
		jc l1
		mov bl,[si+1]
	 l1:inc si
		loop lblb
		
		mov cl,bl
	
		mov dx,offset res
		mov ah,09h
		int 21h
		
		mov bl,cl
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