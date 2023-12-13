 const prompt = require('prompt-sync')();

function reverse(n) {
    
   let nr = n.length-1
    let s = "" 

        
    for(let i = nr; i >= 0; i-- ){
        s += n[i]
    }
    
    return s;

}

let s = "hola"
console.log("string reversado: " + reverse(s))






