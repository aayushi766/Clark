const getBMI = function(weight , height){
    try{
        return weight/(height*height);

    }catch(Exception){
        return undefined;
    }
}

export{getBMI};