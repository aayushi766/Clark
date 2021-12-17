public class OrderController1
{
    public orderMaster__c oMaster{get;set;}
    public List<orderDetail__c> oDetailList{get;set;}
    public orderDetail__c oDetail{get;set;}
    public String ProductID{get;set;}
     public String Quantity{get;set;}
     public set<String> setID;
        public Map<ID,Integer> mapProToRate{get;set;}
        public Integer Rate{get;set;}
    public Map<Integer ,boolean> showRate{get;set;}
    public Map<Integer ,boolean> showTotal{get;set;}
    public boolean showColumn{get;set;}
     public boolean showColumnTotal{get;set;}
     public Map<Integer ,boolean> showRowInput{get;set;}
   
    public Map<Integer ,boolean> showRowOutput{get;set;}
     public Map<Integer ,boolean> showSave{get;set;}
    public Map<Integer ,boolean> showEdit{get;set;}
    public boolean showSaveColumn{get;set;}
   public boolean showEditColumn{get;set;}
   public boolean showOMasterInput{get;set;}
    public boolean showOMasterOutput{get;set;}
     public boolean showOMaster{get;set;}
   
   
   
    
    public static integer i=0;
    
    public OrderController1(){
    oMaster=new OrderMaster__c();
    oDetailList=new List<orderDetail__c>();
   
    Quantity='0';
    ProductID='';
    setID=new Set<String>();
    mapProToRate=new Map<ID,Integer>();
    showRate=new Map<Integer ,boolean>();
    showTotal=new Map<Integer ,boolean>();
    showRowInput=new Map<Integer ,boolean>();
     showRowOutput=new Map<Integer ,boolean>();
    showSave=new Map<Integer ,boolean>();
    
    showEdit=new Map<Integer ,boolean>();
    showOMasterInput=true;
    
    
     
    }
    public void addSection(){
    if(oMaster!=NULL&&oMaster.id==NULL)
    {
    insert oMaster;
    showOMasterOutput=true;
    showOMasterInput=false;
    oMaster=[SELECT ID,orderNumber__c ,date__c,Name FROM OrderMaster__c WHERE ID =: oMaster.id];
    
    }
   
    oDetail=new orderDetail__c(orderNumber__c=oMaster.id,identifier__c=Math.Floor(Math.random()*1000));
    //insert oDetail;
    oDetailList.add(oDetail);
    showRate.put(Integer.valueOf(oDetail.identifier__c),false);
    showTotal.put(Integer.valueOf(oDetail.identifier__c),false);
     
     for(Integer i1:showRowInput.keySet())
    {
      showRowInput.put(i1,false);
    }
     for(Integer i1:showEdit.keySet())
    {
      showEdit.put(i1,true);
    }
    showEdit.put(Integer.valueOf(oDetail.identifier__c),false);
     showSave.put(Integer.valueOf(oDetail.identifier__c),false);
    
    
   
    showRowInput.put(Integer.valueOf(oDetail.identifier__c),true);
     for(Integer i1:showRowOutput.keySet())
    {
      showRowOutput.put(i1,true);
    }
    showRowOutput.put(Integer.valueOf(oDetail.identifier__c),false);
   
    if(oDetailList.size()>1){showEditColumn=true;}
    showsaveColumn=false;
    }
 
    
     public void getRate()
    {
        
        
         Integer id1=Integer.valueOf(ApexPages.currentPage().getParameters().get('param5'));
         System.debug(id1);
         Integer index=0;
         for( index=0;index<oDetailList.size();index++)
        {
        if(oDetailList.get(index).identifier__c==id1)
        {
         break;
        
        }
        }
         
        
         Product__c p= [SELECT rate__c,id FROM Product__c WHERE id =:oDetailList.get(index).product__c];
        rate=Integer.valueOf(p.rate__C);
        mapProToRate.put(p.id,rate);
        System.debug(Rate);
      showRate.put(Integer.valueOf(oDetail.identifier__c),true);
      System.debug(showRate);
      oDetailList.get(index).rate__c=p.rate__c;
      showColumn=true;
      if(oDetailList.get(index).quantity__c!=NULL)
      {
        oDetailList.get(index).total1__c=oDetailList.get(index).rate__c*oDetailList.get(index).quantity__c;
      }
      
      
    }
    public void getTotal(){
   // OrderDetail__c o=oDetailList.get(oDetailList.size()-1);
   Integer id1=Integer.valueOf(ApexPages.currentPage().getParameters().get('param6'));
         System.debug(id1);
         Integer index=0;
         for( index=0;index<oDetailList.size();index++)
        {
        if(oDetailList.get(index).identifier__c==id1)
        {
         break;
        
        }
        }
        OrderDetail__c o=oDetailList.get(index);
    
   oDetailList.get(index).total1__c=Integer.valueOf(o.rate__c)*Integer.valueOf(o.quantity__c);
//System.debug(oDetailList.get(oDetailList.size()-1).total1__c);
    showColumnTotal=true;
    showTotal.put(Integer.valueOf(o.identifier__c),true);
    }
    public PageReference saveMe()
    {
      List<orderDetail__C> oList=oDetailList;
     insert oDetailList;
     Integer int1=0;
     Integer sum=0;
     
     for(int1=0;int1<oList.size();int1++)
     {
       if(oList.get(int1).total1__c!=NULL)
      sum+=Integer.valueOF(oList.get(int1).total1__c);
     }
     
     oMaster.total__c=Integer.valueOf(sum);
     upsert oMaster;
    PageReference pgHome=new PageReference('/apex/OMngHome?id='+oMaster.id);
    return pgHome;
    }
    
  public void edit1(){
  Integer id1=Integer.valueOf(ApexPages.currentPage().getParameters().get('param1'));
  
   showRowInput.put(id1,true);
   showRowOutput.put(id1,false);
   showEdit.put(id1,false);
   showSave.put(id1,true);
   showEditColumn=false;
   showSaveColumn=true;
  }
  public void save1(){
  Integer id1=Integer.valueOf(ApexPages.currentPage().getParameters().get('param2'));
  
  
  showEditColumn=true;
  showSaveColumn=false;
    showRowInput.put(id1,false);
    showRowOutput.put(id1,true);
  showEdit.put(id1,true);
  showSave.put(id1,false);
  }
    
}