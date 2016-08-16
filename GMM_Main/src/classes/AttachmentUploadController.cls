public with sharing class AttachmentUploadController {

   

    /*public String selectedCountry1 { get; set; }

    public String opportunities { get; set; }

    public String getAccount() {
        return null;
    }
public Attachment attachment {
    get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }

  public PageReference upload() {

    attachment.OwnerId = UserInfo.getUserId();
     attachment.ParentId = 'a07r00000008ndJ'; // the record the file is attached to
  //  attachment.DocumentId = UserInfo.getUserId();
    attachment.IsPrivate = true;

    try {
      insert attachment;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    return null;
  }
   public List<SelectOption> getOptions() {
        List<SelectOption> Options = new List<SelectOption>();
        Options.add(new SelectOption('','-None-'));
        Options.add(new SelectOption('AAE Waiver','AAE Waiver'));
        Options.add(new SelectOption('AAE Waiver Request','AAE Waiver Request'));
        Options.add(new SelectOption('Authorized Representative Confirmation','Authorized Representative Confirmation'));
        Options.add(new SelectOption('Commission Executive Order','Commission Executive Order'));
        
 
        return Options;
    }
    public PageReference save(){
       return null;
   }*/
   
}