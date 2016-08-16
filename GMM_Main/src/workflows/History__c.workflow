<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>User Account</fullName>
        <active>false</active>
        <criteriaItems>
            <field>History__c.Area_of_Expertise__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>History__c.Expertise__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
