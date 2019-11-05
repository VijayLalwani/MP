#include<stdio.h>
#include<conio.h>
#include<stdlib.h>

int main(){

	int num1=0,num2=0,lcm=0,gcd=0;
	printf("\nGCD,LCM\n");
	printf("\nEnter no1: \n");
	scanf("%d",&num1);
	printf("\nEnter no2: \n");
	scanf("%d",&num2);

	asm mov AX,num1;
	asm mov BX,num2;

	start:
	asm cmp AX,BX;
	asm jc btoa;
	atob:
	asm sub AX,BX;
	asm jmp last;
	btoa:
	asm sub BX,AX;
	last:
	asm cmp AX,BX;
	asm jne start;

	asm mov lcm,AX;

	printf("\nLCM For two given nos. is : %d",lcm);

	/* To Find GCD */

	gcd = (num1*num2)/lcm;

	printf("\nGCD For two given nos. is : %d",gcd);

	getch();
	return 0;
}