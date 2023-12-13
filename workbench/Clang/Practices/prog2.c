#include <stdio.h>
#include <string.h>

struct Player {

  char Name[12];
  int age;
};

int main(void) {

  // int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};

  // for(int i = 0; i < 9; i++){
  //   printf("%d\n", arr[i]);
  // }

  // Tipos de datos y sus valores en bits

  // int a = 5;           //4 bytes
  // short a2 = 5;        //2 bytes
  // long long a3 = 5;    //8 bytes
  // float b = 5.0;       //4 bytes
  // double c = 5.0;      //8 bytes
  // char d = 'a';        //1 bytes
  //
  // char str[] = {'H', 'e','l', 'l', 'o', '\0'}; forma explicita de declarar un
  // string double doub[] = {5.9, 5.9, 5.998, 5.998, 5.998, 5.998}; // array de
  // dobles
  //
  // int size = sizeof(doub);    //funcion que calcula el tamano de un tipo de
  // dato int size2 = sizeof(doub) / doub[0];  // calculo para tomar el tamano
  // de un array .Length en otro lenguage
  //
  //
  // printf("\n%d Bytes",size);
  // printf("\n%d Bytes",size2);
  //
  // for(int i = 0; i < sizeof(doub)/ sizeof(doub[0]); i++){
  //     printf("\n%lf\n", doub[i]);
  //}

  // Creacion de un array 2d

  //   int arr[3][3] ={
  //                    {1,2,3},
  //                    {4,5,6},
  //                    {7,8,9}
  //                  };
  // //
  //
  // int rows = sizeof(arr)/ sizeof(arr[0]);
  // int columns = sizeof(arr[0])/ sizeof(arr[0][0]);
  //
  // printf("%d\n", rows);
  // printf("%d", columns);
  //  //
  //
  // for(int i = 0; i < rows; i++){
  //    printf("|");
  //    for(int j = 0; j< columns; j++){
  //      printf("%d", arr[i][j]);
  //    }
  //    printf("|");
  //    printf("\n");
  //  }
  //
  //
  // char str1[][10] = {"Minecraft", "Lego", "Hi"};
  //
  // char game[15];
  //
  // strcpy(game, "Minecraft");
  //
  // printf("%s\n",game);
  //
  //
  // for(int i = 0; i < sizeof(str1)/ sizeof(str1[0]); i ++){
  //   printf("%s\n", str1[i]);
  // }
  //
  //
  // int x = 20;
  // int y = 15;
  // int temp;
  //
  // temp = x;
  // x = y;
  // y = temp;
  //
  // printf("temp: %d\nx: %d\ny: %d", temp, x, y);

  // Bitwise Operators

  // & -> AND = si ambos son igual a 1 el resultado es 1
  // | -> OR  = si uno de los dos es 1 el resultado es 1
  // ^ -> XOR = si ambas son distintas el resultado es 1
  // >> -> Right_SHIFT = desplaza el 1 una posicion a la derecha (el valor
  // disminuye a la mitad)
  // << -> Left_SHIFT = desplaza el 1 una posicion a la izquierda (el valor
  // incrementa el doble)

  int x2 = 6;      // 6 =  00001110
  int y2 = 10;     // 10 = 00001010
  int z = x2 << 1; // z =  00000001 -> 2
  int z2 = x2 & y2;
  //

  // printf("%d\n%d", z, z2);

  struct Player Manuel;
  struct Player Emmanuel;

  strcpy(Manuel.Name, "Manuel");
  Manuel.age = 22;

  strcpy(Emmanuel.Name, "Emmanuel");
  Emmanuel.age = 19;

  printf("%s\n", Manuel.Name);
  printf("%s\n", Emmanuel.Name);

  printf("\n");
  return 0;
}
