#include <math.h>
#include <stdbool.h>
#include <stdio.h>

int binarySearch(int arr[], int size, int target);

void Bubble(int arr[], int size) {

  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int t = arr[i];
        arr[i] = arr[i + 1];
        arr[i + j] = t;
      }
    }
  }
}

void printArr(int arr[], int size) {

  for (int i = 0; i < size; i++) {
    printf("%d", arr[i]);
  }
}

int main() {

  int arr[] = {2, 3, 5, 7, 9};
  int arr2[] = {5, 3, 1, 4, 2};
  int size = sizeof(arr) / sizeof(arr[0]);
  int t = 3;

  Bubble(arr2, size);

  printArr(arr2, size);
  //
  // int result = binarySearch(arr, size, t);
  //
  // if(result != -1){
  //     printf("Element %d found at index %d.\n", t, result);
  // }else{
  //     printf("Element %d not found in the array.\n", t);
  // }

  printf("\n");
  return 0;
}

int binarySearch(int arr[], int size, int target) {
  int low = 0;
  int high = size - 1;

  while (low <= high) {
    int mid = low + (high - low) / 2;

    if (arr[mid] == target) {
      return mid; // Element found, return its index
    } else if (arr[mid] < target) {
      low = mid + 1; // Adjust the low pointer to search the right half
    } else {
      high = mid - 1; // Adjust the high pointer to search the left half
    }
  }

  return -1; // Element not found
}
