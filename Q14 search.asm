DATA SEGMENT
	count db ?
	msg1 db,0dh,0ah,"Enter count: $"
	msg2 db,0dh,0ah,"Enter numbers: $"
	msg3 db,0dh,0ah,"Enter number to be searched: $"
	res1 db,0dh,0ah,"Number found at index: $"
	res2 db,0dh,0ah,"Number not found $"
DATA ENDS

CODE SEGMENT
	assume CS:code,DS:data

start:  mov ax,data
		mov DS,ax
		
		mov dx,offset msg1
		mov ah,09h
		int 21h
		call input
		
		mov count,bl
		mov cl,count
		mov ch,00h
		mov si,5000h
		
   lbla:mov dx,offset msg2 
		mov ah,09h
		int 21h
		call input
		mov [si],bl
		inc si
		loop lbla
		
		mov si,5000h
		mov cl,count
		mov ch,00h
		mov bh,00h
		
		mov dx,offset msg3
		mov ah,09h
		int 21h
		call input
		
   lblb:inc bh
		cmp bl,[si]
		jz fnd
		inc si
		loop lblb
		jmp lblc
	
    fnd:mov dx,offset res1
		mov ah,09h
		int 21h
		
		mov bl,bh
		and bl,0f0h
		ror bl,4
		call HextoASCII
		mov dl,bl
		mov ah,02h
		int 21h
		mov bl,bh
		and bl,0fh
		call HextoASCII
		mov dl,bl
		mov ah,02h
		int 21h
		jmp exit
		
   lblc:mov dx,offset res2
		mov ah,09h
		int 21h
		mov ah,4ch
		int 21h
		
   exit:mov ah,4ch
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