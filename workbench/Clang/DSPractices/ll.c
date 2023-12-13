#include <stdio.h>
#include <stdlib.h>

typedef struct node {
    int data;
    struct node *link;
} node; 

void NodeCount(node head){
    int count = 0;

    if(head != NULL){
        printf("La lista esta vacia");
    }
        
    node *ptr = NULL; 
    
    ptr = head;

    while(ptr->link != NULL){
        count++;
        printf("Datos %d:", ptr->data);
        ptr = ptr->link;
    }

    printf("Existen %d", count);

}

int main(int argc, char *argv[])
{
   struct node *head = (struct *)malloc(sizeof(struct node));
    head->data = 50;
    head->link = NULL;

   struct node *current = (struct *)malloc(sizeof(struct node));
    current->data = 40;
    head->link = current;
    current->link - NULL;

    current = (struct *)malloc(sizeof(struct node));
    current->data = 30;
    current->link = NULL;

    head->link->link = current;

    NodeCount(head);  
    





    return 0;
}
