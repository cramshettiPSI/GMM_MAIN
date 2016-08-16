<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Date_GO_Completed_Update</fullName>
        <description>Update GO Completed Date when Status = Assessment Completed or GO/PO Assessment Complete (VISTA only)</description>
        <field>Date_GO_Completed__c</field>
        <formula>TODAY()</formula>
        <name>Date GO Completed Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Assessment_Number</fullName>
        <field>Assessment_Number__c</field>
        <formula>Assessment_Number__c + 1</formula>
        <name>Update Assessment Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Assessment Number</fullName>
        <actions>
            <name>Update_Assessment_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Updates Assessment Number each time the record is edited.</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Date GO Completed field</fullName>
        <actions>
            <name>Date_GO_Completed_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Monitoring_Assessment__c.Status__c</field>
            <operation>equals</operation>
            <value>Assessment Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Monitoring_Assessment__c.Status__c</field>
            <operation>equals</operation>
            <value>GO/PO Assessment Complete (VISTA only)</value>
        </criteriaItems>
        <description>Updates the Date GO Completed field when the Status = GO Assessment Complete, or GO/PO Assessment Complete (VISTA only)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
