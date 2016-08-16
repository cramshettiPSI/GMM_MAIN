<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Application_Withdraw</fullName>
        <description>Application Withdraw</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>avasili@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Application_withdraw</template>
    </alerts>
    <alerts>
        <fullName>Application_Withdraw_template</fullName>
        <description>Application Withdraw template</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>avasili@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Application_withdraw</template>
    </alerts>
    <alerts>
        <fullName>Application_is_Created</fullName>
        <ccEmails>cvenedam@plan-sys.com</ccEmails>
        <description>Application is Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>pmungamuri@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>smandra@plan-sys.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CreateApplication</template>
    </alerts>
    <alerts>
        <fullName>Withdraw_Application</fullName>
        <description>Withdraw Application</description>
        <protected>false</protected>
        <recipients>
            <recipient>pmungamuri@plan-sys.com.state</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Application_withdraw</template>
    </alerts>
    <fieldUpdates>
        <fullName>Application_Accepted</fullName>
        <field>Status__c</field>
        <literalValue>Accepted</literalValue>
        <name>Application Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Draft_field</fullName>
        <description>Change Draft field value from &quot;Yes&quot; to &quot;No&quot; when an Application record is created.</description>
        <field>Draft__c</field>
        <literalValue>False</literalValue>
        <name>Change Draft field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FldUpdate_Dup_Sub_App_Auto_Number</fullName>
        <field>Dup_Sub_App_Auto_Number__c</field>
        <formula>IF (Prime_Application__r.Sub_Application_Count_For_FAIN__c &lt; 9, 
				&apos;000&apos; + TEXT(Prime_Application__r.Sub_Application_Count_For_FAIN__c+1), 
				&apos;00&apos; + TEXT(Prime_Application__r.Sub_Application_Count_For_FAIN__c+1))</formula>
        <name>FldUpdate Dup Sub App Auto Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_by</fullName>
        <field>Rejected_By__c</field>
        <formula>LastModifiedBy.FirstName</formula>
        <name>Rejected by</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_on</fullName>
        <field>Rejected_On__c</field>
        <formula>LastModifiedDate</formula>
        <name>Rejected on</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Change_to_Pre_Submitted_for_appli</fullName>
        <field>Grantee_Status__c</field>
        <literalValue>pre-submitted</literalValue>
        <name>Status Change to Pre-Submitted for appli</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_By</fullName>
        <description>Submitted By info update.</description>
        <field>Submitted_By__c</field>
        <formula>LastModifiedBy.LastName + &quot; &quot; + LastModifiedBy.FirstName</formula>
        <name>Submitted By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_On</fullName>
        <description>Submitted On field update</description>
        <field>Submitted_On__c</field>
        <formula>Now()</formula>
        <name>Submitted On</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_NOFA_Summary</fullName>
        <field>NOFA_Summary__c</field>
        <name>Update NOFA Summary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Name</fullName>
        <field>Name</field>
        <formula>RIGHT(NOFA_Fiscal_Yr__c, 2)+ NOFA_RFP__r.Corporate_Program__r.Short_Code__c+Autonumber1__c</formula>
        <name>Update Record Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Withdrawn_On</fullName>
        <field>Withdrawn_On__c</field>
        <formula>LastModifiedDate</formula>
        <name>Withdrawn On</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Withdrawn_by</fullName>
        <field>Withdrawn_By__c</field>
        <formula>$User.LastName + &quot; &quot; + $User.FirstName</formula>
        <name>Withdrawn by</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>popAppId</fullName>
        <field>Legacy_App_ID__c</field>
        <formula>Name</formula>
        <name>popAppId</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>save_update</fullName>
        <description>When its saved it should be in progress &quot;Grantee Status&quot;.</description>
        <field>Grantee_Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Save update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>status_change_to_submitted_for_applicat</fullName>
        <field>Status__c</field>
        <literalValue>Accepted</literalValue>
        <name>status change  to submitted for applicat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Application Accepted</fullName>
        <actions>
            <name>Application_Accepted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Application3__c.Recommended_Award_Amount__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This is no longer used. Code written in WithdrawApplication class (Line 117)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Application Submitted Info</fullName>
        <actions>
            <name>Submitted_By</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Submitted_On</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application3__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted to CNCS</value>
        </criteriaItems>
        <description>Application Submitted BY and Submitted On Information. 
Rule Criteria changed from &quot;Submitted&quot; to &quot;Submitted to CNCS&quot;. KY</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Application is Created</fullName>
        <actions>
            <name>Application_is_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application3__c.Grantee_Status__c</field>
            <operation>equals</operation>
            <value>Accepted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Application3__c.Status__c</field>
            <operation>equals</operation>
            <value>Accepted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Draft field</fullName>
        <actions>
            <name>Change_Draft_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Change Draft field value from &quot;True&quot; to &quot;False&quot; when Application record is created.</description>
        <formula>$Profile.Name = &quot;System Administrator&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Status Change to Pre-Submitted</fullName>
        <actions>
            <name>Status_Change_to_Pre_Submitted_for_appli</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Application3__c.Grantee_Status__c</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <description>When its  submitted it should be pre-submitted &quot;Grantee Status</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Application</fullName>
        <actions>
            <name>Update_NOFA_Summary</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Record Name</fullName>
        <actions>
            <name>Update_Record_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>popAppId</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpdateDupSubAppAutoNumber</fullName>
        <actions>
            <name>FldUpdate_Dup_Sub_App_Auto_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Prime_Application__c  != null</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Withdraw application</fullName>
        <actions>
            <name>Application_Withdraw</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application3__c.Status__c</field>
            <operation>equals</operation>
            <value>Withdrawn</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Withdrawn Information</fullName>
        <actions>
            <name>Withdrawn_On</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Withdrawn_by</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application3__c.Status__c</field>
            <operation>equals</operation>
            <value>Withdrawn</value>
        </criteriaItems>
        <description>Updated Withdrawn by and Withdrawn date/time on the Application.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>popLegacyAppId</fullName>
        <actions>
            <name>popAppId</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Application3__c.Legacy_App_ID__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>tets</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Application3__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>withdrawapplication</fullName>
        <actions>
            <name>Withdraw_Application</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application3__c.Grantee_Status__c</field>
            <operation>equals</operation>
            <value>Withdrawn</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
