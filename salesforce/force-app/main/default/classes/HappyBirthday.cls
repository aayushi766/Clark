Global class HappyBirthday implements Schedulable{

global void execute(SchedulableContext sc) {

 List<user> lst=[Select id,name from user where date_of_birth__c =today];
   for(User u:lst){
   FeedItem post = new FeedItem();

   post.ParentId = u.id;

   post.Body = 'Happy birthday '+u.name;

   insert post;
}

} }