public class OrderController
{
    public orderMaster__c oMaster{get;set;}
    public List<orderDetail__c> oDetailList{get;set;}
    public orderDetail__c oDetail{get;set;}
    public String ProductID{get;set;}
     public String Quantity{get;set;}
     public set<String> setID;
     public Map<Product__c,Integer> mapProToRate{get;set;}
    
    public OrderController(){
    oMaster=new OrderMaster__c();
    oDetailList=new List<orderDetail__c>();
   
    Quantity='0';
    ProductID='';
    setID=new Set<String>();
    mapProToRate=new Map<Product__c,integer>();
    
    
     
     
    }
    public void addSection(){
    if(oMaster!=NULL&&oMaster.id==NULL)
    {
    insert oMaster;
    
    }
    oDetail=new orderDetail__c(orderNumber__c=oMaster.id);
    
    oDetailList.add(oDetail);
   
   
    }
   
    public void calculateTotal()
    {
       
       upsert ODetail;
       setID.add(oDetail.id);
       oDetailList.clear();
       for(orderDetail__c o:[SELECT Product__c,product__r.rate__c,total__c,Quantity__c,ID FROM orderDetail__c wHERE id IN : setID])
       {
       
         oDetailList.add(o);
       }
       
      
       
    }
    
    public void getRate()
    {
        String ID1=ApexPages.currentPage().getParameters().get('param1');
        Product__c pro=[SELECT rate__c FROM Product__c WHERE ID=:ID1];
        mapProToRate.put(pro,Integer.valueOF(pro.rate__c));
       
    }
    
   
    
}