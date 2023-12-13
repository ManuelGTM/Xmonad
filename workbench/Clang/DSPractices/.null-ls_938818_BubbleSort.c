#include <stdio.h>

void sort(int arr[], int size);
//void sort2d(int rows, int columns, int arr[rows][columns]);
void print2d(int rows, int columns, int arr[rows][columns]);
void print_Arr(int arr[], int size);
void print(int r, int c);
// void mayor(int rows, int columns, int arr[rows][columns]);


int main() {

    int arr[] = {3,5,2,1,4,6,0,9,8,7};
    int arr3[] = {2,6,4,5,7,3};
    int size = sizeof(arr3)/sizeof(arr3[0]);
    print_Arr(arr3,size);
    printf("\n");
    sort(arr3, size);
    print_Arr(arr3,size);

    int arr2[2][2] = {
        {34,5},
        {3,15},
    };

    int rows = sizeof(arr2)/ sizeof(arr2[0]);
    int columns = sizeof(arr2[0])/sizeof(arr2[0][0]);

    // printf("\n%d, %d\n", rows, columns);

    // sort2d(rows, columns, arr2;
    // print2d(rows, columns, arr2);  
    printf("\n");
    // sort(arr,size);
    // print_Arr(arr, size);

    // mayor(rows, columns, arr2);  
    printf("\n"); 
    return 0;
}

 void sort2d(int r, int c, int arr[r][c]){

     for(int i = 0; i < r ; i++){
      for(int j = 0; j < c ; j++){
        for(int k = 0; k < j - 1; k++){

        if(arr[i][k] > arr[i][k+1]){
          int temp = arr[i][k];
          arr[i][k] = arr[i][k+1];
          arr[i][k+1] = temp;
        }

      /*if(arr[i][j] > arr[i][j+1]){
            int temp = arr[i][j];
            arr[i][j] = arr[i][j+1];
            arr[i][j+1] = temp; 
          }
          
          if(arr[i+1][j] > arr[i+1][j+1]){
            int temp = arr[i+1][j];
            arr[i+1][j] = arr[i+1][j+1];
            arr[i+1][j+1] = temp;
            
          }

          if(arr[i][j] < arr[i+1][j+1]){
            int temp = arr[i][j];
            arr[i][j] = arr[i+1][j+1];
            arr[i+1][j+1] = temp; 
          }

          if(arr[i][j] > arr[i+1][j]){
            int temp = arr[i][j];
            arr[i][j] = arr[i+1][j];
            arr[i+1][j] = temp; 
          }

          if(arr[i][j+1] > arr[i+1][j+1]){
            int temp = arr[i][j+1];
            arr[i][j+1] = arr[i+1][j+1];
            arr[i+1][j+1] = temp; 
          }*/

          printf("\n%d, %d\n", i,j);
      }
    }
  }
}


void print2d(int rows, int columns, int arr[rows][columns]){
  for(int i = 0; i < rows; i++){
    printf("|");
    for(int j = 0; j < columns; j++){
      printf(" %d ", arr[i][j]);    
    }
    printf("|");
    printf("\n");
  }
}

void print(int r, int c){
  for(int i = 0; i < r; i++){
    for(int j = 0; j < c; j++){
      printf("(%d, %d)", i, j);
    }
    printf("\n");
  }
}


void sort(int arr[], int size){
  
  for(int i = 0; i < size - 1; i++){
    for(int j = 0; j < size - 1; j++){
        
      if(arr[j] > arr[j+1]){
          int temp = arr[j];
          arr[j] = arr[j+1];
          arr[j+1] = temp;
      }
    }   
  }
}

void print_Arr(int arr[], int size){
  
  for(int i = 0; i < size; i++){
    printf("%d ",arr[i]);
  }
}

