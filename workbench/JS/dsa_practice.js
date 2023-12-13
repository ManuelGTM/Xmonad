let arr = [2,3,5,7,9];
let t = 0;

let result = Binary(arr,t);

if(result != -1){
    console.log(`Element ${t} found`);
}else{
    console.log(`Element ${t} not found`);
}

function Binary(arr, n) {

    let lo = 0;
    let hi = arr.length;

    while(lo < hi){
        const m = Math.floor(lo + (lo - hi) / 2);
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
















