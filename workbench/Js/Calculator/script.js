let a = "";
let b = "";
let c = "";
let d = "";

    document.getElementById("Btn1").onclick = function(){                  
        // a += "1";
        document.getElementById("res").innerHTML = a; 
            
    }

    document.getElementById("ACBtn").onclick = function(){
        a = ""; 
        document.getElementById("res").innerHTML = 0.0; 
    }
    
    document.getElementById("Btn2").onclik = function() {
        a += "2"; 
        document.getElementById("res").innerHTML = a; 
    } 

    document.getElementById("SumBtn").onclik = function() {
         
    } 
