public class Assignuserstogroup
 {
@future
 
 public static void Assignuser(string us)
 {
 Group g=[select Id from Group Where name = 'All Customer Portal User'];
                
          List<GroupMember> GMlist = new List<GroupMember>();      
                
            GroupMember GM = new GroupMember();
            GM.GroupId = g.id;
            GM.UserOrGroupId = us;
            GMList.add(GM);         
  
    if(!GMList.isEmpty()) {
        System.debug('Group Member List is ' + GMList);
        insert GMList;
    }

 }
 @future
 
 public static void updateAccount(string acc,string us )
 {
 account getaccount = [select  id,ownerid,name from account where id=: acc];
 system.debug('@@@@account@@@@@'+getaccount.OwnerId);
                system.debug('@@@@@u.Id@@@@@'+us);

 if(getaccount.OwnerId != us)
                {
                getaccount.OwnerId = us;
                system.debug('####account######'+getaccount.OwnerId);
                system.debug('#####u.Id#####'+us);
                update getaccount;
                 }
 }

 }