@isTest public class TestVerifyDate {
    @isTest  public static void TestMethod1(){
        Date d1=Date.newInstance(2016,8,7);
        Date d2=date.newInstance(2016, 8,17);
       Date d3=VerifyDate.CheckDates(d1,d2);
        System.assertEquals(Date.valueOf(d3),Date.valueOf(d2));
        
        
    }
     @isTest  public static void TestMethod2(){
        Date d1=Date.newInstance(2016,8,7);
        Date d2=date.newInstance(2016, 9,15);
       Date d3=VerifyDate.CheckDates(d1,d2);
          Date d4=date.newInstance(2016,08,31);
        System.assertEquals(Date.valueOf(d3),Date.valueOf(d4));
        
        
    }
    

}