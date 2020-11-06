#include <stdio.h>
#include <stdlib.h>

extern void resolvente(float a, float b, float c);

int main(){
	float a,b,c;
	printf("Ingrese el coeficiente A: ");
	scanf("%f", &a);
	printf("Ingrese el coeficiente B: ");
	scanf("%f", &b);
	printf("Ingrese el coeficiente C: ");
	scanf("%f", &c);
	resolvente(a,b,c);
	return 0;
	
}
