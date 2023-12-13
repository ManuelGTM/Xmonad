#include <stdio.h>
#include <string.h>

int main(void){

  int x = 15;
  char y[25];

  printf("Ingresa tu nombre: \n");
  fgets(y, 25, stdin);
  y[strlen(y) - 1] = "\0";
  printf("Hello %s, how are you", y);

  

  printf("\n");
  return 0; 
}
