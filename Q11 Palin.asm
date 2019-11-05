DATA Segment

des db 0AH,0DH, "Menu for String ! $"
inp1 db 0AH,0DH, "1. Input String $"
inp2 db 0AH,0DH, "2. Print String $"
inp3 db 0AH,0DH, "3. Palindrome ?  $"
inp4 db 0AH,0DH, "4. Exit $"

des2 db 0AH,0DH, "Enter the Choice: $"

out1 db 0AH,0DH, "String Input Done !  $"
out2 db 0AH,0DH, "The Input String is : $"
out3 db 0AH,0DH, "The String is a Palindrome $"
out4 db 0AH,0DH, "The String is not a Palindrome $"
out5 db 0AH,0DH, "Exit ! $"
out6 db 0AH,0DH, "Invalid Option $"

len dw ?
choice db ?
val dw ?

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

mov DX,offset des2;
mov AH,09H;
int 21H;

mov AH,01H;
int 21H;

sub AL,30H;
mov choice,AL;

cmp choice,04H;
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
jnz palin_label;
call disp_pr;
call menu_pr;

palin_label:
cmp choice,03H;
jnz invalid_label;
call palin_pr;
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

mov AX,1000H;
mov val,AX;
mov SI,val;
mov DI,val;
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

mov DI,val;

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

palin_pr proc

mov DI,val;
mov SI,val;
add DI,len;
dec DI;

mov BL,02H;
mov AX,len;
div BL;
mov AH,00H;
mov CX,AX;
mov AX,0000H;
mov BX,0000H;

palin:

mov BH,[SI];
mov BL,[DI];
cmp BH,BL;
jne nopp;
inc SI;
dec DI;
loop palin;

opp:

mov DX,offset out3;
mov AH,09H;
int 21H;
call menu_pr;

nopp:
mov DX,offset out4;
mov AH,09H;
int 21H;
call menu_pr;

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
