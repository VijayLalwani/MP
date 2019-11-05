DATA Segment

des db 0AH,0DH, "Menu for String ! $"
inp1 db 0AH,0DH, "1. Input String $"
inp2 db 0AH,0DH, "2. Print String $"
inp3 db 0AH,0DH, "3. Length of String  $"
inp4 db 0AH,0DH, "4. Print Reverse of String $"
inp5 db 0AH,0DH, "5. Exit $"

des2 db 0AH,0DH, "Enter the Choice: $"

out1 db 0AH,0DH, "String Input Done !  $"
out2 db 0AH,0DH, "The Input String is : $"
out3 db 0AH,0DH, "The length of String is : $"
out4 db 0AH,0DH, "The Reverse of String is : $"
out5 db 0AH,0DH, "Exit $"
out6 db 0AH,0DH, "Invalid Option $"


len dw ?
choice db ?

DATA ends

CODE Segment
ASSUME CS:CODE,DS:DATA

start:

mov AX,DATA;
mov DS,AX;

call menu_pr;

menu_pr proc

mov DX,offset des;
mov AH,09H;
int 21H;

mov DX,offset inp1;
mov AH,09H;
int 21H;

mov DX,offset inp2;
mov AH,09H;
int 21H;

mov DX,offset inp3;
mov AH,09H;
int 21H;

mov DX,offset inp4;
mov AH,09H;
int 21H;

mov DX,offset inp5;
mov AH,09H;
int 21H;

mov DX,offset des2;
mov AH,09H;
int 21H;

mov AH,01H;
int 21H;

sub AL,30H;
mov choice,AL;

cmp choice,05H;
jnz inp_label;
exit_label:
call exit_pr;

inp_label:
cmp choice,01H;
jnz disp_label;
call inp_pr;
call menu_pr;

disp_label:
cmp choice,02H;
jnz displen_label;
call disp_pr;
call menu_pr;

displen_label:
cmp choice,03H;
jnz dispr_label;
call displen_pr;
call menu_pr;

dispr_label:
cmp choice,04H;
jnz invalid_label;
call dispr_pr;
call menu_pr;

invalid_label:

mov DX,offset out6;
mov AH,01H;
int 21H;
call menu_pr;

endp


inp_pr proc

mov DX,offset inp1;
mov AH,09H;
int 21H;

mov AX,0000H;
mov SI,1000H;
mov DI,1000H;
mov len,00H;

takeinp:

mov AH,01H;
int 21H;

cmp AL,0DH;
je done;

setinp:

mov [DI],AL;
inc DI;
inc len;
jmp takeinp;

done:

mov DX,offset out1;
mov AH,09H;
int 21H;

ret
endp

disp_pr proc

mov DI,SI;

mov CX,len;

mov DX,offset out2;
mov AH,09H;
int 21H;

disp:

mov DL,[DI];
mov AH,02H;
int 21H;

inc DI;
loop disp;

ret
endp

displen_pr proc

mov DX,offset out3;
mov AH,09H;
int 21H;

mov CX,len;
and CX,0F000H;
ror CX,0CH;
add CX,30H;
mov DX,CX;
mov AH,02H;
int 21H;

mov CX,len;
and CX,0F00H;
ror CX,08H;
add CX,30H;
mov DX,CX;
mov AH,02H;
int 21H;

mov CX,len;
and CX,00F0H;
ror CX,04H;
add CX,30H;
mov DX,CX;
mov AH,02H;
int 21H;

mov CX,len;
and CX,0FH;
add CX,30H;
mov DX,CX;
mov AH,02H;
int 21H;

ret
endp

dispr_pr proc

mov CX,len;
mov DI,SI;
add DI,len;

dec DI;

mov DX,offset out4;
mov AH,09H;
int 21H;

dispr:

mov DL,[DI];
mov AH,02H;
int 21H;

dec DI;
loop dispr;

ret
endp

exit_pr proc

mov DX,offset out5;
mov AH,09H;
int 21H;

mov AH,4CH;
int 21H;

endp

CODE ends
end start
