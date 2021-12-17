public class parent{
  public void method(){
   system.debug('in parent');
    child c = new child();
    c.method2();
  }
  private class child{
    private void method2(){
      system.debug('in child');
    }
  }
}