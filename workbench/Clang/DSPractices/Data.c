#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// defining struct for nodes

struct node {
  int id;
  char nombre[30];
  char apellido[30];
  struct node *link;
};

// function to create a new node

struct node *nuevo(int data, char nombre[], char apellido[]) {
  struct node *newNode = (struct node *)malloc(sizeof(struct node));
  if (newNode == NULL) {
    fprintf(stderr, "Memory allocation failed.\n");
    exit(1);
  }
  newNode->id = data;
  strcpy(newNode->nombre, nombre);
  strcpy(newNode->apellido, apellido);
  newNode->link = NULL;
  return newNode;
}

// function to insert a node in the head of the list

void insertarNodo(struct node **head, int id, char nombre[], char apellido[]) {
  struct node *newNode = nuevo(id, nombre, apellido);
  newNode->link = *head;
  *head = newNode;
}

void insertarNodoT(struct node **current, int id, char nombre[],
                   char apellido[]) {
  struct node *newNode = nuevo(id, nombre, apellido);
  newNode->link = *current;
  *current = newNode;
}

// function to print the data of the list

void printfList(struct node *head) {
  int count = 0;
  struct node *current = head;
  while (current != NULL) {
    count++;
    printf("Nodo: %d: %d, %s, %s\n", count, current->id, current->nombre,
           current->apellido);
    current = current->link;
  }
}

// free the memory allocated for the linked list

void freeList(struct node *head) {
  struct node *current = head;
  while (current != NULL) {
    struct node *temp = current;
    current = current->link;
    free(temp);
  }
}

void Array(int size);

int main(int argc, char *argv[]) {

  struct node *head = NULL;
  struct node *tail = NULL;

  insertarNodo(&head, 1, "Manuel", "Torres");
  insertarNodo(&head, 2, "Kevin", "Beam");
  insertarNodo(&head, 3, "Rosa", "Fernandez");
  insertarNodo(&head, 4, "Josefina", "Concepcion");
  insertarNodo(&head, 5, "Juan", "Florentino");
  insertarNodo(&head, 6, "Jose", "Lopez");

  printf("Linked List \n");
  printfList(head);

  freeList(head);

  Array(10);
  return 0;
}

void Array(int size) {

  int arr[size];

  for (int i = size; i >= 0; i--) {
    arr[i] = size;
    size--;
  }

  int a = sizeof(arr) / sizeof(arr[0]);

  for (int j = 0; j <= a; j++) {

    if (j == 0) {
      printf("[ %d, ", arr[j]);
    } else if (j == a) {
      printf("%d ]", arr[j]);
    } else {
      printf("%d, ", arr[j]);
    }
  }
}
