#include <stdio.h>

void bubbleSort(int arr[], int size){
    for(int i = 0; i< size ; i++){
        for(int j = 0; j < size - i - 1; j++){
            if(arr[j] > arr[j + 1]){
                int t = arr[i];
                arr[i] = arr[i + 1];
                arr[i + 1] = t;
            }
        }
    }
}

int suma(int a, int b){
    return a * b;
}

void Saludo(){
    printf("Hola Nataly\n");
}

int main(int argc, char *argv[])
{

     return 0;
}
