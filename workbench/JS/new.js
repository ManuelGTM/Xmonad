 const prompt = require('prompt-sync')();

let arr = [2,4,6,8,2,5,3,1,5];
// console.log(arr);

function pattern(userInput) {
     return /^\d{3}-\d{3}-\d{4}/.test(userInput);
 }
 
function add7(n){
    let f = n[0].toUpperCase();
    n = n.toLowerCase().slice(1);

    return f + n;
 }
function last(x){
    return x[x.length - 1];
 }

// let x = prompt("Introduce un numbero: ");
 // console.log(pattern(x));

// console.log(last("Hellarst^"));
// console.log(add7("Mi"));

let as = [9,8,7,6,5,4,3,2,1,0];

// console.log(Sort(arr));
 let sheep = "sheep...";
 let a = "";
 let b = "Hello World";
 
for(let i = 1; i <= 10; i++){
     a += i + " " + sheep;

 }

 let c = "";

 for(let j = b.length - 1; j >= 0; j--){
      c += b[j]; 
 }

 console.log(c)




function Sort(arr){
   for(let i = 0; i < arr.length ; i++){ 
         for(let j = 0; j < arr.length - i; j++){
             if(arr[j] > arr[j+1]){
                 let t = arr[j];
                 arr[j] = arr[j+1]
                 arr[j+1] = t;
             }
         }
     }

     return arr; 
 }

 // console.log(func(10));

 let word = "Hell0";
 word = word.split('')
word.replace("0", "o");
 console.log(word);

 console.log(correct(word));

function correct(n){
   
      for(let i = 0; i < n.length; i++){ 
         if(n[i] === "0"){
              n.replace("0", 'o');
         }else if(n[i] === "5"){
     
              n.replace("1", 'i');
        }else if(n[i] === "1"){
            n.replace("5", 's');
       }
     }

    return n.join('');
 }



 function func(n){
     return n ** 2; 
 }
 // const x = prompt("enter number: ");
 // console.log(pattern(x));


// arr = arr.map((n) => n / 2);
// console.log(arr);
