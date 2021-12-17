public class StringArrayTest {
  
    public static List<String> generateStringArray(Integer n)
   {
       Integer i;
       List<String> s=new List<String>();
       for( i=0;i<n;i++)
       {
           s.add('Test '+i);
       }
       return s;
   }

}