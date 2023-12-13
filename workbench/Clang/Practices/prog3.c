#include <stdio.h>
#include <string.h> 
#include <stdlib.h>
#include <time.h>

typedef struct {

  char nombre[25];
  char apellido[25];
  int edad;

} Estudiante;

typedef struct {
  
  char nombre[25];
  char apellido[25];
  char cargo[25];

} Profesores;

void Menu();
void MenuOPT();
void Menu2(Estudiante estudiantes[], int size);
void Menu3(Profesores profesores[], int size);
double Suma(double a, double b);
double Resta(double a, double b);
double Mult(double a, double b);
double Div(double a, double b);
void Calculation();
void CalculationMenu();
void Guess();

int main(void){
  
  MenuOPT();
  // Guess();
  printf("\n");
  return 0;
}

void MenuOPT(){

  Estudiante estudiante1 = {"Manuel", "Torres", 22};
  Estudiante estudiante2 = {"Emmanuel", "Torres", 19};
  Estudiante estudiante3 = {"Rosa", "Perez", 16};
  Estudiante estudiante4 = {"Kevin", "Beam", 18};
  Estudiante estudiante5 = {"Juana", "Lopez", 17};
    


  Profesores profesor1 = {"Rodolfo", "Gutierrez", "Director"};
  Profesores profesor2 = {"Juan", "Florentino", "Gerente"};
  Profesores profesor3 = {"Laura", "Perez", "Profesora"};
  Profesores profesor4 = {"Maria", "Lavante", "Profesora"};
  Profesores profesor5 = {"Raul", "Rodriguez", "Coordinador"};

  Profesores profesores[] = {profesor1, profesor2, profesor3, profesor4, profesor5};
  int SizeProfesores = sizeof(profesores)/sizeof(profesores[0]);

  Estudiante estudiantes[] = {estudiante1, estudiante2, estudiante3, estudiante4, estudiante5};
  int SizeEstudiante = sizeof(estudiantes)/sizeof(estudiantes[0]);
int opt;
int a , b;

do{
  Menu();
  printf("\nElija una opcion: ");
  scanf("%d", &opt);
  switch(opt){
    case 1:
      system("clear");
      puts("Hi mark!");
      break;
    case 2:
      system("clear");
      Menu2(estudiantes, SizeEstudiante);
      break;
    case 3:
      system("clear");
      Menu3(profesores, SizeProfesores);
      break;
    case 4:
      system("clear");
      break;
    case 5:
      system("clear");
      Calculation();
       break;
    case 6:
      system("clear");
      Guess();
      break;
    case 7: 
        puts("Hasta la proxima! :)");
        break;
    default:
      if(opt > 7)
      {
        puts("opcion no disponible");
      }
  }
}while(opt != 7);

}


void Menu(){
  printf("--------------------------------------------------------------\n");
  printf("\t\t\tMenu de opciones\n");
  printf("--------------------------------------------------------------\n");
  printf("1) Insertar un ,estudiantes\n");
  printf("2) Consultar los estudiantes\n");
  printf("3) Consultar los profesores\n");
  printf("4) Limpiar Pantalla\n");
  printf("5) Calculadora\n");
  printf("6) Juego de adivinar el numero\n");
  printf("7) Salir\n");
  printf("--------------------------------------------------------------");
}

void Menu2(Estudiante estudiantes[], int size){

  int id = 1;
  printf("----------------------------------------------------------\n");
  printf("\t\t   Menu de Estudiantes\n");
  printf("----------------------------------------------------------\n");
  printf("Id               Nombre          Apellido        Edad\n");
  printf("----------------------------------------------------------\n");

  for(int i = 0; i < size; i++){
    printf("%-12d\t %-14s\t %-10s\t %-10d\t\n", id, estudiantes[i].nombre, estudiantes[i].apellido, estudiantes[i].edad);
    id++;
  }

  printf("\n\n\n");
}

void Menu3(Profesores profesores[], int size){

  int id = 1;
  printf("----------------------------------------------------------\n");
  printf("\t\t   Menu de profesores\n");
  printf("----------------------------------------------------------\n");
  printf("Id               Nombre          Apellido        Cargo\n");
  printf("----------------------------------------------------------\n");

  for(int i = 0; i < size; i++){
    printf("%-12d\t %-14s\t %-10s\t %-10s\t\n", id, profesores[i].nombre, profesores[i].apellido, profesores[i].cargo);
    id++;
  }

  printf("\n\n\n");
}

double Suma(double a, double b){
  return a + b;
}
double Resta(double a, double b){
  return a - b;
}
double Mult(double a, double b){
  return a * b;
}
double Div(double a, double b){
  return a / b;
}
double Pow(double a){
  return a * a;
}

void CalculationMenu(){

  printf("--------------------------------------------------------------\n");
  printf("\t\t\tMenu de Calculos\n");
  printf("--------------------------------------------------------------\n");
  printf("1) Realiza una Suma\n");
  printf("2) Realiza una Resta\n");
  printf("3) Realiza una multiplicion\n");
  printf("4) Realiza una division\n");
  printf("5) Realiza una potencia\n");
  printf("6) Limpiar Pantalla\n");
  printf("7) Menu Principal\n");
  printf("--------------------------------------------------------------");

}

void Calculation(){
    
  int a;
  double b, c;
  
  do{
    CalculationMenu();
    printf("\nElije una opcion: ");
    scanf("%d", &a);
    switch(a){
      case 1:
        system("clear");
        printf("Inserte un numero: ");
        scanf("%lf", &b);
        printf("Inserte un numero: ");
        scanf("%lf", &c);
        printf("\n\nResultado: %.2lf\n\n", Suma(b,c));
        break;
      case 2:
        system("clear");
        printf("Inserte un numero: ");
        scanf("%lf", &b);
        printf("Inserte un numero: ");
        scanf("%lf", &c);
        printf("\n\nResultado: %.2lf\n\n", Resta(b,c));
        break;
      case 3:
        system("clear");
        printf("Inserte un numero: ");
        scanf("%lf", &b);
        printf("Inserte un numero: ");
        scanf("%lf", &c);
        printf("\n\nResultado: %.2lf\n\n", Mult(b,c));
        break;
      case 4:
        system("clear");
        printf("Inserte un numero: ");
        scanf("%lf", &b);
        printf("Inserte un numero: ");
        scanf("%lf", &c);
        if(c != 0){
         printf("\n\nResultado: %.2lf\n\n", Div(b,c));
        break;
        }else{
        puts("Error!\n");
        break;
        }
      case 5:
        system("clear");
        printf("Inserte un numero: ");
        scanf("%lf", &b);
        printf("\n\nResultado: %.2lf\n\n", Pow(b));
        break;
      case 7:
        system("clear");
        MenuOPT();
        break;
      case 6:
        system("clear");
        break;
      default:
        if(a > 7){ 
        puts("Opcion invalida");
        break;
        }
    }
  }while(a != 7);
}

void MenuGuess(){
  printf("-----------------------------------\n");
  printf("        Adivina el numero          \n");
  printf("-----------------------------------\n");
}

void Guess(){

  srand(time(0));

  int number = (rand() % 6) + 1;
  int adv;
  int rep = 0;
  int cont = 0;
  int score = 0; 

  MenuGuess();
  while(score < 3){

    printf("Puntaje: %d\n\n", score);
    printf("Inserta un numero: ");
    scanf("%d", &adv);

    if(adv < number){
        printf("\nToo low!\n");
      }else if(adv > number){
        printf("\nToo high!\n");
      }else if(adv == number){
        printf("\nYou win!!\n");
        score++;
      }

      cont++;
      if(cont > 1){
        cont = 0;
        system("clear");
        MenuGuess();
      }
    }
  
  system("clear");
  printf("\nPuntaje: %d\n", score);
  printf("You won!! \n\n");
  printf("Desea continuar: \n");
  printf("1) Si   2) No\n");
  scanf("%d", &rep);

  if(rep == 1){
    system("clear");
    score = 0;
    Guess();
  }else{
    system("clear");
    MenuOPT();
  }

}


