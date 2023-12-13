#include <stdio.h>
#include <stdlib.h>

int term;
int recursion(int n);

int factorial(int n) {

  if (n == 1) {
    return 1;
  }

  return n * factorial(n - 1);
}

int Fibo(int prev, int num) {

  static int i = 1;
  int nxtNo;

  if (i == term) {
    return 0;
  } else {
    nxtNo = prev + num;
    prev = num;
    num = nxtNo;
    printf("%d ", nxtNo);

    i++;
    Fibo(prev, num);
  }

  return (0);
}

int main(int argc, char *argv[]) {

  // static int prNo = 0, num = 1;
  // printf("input number of terms for the series (<20) :");
  // scanf("%d", &term);

  // Fibo(prNo, num);
  printf("%d", factorial(5));
  return 0;
}

int recursion(int n) {
  if (n == 1) {
    return 1;
  }

  return n * recursion(n - 1);
}
