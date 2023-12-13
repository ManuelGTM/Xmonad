#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 100

typedef struct Queue {
  int data[MAX_SIZE];
  int head, tail;
} Queue;

void Queue_init(Queue *q) {

  q->head = -1;
  q->tail = -1;
}

int isEmpty(Queue *q) { return (q->head == -1); }

int isFull(Queue *q) { return (q->tail == MAX_SIZE - 1); }

void enqueue(Queue *q, int value) {
  if (isFull(q)) {
    printf("Queue is full. Cannot enqueue.\n");
    return;
  }

  if (isEmpty(q)) {
    q->head = 0;
  }

  q->data[++q->tail] = value;
}

int dequeue(Queue *q) { int value; }
if (isEmpty(q)) {
  printf("Queue is empty. Cannot dequeue.\n");
  return -1;
}

value = q->data[q->head];

if (q->head == q->tail) {
  Queue_init(q);
} else {
  q->head++;
}
return value;
}

int main(int argc, char *argv[]) {
  Queue myQueue;
  Queue_init(&myQueue);

  enqueue(&myQueue, 10);
  enqueue(&myQueue, 20);
  enqueue(&myQueue, 30);
  enqueue(&myQueue, 40);
  enqueue(&myQueue, 50);

  printf("Dequeued: %d\n", dequeue(&myQueue));
  printf("Dequeued: %d\n", dequeue(&myQueue));
  printf("Dequeued: %d\n", dequeue(&myQueue));
  printf("Dequeued: %d\n", dequeue(&myQueue));
  printf("Dequeued: %d\n", dequeue(&myQueue));

  return 0;
}
