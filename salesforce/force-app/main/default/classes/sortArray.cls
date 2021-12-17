public class sortArray{
   public sortArray(){
     Integer[] arrayToSort = new Integer[]{2,107,7,3,12,4,4,9,13, 13};
	 Integer minValue = findMin(arrayToSort);
	 Integer maxValue = findMax(arrayToSort);
	 Integer[] countArray = new Integer[maxValue+1];
	 //initialize count to zero first
	 for(Integer i = 0 ; i < countArray.size() ; i++){
	    countArray[i] = 0;
	 }
	 for(Integer i = 0 ; i < arrayToSort.size() ; i++){
	    countArray[arrayToSort[i]] += 1;
	 }
	 System.debug('countArray'+countArray);
	 //get sum count which will give you position
	 Integer[] sumArray = new Integer[maxValue+1];
     sumArray[minValue] = 1;
     for(Integer i = 0 ; i < countArray.size() ; i++){
         if(i < minValue){
             sumArray[i] = 0;
         }
         else if(i > minValue){
             sumArray[i] = countArray[i]+sumArray[i-1];
         }
     }	 
     Integer[] sortedArray = new Integer[arrayToSort.size()];
     for(Integer i = 0 ; i < arrayToSort.size() ; i++){
         sortedArray[sumArray[arrayToSort[i]]-1] = arrayToSort[i];
         sumArray[arrayToSort[i]] -= 1;
     }
     System.debug('sortedArray'+sortedArray);
	 
   }
   
   public integer findMin(Integer[] arrayToSort){
      Integer Min = arrayToSort[0];
      for(Integer i = 1; i < arrayToSort.size() ; i++){
	    if(arrayToSort[i] < min){
		  Min = arrayToSort[i];
		}
	  }
	  return Min;
   }
   
   public integer findMax(Integer[] arrayToSort){
      Integer Max = arrayToSort[0];
      for(Integer i = 1; i < arrayToSort.size() ; i++){
	    if(arrayToSort[i] > Max){
		  Max = arrayToSort[i];
		}
	  }
	  return Max;
   }
}