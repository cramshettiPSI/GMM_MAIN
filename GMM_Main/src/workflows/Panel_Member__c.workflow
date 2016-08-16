<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_an_email_alert_when_reviewer_is_added_to_panel_member</fullName>
        <description>Send an email alert when reviewer is added to panel member</description>
        <protected>false</protected>
        <recipients>
            <field>Expert_Reviewer__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Reviewer_adding_to_Panel_Member</template>
    </alerts>
    <fieldUpdates>
        <fullName>Panel_Member_Active</fullName>
        <field>Active__c</field>
        <literalValue>1</literalValue>
        <name>Panel Member Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Adding Panel Memebr</fullName>
        <actions>
            <name>Send_an_email_alert_when_reviewer_is_added_to_panel_member</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Panel_Member__c.Active__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Panel Member Active</fullName>
        <actions>
            <name>Panel_Member_Active</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Panel_Member__c.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
