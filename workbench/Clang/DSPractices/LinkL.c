#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node{
    int id;
    char name[25];
    struct node *link;
} node;

void ShowNode(struct node *head){
    int count = 0; 

  if(head == NULL){
        printf("The linked list is empty");

    }
    struct node *ptr = NULL;
    ptr = head;

    while(ptr != NULL){
        count++;
        printf("node %d value: %d, %s\n", count, ptr->id, ptr->name); 
        ptr=ptr->link;
    }
    printf("Existen %d nodos\n", count);

}

int main(){

    node *head = NULL;
    head = (struct node *)malloc(sizeof(struct node));
    head->id = 1;
    strcpy(head->name, "John Doe");
    head->link = NULL;

    node *current = NULL;
    current = (struct node *)malloc(sizeof(struct node));
    current->id=2;
    strcpy(current->name,"Emmanuel");
    current->link = NULL;
    head->link = current;

    current = malloc(sizeof(struct node));
    current->id = 3;
    strcpy(current->name, "Manuel");
    current->link = NULL;

    head->link->link = current;
    
    ShowNode(head);
    return 0;
}
