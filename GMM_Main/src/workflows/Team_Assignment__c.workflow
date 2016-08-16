<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>NCCC_Members_are_reduced_or_removed</fullName>
        <description>NCCC Members are reduced or removed</description>
        <protected>false</protected>
        <recipients>
            <field>Applicant_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_if_members_are_reduced_or_removed</template>
    </alerts>
    <alerts>
        <fullName>Team_has_been_assigned_to_a_sponser</fullName>
        <description>Team has been assigned to a sponser</description>
        <protected>false</protected>
        <recipients>
            <field>Applicant_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Team_has_been_assigned</template>
    </alerts>
    <alerts>
        <fullName>Team_is_cancelled_or_team_members_are_removed</fullName>
        <description>Team is cancelled or team members are removed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mrapur2@plan-sys.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_if_members_are_reduced_or_removed</template>
    </alerts>
    <alerts>
        <fullName>test</fullName>
        <ccEmails>smandra@plan-sys.com</ccEmails>
        <description>test</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Team_has_been_assigned</template>
    </alerts>
    <alerts>
        <fullName>test1</fullName>
        <ccEmails>smandra@plan-sys.com</ccEmails>
        <description>test1</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Team_has_been_assigned</template>
    </alerts>
    <fieldUpdates>
        <fullName>UpdateEmail</fullName>
        <description>Updates the Applicant Email with the Recipient Email</description>
        <field>Applicant_Email__c</field>
        <formula>Award__r.Application_ID__r.Authorized_Representative__r.Emails__c</formula>
        <name>UpdateEmail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Email</fullName>
        <field>Applicant_Email__c</field>
        <formula>Award__r.Application_ID__r.Authorized_Representative__r.Emails__c</formula>
        <name>Updates Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>NCCC grantee cancelled or members removed</fullName>
        <actions>
            <name>NCCC_Members_are_reduced_or_removed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Updates_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Send an email to the grantee when the team members are cancelled or removed</description>
        <formula>PRIORVALUE(Number_of_Members__c) &gt; Number_of_Members__c ||  Cancelled__c  = TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>TESt12</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Team_Assignment__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Team assigned to the sponsor</fullName>
        <actions>
            <name>Team_has_been_assigned_to_a_sponser</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>UpdateEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Team_Assignment__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>Send an email to the grantee when a team is assigned to the grantee</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Team_Assignment__c.CreatedDate</offsetFromField>
            <timeLength>24</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Test</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Award__c.Project_Name__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
