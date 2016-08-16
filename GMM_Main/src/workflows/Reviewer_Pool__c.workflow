<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>confrmed</fullName>
        <description>Reviewer Availability Noted</description>
        <protected>false</protected>
        <recipients>
            <recipient>Administrator</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pre_Submiited</template>
    </alerts>
    <rules>
        <fullName>%22Pre-Confirmed</fullName>
        <actions>
            <name>confrmed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Reviewer_Pool__c.Status__c</field>
            <operation>equals</operation>
            <value>Pre-Confirmed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
