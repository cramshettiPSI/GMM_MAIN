trigger user on User (after insert) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            UserHelper.shareOrganizationEditPermission(trigger.oldmap,trigger.newmap);
        }
    }
    

}