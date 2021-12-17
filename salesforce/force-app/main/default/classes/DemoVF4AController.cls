public class DemoVF4AController
{
    public Account acc;
	public String Message{get;set;}
    public DemoVF4AController(ApexPages.StandardController stdController )
	{
	    message='Enter Values';
		this.acc=(Account)stdController.getRecord();
		
	}
	public PageReference cancelMe()
	{
	   PageReference pg=new PageReference('/apex/DemoVF1');
	   return pg;
	}
	public void greeting()
	{
	   if(acc!=NULL&&acc.id!=NULL)
	   {
	      message='Welcome'+acc.name;
	   }
	}
}