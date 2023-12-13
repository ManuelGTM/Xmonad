#include <stdio.h>

typedef struct {
  int a;
  int b; // 8 bytes
} Num;

int Point(int *pA) { return *pA; }

int ar(int x, int y) { return (x + y) * ((2 * y) + (2 * x)); }

void increment(int *p) { *p = (*p) + 1; }

int main(void) {

  // Num number = {1, 2};
  // Num *pNum = NULL;
  // pNum = &number;

  // point(*pNum);

  int a = 1;

  int *pA = NULL;

  pA = &a;

  *pA = 20;

  printf("%p\n", &a);
  printf("%d\n", Point(pA));
  printf("%d\n", ar(10, 10));

  increment(&a);
  printf("%d\n", *pA);

  // printf("%d\n", a);

  // printf("%p\n", pA);

  printf("\n");
  return 0;
}
