<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Create_Grant_Closeout</fullName>
        <ccEmails>pmungamuri@plan-sys.com</ccEmails>
        <description>Create Grant  Closeout</description>
        <protected>false</protected>
        <recipients>
            <recipient>kyama@plan-sys.com.po</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Grant_CloseOut</template>
    </alerts>
    <alerts>
        <fullName>Grant_Close_Out_Grant_Officer</fullName>
        <description>Grant Close Out - Grant Officer</description>
        <protected>false</protected>
        <recipients>
            <field>Grants_Officer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/GrantCloseOut_GrantsOfficer</template>
    </alerts>
    <fieldUpdates>
        <fullName>Dummy_State_CLR_Code</fullName>
        <field>Dummy_State_CLR_Code__c</field>
        <formula>State_CLR_Code__c</formula>
        <name>Dummy State CLR Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Name</fullName>
        <description>Updates Federal Award Identification Number (Name) of Master Award.</description>
        <field>Name</field>
        <formula>IF (RecordType.Name = &apos;App Master Award&apos;, 
IF (ISPICKVAL ( 
Application__r.NOFA_RFP__r.Issuing_Officer__c, &quot;HQ(Office of Grants Management)&quot;), FAIN__c + &apos;H&apos; + 
TEXT(Application__r.Project__r.State__c)+ Custom_Auto_Number__c , FAIN__c + 
State_CLR_Code__c + TEXT(Application__r.Project__r.State__c)+ Custom_Auto_Number__c)
, 
IF (RecordType.Name = &apos;Sub App Master Award&apos;,
IF (ISPICKVAL (
Application__r.NOFA_RFP__r.Issuing_Officer__c, &quot;HQ(Office of Grants Management)&quot;), ForCustomAuto_FAIN__c + &apos;H&apos; + 
TEXT(Application__r.Project__r.State__c)+ Custom_Auto_Number__c + Application__r.Dup_Sub_App_Auto_Number__c, 	ForCustomAuto_FAIN__c + 
State_CLR_Code__c + TEXT(Application__r.Project__r.State__c)+ Custom_Auto_Number__c + Application__r.Dup_Sub_App_Auto_Number__c), 

IF (ISPICKVAL (
Prime_Application__r.NOFO_RFP__r.Issuing_Officer__c, &quot;HQ(Office of Grants Management)&quot;), ForCustomAuto_FAIN_Prime__c + &apos;H&apos; +
TEXT(Prime_Application__r.Project_Name__r.State__c)+ Custom_Auto_Number__c , ForCustomAuto_FAIN_Prime__c +
State_CLR_Code__c + TEXT(Prime_Application__r.Project_Name__r.State__c)+ Custom_Auto_Number__c )))</formula>
        <name>Update Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Dummy State CLR Code</fullName>
        <actions>
            <name>Dummy_State_CLR_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Master_Award__c.State_CLR_Code__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grant CloseOut</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Master_Award__c.Award_ID__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update FAIN</fullName>
        <actions>
            <name>Update_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>FAIN for Applications.</description>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Number</fullName>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
