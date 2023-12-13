Program Saludo;

Uses Crt;

Var 
nombre: string;
apellido:string;
numero1: integer;
numero2: integer;

Begin

Clrscr;
writeln('Ingrese su nombre: '); 
readln(nombre);
writeln('Ingrese su apellido: '); 
readln(apellido); 

writeln('Tu nombre es: ', nombre, apellido);

writeln('Ingrese un numero');
readln('numero1');
writeln('Ingresa otro numero');
readln(numero2);

writeln('La suma es: ', numero1  + numero2);


end. 
