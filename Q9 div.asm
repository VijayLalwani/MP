DATA SEGMENT
	count db ?
	msg1 db,0dh,0ah,"Enter dividend: $"
	msg2 db,0dh,0ah,"Enter divisor: $"
	res1 db,0dh,0ah,"Quotient is: $"
	res2 db,0dh,0ah,"Remainder is: $"
DATA ENDS

CODE SEGMENT
	assume CS:code,DS:data

start:  mov ax,data
		mov DS,ax
		
		mov dx,offset msg1
		mov ah,09h
		int 21h
		call input		
		mov cl,bl
		
		mov dx,offset msg2
		mov ah,09h
		int 21h
		call input

		mov count,00h		
		
   lbla:cmp cl,bl
		jc lblb
		sub cl,bl
		inc count
		jmp lbla 
		
		;remainder in bl
   lblb:mov bl,cl
		mov dx,offset res2
		mov ah,09h
		int 21h
		call disp
		
		;quotient in bl
        mov bl,count
		mov dx,offset res1
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