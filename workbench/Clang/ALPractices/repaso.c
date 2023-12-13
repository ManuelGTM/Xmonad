#include <stdio.h>
#include <stdlib.h>

void Bubble(int arr[], int size) {
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int t = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = t;
      }
    }
  }
}

void printArr(int arr[], int size) {
  for (int i = 0; i < size; i++) {
    if (i == 0) {
      printf("[ %d,", arr[i]);
    } else if (i == size - 1) {
      printf(" %d ]", arr[i]);
    } else {
      printf(" %d,", arr[i]);
    }
  }
}

int main(int argc, char *argv[]) {

  int arr[] = {1, 5, 2, 3, 7, 9, 8, 0, 6, 4};
  int size = sizeof(arr) / sizeof(arr[0]);

  printArr(arr, size);
  printf("\n");
  Bubble(arr, size);
  printf("\n");
  printArr(arr, size);

  return EXIT_SUCCESS;
}
