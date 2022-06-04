#include <stdio.h>
#include <stdlib.h>
#include "field.h"
#include "volume.h"

int main(void)
{
	int a;
	printf("Podaj dlugosc boku kwadratu/szescianu: ");
	scanf("%d", &a);
	printf("Pole kwadratu o podanym boku: %d \n", square_field(a));
	printf("Objetosc szescianu o podanym boku: %d \n", square_volume(a));
	return 0;
}
