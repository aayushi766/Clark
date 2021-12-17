public class ApexAssign4 {
    
    public static List<Integer> stack=new List<Integer>();
    
    public static List<Integer> push(Integer num)
    {
        stack.add(num);
        return stack;
        
     }
     public static List<Integer> pop()
    {
        stack.remove(0);
         return stack;
        
    }
    public static Integer peep()
    {
        Integer top=stack.get(stack.size()-1);
        return top;
    }
    

}