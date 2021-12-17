trigger AssignOppTrigger on Opportunity (after insert,before update) {
        if(checkRecursive.runOnce())
        {
        Set<ID> proSet=new Set<ID>();
        for(Profile p:[SELECT ID FROM profile WHERE NAME='System Administrator'])
        {
          proSet.add(p.ID);
        }
         System.debug('profile'+proSet);
        set<ID> userSet=new Set<ID>(); 
        for(User u:[SELECT ID FROM User WHERE profileID IN: proSet])
        {
          userSet.add(u.id);
        }
        System.debug('user'+UserSet);
        set<ID> accSet=new Set<ID>();
        
       for(Opportunity opp: [SELECT AccountID FROM Opportunity WHERE AccountID!=NULL AND LastModiFiedByID IN:userSet AND ID IN:trigger.new ])
       {
         if(trigger.newMap.get(opp.ID).stageNAme=='closed lost')
         {
         accSet.add(opp.AccountID);
         }
       }
       System.debug('account'+accSet);
       List<Opportunity> oppList=new List<Opportunity>();
       for(Opportunity opp1:[SELECT StageName,AccountID,ID FROM Opportunity WHERE AccountID IN:accSet AND ID NOT IN:trigger.new])
       {
          if(opp1.StageName!='closed won' || opp1.StageName!='closed Lost')
          {
           opp1.StageName='closed Lost';
          }
          oppList.add(opp1);
       }
       System.debug(oppList);
       upsert oppList;
     }  

}