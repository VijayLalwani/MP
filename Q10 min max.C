#include<stdio.h>
#include<stdlib.h>
#include<conio.h>

int main(){

	int num=0,min=0,max=0,arr[100],c=0,var=0;

	printf("\nExperiment 2\n");
	printf("\nHow many inputs ?\n");
	scanf("%d",&num);

	for(c=0;c<num;c++){

		printf("Enter the number: ");
		scanf("%d",&arr[c]);
		printf("\n");
	}

	min = arr[0];
	max = arr[0];
	num-=1,c=0;

	asm mov CX,num;
	loopv:
	c+=1;
	var = arr[c];
	asm mov AX,var
	asm cmp AX,min;
	asm jnc nochange;
	change:
	asm mov min,AX;
	nochange:
	asm cmp AX,max;
	asm jc nochange1;
	change1:
	asm mov max,AX;
	nochange1:
	asm loop loopv;


	printf("\n Minimum Value among numbers is : %d\n",min);
	printf("\n Maximum Value among numbers is : %d\n",max);
	getch();
	return 0;
}
