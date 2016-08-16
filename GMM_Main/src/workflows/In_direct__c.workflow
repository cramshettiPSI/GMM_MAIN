<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Value_10</fullName>
        <field>Rate_Percent__c</field>
        <formula>0.1</formula>
        <name>Update Value 10</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Update Ten on Rate Percent</fullName>
        <actions>
            <name>Update_Value_10</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>In_direct__c.Rate_Type__c</field>
            <operation>equals</operation>
            <value>10%Modified Total Direct Cost (MTDC)</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
