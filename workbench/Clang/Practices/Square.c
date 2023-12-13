#include <stdio.h>

void sort(int arr[], int size);
void printArr(int arr[], int size);

int main() {

  int arr[] = {1, 21, 54, 2, 4, 5, 3, 6, 12, 65, 62};
  int size = sizeof(arr) / sizeof(arr[0]);

  sort(arr, size);
  printArr(arr, size);

  printf("%d", size);

  printf("\n");
  return 0;
}

void sort(int arr[], int size) {
  for (int i = 0; i < size - 1; i++) {
    for (int j = 0; j < size - 1 - i; j++) {
      if (arr[i] > arr[i + 1]) {
        int temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
      }
    }
  }

  void printArr(int arr[], int size) {
    for (int i = 0; i < size - 1; i++) {
      printf("%d ", arr[i]);
    }
  }
}
