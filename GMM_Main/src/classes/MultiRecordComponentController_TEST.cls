@isTest
Public Class MultiRecordComponentController_TEST
{
    static testmethod void CreatePanelTestmethod1()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u = new User();
        u.Alias = 'email'; 
        u.Email='email@email.com';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing'; 
        u.LanguageLocaleKey='en_US'; 
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName='email@testcoverage.com';
        insert u;
        Test.StartTest();
        System.runAs(u){        
     
        Contact con = new Contact();
        con.Salutation='Mr.';
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        con.Primary_Phone__c = '3837373772';
        con.Is_this_a_Mobile_Number__c = 'No';
        con.Email = 'test@gmail.com';
        con.Re_Enter_Email__c = 'test@gmail.com';
        con.Mailing_Street_Address_1__c = 'test street';
        con.Mailing_State__c = 'test state';
        con.Mailing_City__c = 'test city';
        con.State_of_Residence__c = 'DC';
        con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        con.Highest__c = 'Test';    
        con.Area_of_Expertise__c = 'CNCS';
        
        insert con;
         con.Highest__c = 'Test';  
         update con;
         
        NOFA_Group__c ng =  new NOFA_Group__c();
        ng.Name__c = 'qwe';
        ng.Review_of__c = 'Application';
        ng.Review_Type__c = 'Staff';
        ng.Status__c = 'Pending';
        insert ng;
        ng.Name__c = 'qwe';
        update ng;
        
        
        Stages__c st = new Stages__c();
        st.NOFA_Group__c = ng.Id;
        st.Type__c = 'Internal';
        st.Status__c = 'In Progress';
        //st.Start_Date__c = Today();
        //st.End_Date__c = Today()+10;
        st.Stage_Number__c = '1';
        Insert st;
        
        Paneling__c pan = new Paneling__c();
        pan.Panel_Coordinator__c = con.id;
        pan.Staff_Liaison__c = con.id;
       // pan.Staff_Liasion1__c = u.Id;
        pan.Stage_Number__c = st.Id;
        insert pan;
        
        Panel_Member__c pm = new Panel_Member__c();
        pm.Active__c = true;
        pm.COI_Conflict__c= false;
        pm.Role__c = 'New Reviewer';
        pm.Status__c = 'Active';
        pm.Payment_Amount__c =123;
        pm.Staff_Member__c = u.id;
        pm.Panel__c =  pan.id;
        insert pm;
        
        Expert_Review_Panel__c erp = new Expert_Review_Panel__c();
        erp.Reviewer__c = con.id;
        erp.Panel__c = pan.id;
        erp.Panel_Member__c = pm.id;
        erp.Staff_Reviewer__c = u.id;
        insert erp;
        
        Application_Feedback__c af = new Application_Feedback__c();
        af.Accepted_by_Panel_Coordinator__c = true;
        af.Expert_Review_Panel__c = erp.id;
        af.Staff_Liaison__c = con.id;
        insert af;
        
        Stage_Question__c sq = new Stage_Question__c();
        sq.Active__c = false;
        sq.Scoring_Method__c = 'None';
        sq.If_Yes_Comments_Required__c = 'yes';
        Sq.Weight__c = 100;
        sq.Stages_ID__c = st.Id;
        insert sq;
        
        Attachment__c at =  new Attachment__c();
        at.Attachment_Id__c = '123';
        at.Description__c = 'qwqe';
        at.Size__c = 'qwqe';
        at.Stages__c = st.id;
        insert at;
        Apexpages.currentPage().getParameters().put('lksrch','test');
      //  Apexpages.currentPage().getParameters().put('parentId',panel.Id);
        MultiRecordComponentController  cont = new MultiRecordComponentController();
        cont.SobjectType = 'Nofa_Member__c';
        cont.SobjectType = 'Paneling__c';
        //cont.RelationField = 'Application__c';
        //cont.ParentRecId = at.id;
        

        cont.InitValues();
        cont.DoRemove();
        cont.DoEdit();
        cont.DoCancel();
        //cont.DoSave();
        Test.StopTest();
        
        
    }
    }
    static testmethod void CreatePanelTestmethod2()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u = new User();
        u.Alias = 'email'; 
        u.Email='email@email.com';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing'; 
        u.LanguageLocaleKey='en_US'; 
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName='email@testcoverage.com';
        insert u;
        Test.StartTest();
        System.runAs(u){        
     
        Contact con = new Contact();
        con.Salutation='Mr.';
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        con.Primary_Phone__c = '3837373772';
        con.Is_this_a_Mobile_Number__c = 'No';
        con.Email = 'test@gmail.com';
        con.Re_Enter_Email__c = 'test@gmail.com';
        con.Mailing_Street_Address_1__c = 'test street';
        con.Mailing_State__c = 'test state';
        con.Mailing_City__c = 'test city';
        con.State_of_Residence__c = 'DC';
        con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        con.Highest__c = 'Test';    
        con.Area_of_Expertise__c = 'CNCS';
        
        insert con;
         con.Highest__c = 'Test';  
         update con;
         
        NOFA_Group__c ng =  new NOFA_Group__c();
        ng.Name__c = 'qwe';
        ng.Review_of__c = 'Application';
        ng.Review_Type__c = 'Staff';
        ng.Status__c = 'Pending';
        insert ng;
        ng.Name__c = 'qwe';
        update ng;
        
        
        Stages__c st = new Stages__c();
        st.NOFA_Group__c = ng.Id;
        st.Type__c = 'Internal';
        st.Status__c = 'In Progress';
        //st.Start_Date__c = Today();
        //st.End_Date__c = Today()+10;
        st.Stage_Number__c = '1';
        Insert st;
        
        Paneling__c pan = new Paneling__c();
        pan.Panel_Coordinator__c = con.id;
        pan.Staff_Liaison__c = con.id;
       // pan.Staff_Liasion1__c = u.Id;
        pan.Stage_Number__c = st.Id;
        insert pan;
        
        Panel_Member__c pm = new Panel_Member__c();
        pm.Active__c = true;
        pm.COI_Conflict__c= false;
        pm.Role__c = 'New Reviewer';
        pm.Status__c = 'Active';
        pm.Payment_Amount__c =123;
        pm.Staff_Member__c = u.id;
        pm.Panel__c =  pan.id;
        insert pm;
        
        Expert_Review_Panel__c erp = new Expert_Review_Panel__c();
        erp.Reviewer__c = con.id;
        erp.Panel__c = pan.id;
        erp.Panel_Member__c = pm.id;
        erp.Staff_Reviewer__c = u.id;
        insert erp;
        
        Application_Feedback__c af = new Application_Feedback__c();
        af.Accepted_by_Panel_Coordinator__c = true;
        af.Expert_Review_Panel__c = erp.id;
        af.Staff_Liaison__c = con.id;
        insert af;
        
        Stage_Question__c sq = new Stage_Question__c();
        sq.Active__c = false;
        sq.Scoring_Method__c = 'None';
        sq.If_Yes_Comments_Required__c = 'yes';
        Sq.Weight__c = 100;
        sq.Stages_ID__c = st.Id;
        insert sq;
        
        Attachment__c at =  new Attachment__c();
        at.Attachment_Id__c = '123';
        at.Description__c = 'qwqe';
        at.Size__c = 'qwqe';
        at.Stages__c = st.id;
        insert at;
        Apexpages.currentPage().getParameters().put('lksrch','test');
      //  Apexpages.currentPage().getParameters().put('parentId',panel.Id);
        MultiRecordComponentController  cont = new MultiRecordComponentController();
        cont.SobjectType = 'Nofa_Member__c';
        cont.SobjectType = 'Paneling__c';
        //cont.RelationField = 'Application__c';
        //cont.ParentRecId = at.id;
        

        cont.InitValues();
        cont.DoRemove();
        cont.DoEdit();
        cont.DoCancel();
        //cont.DoSave();
        Test.StopTest();
        
        
    }
    }
}