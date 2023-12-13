#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 100

typedef struct Stack {
  int data[MAX_SIZE];
  int top;
} Stack;

void initializeStack(Stack *s) { s->top = -1; }

int isEmpty(Stack *s) { return (s->top == -1); }

int isFull(Stack *s) { return (s->top == MAX_SIZE - 1); }

void push(Stack *s, int value) {

  if (isFull(s)) {
    printf("Stack is full. Cannot push.\n");
    return;
  }
  s->data[++s->top] = value;
}

int pop(Stack *s) {
  int value;

  if (isEmpty(s)) {
    printf("Stack is empty. Cannot pop.\n");
    return -1;
  }

  value = s->data[s->top--];
  return value;
}

int main(int argc, char *argv[]) {
  Stack myStack;
  initializeStack(&myStack);

  push(&myStack, 70);
  push(&myStack, 60);
  push(&myStack, 50);
  push(&myStack, 40);
  push(&myStack, 30);
  push(&myStack, 20);
  push(&myStack, 10);

  printf("Popped: %d\n", pop(&myStack));
  printf("Popped: %d\n", pop(&myStack));
  printf("Popped: %d\n", pop(&myStack));
  printf("Popped: %d\n", pop(&myStack));
  printf("Popped: %d\n", pop(&myStack));
  printf("Popped: %d\n", pop(&myStack));
  printf("Popped: %d\n", pop(&myStack));

  return 0;
}
