DATA segment

menu db 0AH,0DH, "Menu for 8 bit Addition Subtraction $"
add_s db 0AH,0DH, "1.Add $"
sub_s db 0AH,0DH, "2.Subtract $"
exit_s db 0AH,0DH, "3.Exit $"
inv_s db 0AH,0DH, "Invalid ! Enter choice again.. $"
inp_s db 0AH,0DH, "Enter the choice: $"
inp_1 db 0AH,0DH, "Enter Number 1 : $"
inp_2 db 0AH,0DH, "Enter Number 2 : $"
inp_b db 0AH,0DH, "Enter : $"
add_a db 0AH,0DH, "After Addition, Ans. :  $"
sub_a db 0AH,0DH, "After Subtraction, Ans. :  $"

choice db ?

DATA ends

CODE segment
ASSUME CS:CODE,DS:DATA

start:

mov AX,DATA;
mov DS,AX;

; Main Logic

call disp_pr;

; End of main logic
; Start of procedure definitions

disp_pr proc

mov DX, offset menu;
mov AH, 09H;
int 21H;

mov DX, offset add_s;
mov AH, 09H;
int 21H;

mov DX, offset sub_s;
mov AH, 09H;
int 21H;

mov DX, offset exit_s;
mov AH, 09H;
int 21H;

mov DX, offset inp_s;
mov AH, 09H;
int 21H;

mov AH,01H;
int 21H;
sub AL,30H;

mov choice,AL;

cmp choice,03H;
jz exit_label;

mov DX, offset add_a;
mov AH, 09H;
int 21H;

call inp_pr;
mov BL,CL;

mov DX, offset sub_a;
mov AH, 09H;
int 21H;

call inp_pr;

cmp choice,01H;
jz add_label;

cmp choice,02H;
jz sub_label;

inv_label:

mov DX, offset inv_s;
mov AH, 09H;
int 21H;

call disp_pr;

exit_label:
call exit_pr;

add_label:

call add_pr;

mov DX, offset inp_1;
mov AH, 09H;
int 21H;

call ansdisp_pr;
call disp_pr;

sub_label:

call sub_pr;

mov DX, offset inp_2;
mov AH, 09H;
int 21H;

call ansdisp_pr;
call disp_pr;

ret
endp

inp_pr proc

mov AH,01H;
int 21H;

sub AL,30H;
rol AL,04H;

mov CL,AL;

mov AH,01H;
int 21H;

sub AL,30H;
add CL,AL;

ret 
endp

add_pr proc

add BL,CL;
mov CL,BL;

ret
endp

sub_pr proc

sub BL,CL;
mov CL,BL;

ret
endp

ansdisp_pr proc

and BL,0F0H;
ror BL,04H;

cmp BL,0AH;
jc next;
add BL,07H;

next:

add BL,30H;
mov DL,BL;
mov AH,02H;
int 21H;

mov BL,CL;
and BL,0FH;

cmp BL,0AH;
jc next2;
add BL,07H;

next2:

add BL,30H;
mov DL,BL;
mov AH,02H;
int 21H;

ret
endp

exit_pr proc

mov AH,4CH;
int 21H;

ret 
endp

CODE ends
end start



