public without sharing class ExpertReviewRedirect {
public PageReference PageRedirect() {

    integer x = 1;

    String UserId = UserInfo.getUserId();
    String ContactId;
    List<User> lstUser = [Select u.Id,u.ContactId from User u where u.Id = :UserId];            
    if( lstUser != null && lstUser.size() > 0 )            
    {
          ContactId = lstUser[0].ContactId;
    }

    PageReference pageRef = null;

    if (!String.isBlank(ContactId)){
         pageRef = new pagereference('/'+ContactId);
    }

    return pageRef;

}
}