public class ApexAssign3 {
    public static Integer daysBetweenToDates(Datetime startDate, Datetime endDate) {
    Integer i = 0;
     System.debug(startDate);
        System.debug(endDate);
        
    while (startDate <= endDate) {
                            if (startDate.format('E')!='Sat' && startDate.format('E') != 'Sun')
                            {
                                
                            i++;
                                System.debug('i='+i+startDate.format('E'));
                            }
                             startDate = startDate.addDays(1);
    }
      
   
     
     
    
    return i;
}   

}