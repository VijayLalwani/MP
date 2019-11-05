DATA segment

menu db 0AH,0DH, "Menu for 16 bit Addition Subtraction $"
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

; Menu and functioning

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

; Choice from user 
; Switch case 

cmp choice,03H;   For Exit
jz exit_label;

; Taking input

mov DX, offset inp_1;
mov AH, 09H;
int 21H;

mov CX,0000H;
call inp_pr;
mov BX,CX;   Storing in BX since in input procedure it is stored in CX

mov DX, offset inp_2;
mov AH, 09H;
int 21H;

mov CX,0000H;
call inp_pr;  in CX

cmp choice,01H;
jz add_label;

cmp choice,02H;
jz sub_label;

; For Invalid / Default case

inv_label:

mov DX, offset inv_s;
mov AH, 09H;
int 21H;

call disp_pr;

; Function/Procedure calls

;Case 3
exit_label:
call exit_pr;

;Case1
add_label:

call add_pr;

mov DX, offset add_a;
mov AH, 09H;
int 21H;

call ansdisp_pr;
call disp_pr;		Recall menu

;Case2
sub_label:

call sub_pr;

mov DX, offset sub_a;
mov AH, 09H;
int 21H;

call ansdisp_pr;
call disp_pr;		Recall menu

ret
endp


; Procedure for input

inp_pr proc

mov AH,01H;
int 21H;

mov AH,AL;
sub AH,30H;
rol AH,04H;
mov CH,AH;

mov AH,01H;
int 21H;

mov AH,AL;
sub AH,30H;
add CH,AH;

mov AH,01H;
int 21H;

sub AL,30H;
ror AL,04H;
add CL,AL;

mov AH,01H;
int 21H;

sub AL,30H;
add CL,AL;

ret 
endp

; Procedure for add

add_pr proc

add BX,CX;
mov CX,BX;

ret
endp

; Procedure for subtract

sub_pr proc

sub BX,CX;
mov CX,BX;

ret
endp

; Procedure for display ans

ansdisp_pr proc

; For BH

and BH,0F0H;
ror BH,04H;

cmp BH,0AH;
jc next1;
add BH,07H;

next1:

add BH,30H;
mov DL,BH;
mov AH,02H;
int 21H;

mov BH,CH;
and BH,0FH;

cmp BH,0AH;
jc next2;
add BH,07H;

next2:

add BH,30H;
mov DL,BH;
mov AH,02H;
int 21H;

; For BL

and BL,0F0H;
ror BL,04H;

cmp BL,0AH;
jc next3;
add BL,07H;

next3:

add BL,30H;
mov DL,BL;
mov AH,02H;    
int 21H;

mov BL,CL;
and BL,0FH;

cmp BL,0AH;
jc next4;
add BL,07H;

next4:

add BL,30H;
mov DL,BL;
mov AH,02H;
int 21H;

ret
endp

; Procedure for exit

exit_pr proc

mov AH,4CH;
int 21H;

ret 
endp

CODE ends
end start



