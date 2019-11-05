#include<stdio.h>
#include<conio.h>
#include<stdlib.h>

int main(){

	int num=0,c=0,arr[100],avg=0,var=0;
	float fin=0;
	printf("\nExperiment 20\n");
	printf("\nHow many elements ?\n");
	scanf("%d",&num);

	for(c=0;c<num;c++){
		printf("\nEnter the number:\t");
		scanf("%d",&arr[c]);
	}

	c=0;

	asm mov CX,num;
	start:
	var = arr[c];
	asm mov AX,var;
	asm add avg,AX;
	asm inc c;
	asm loop start;

	fin=(avg/num);

	printf("Average: %f",fin);

	getch();
	return 0;
}