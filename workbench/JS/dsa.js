// const prompt = require("prompt-sync")();

let unordered = [1,3,5,4,2,6,9,8,7];

//Linear Search O(N) 
//[ Used to search linearly through any list ]

//console.log(Linear(unordered, 10));

function Linear(arr, n){
    for(let i = 0; i < arr.length ; ++i){
        if(arr[i] === n){
            return true;
        }
    }
    return false;
}

//Binay Search O(log(N)) 
//[ Used to search only ordered lists using middle points ]


let ordered = [1,2,3,4,5,6,7,8,9];

Binary(ordered, 7);

function Binary(arr, n){
    
    let lo = 0;
    let hi = arr.length;
    
     while (lo < hi){
        const m = Math.floor(lo + (lo - hi) /2);
        const v = arr[m];

        if(v === n){
            return true;
        }else if(v > n){
            hi = m;
        }else{
            lo = m + 1;
        }
    }

    return false;    
}

//BubbleSort O(N2) 

let arr = [3,2,1,5,9,8,7,4];
//
// console.log(Bubble(arr));
console.log("Hello");

function Bubble(arr){
    for(let i = 0; i < arr.length; i++){
        for(let j = 0; j < arr.length - i - 1; j++){
            if(arr[j] > arr[j + 1]){
                let t = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = t;
                
            }
        }
    }
    return arr;
}







