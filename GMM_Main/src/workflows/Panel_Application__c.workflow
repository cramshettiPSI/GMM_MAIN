<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Panel_Id_Application_Id_Update</fullName>
        <field>Panel_Id_Application_Id__c</field>
        <formula>Paneling__c  + Application__c</formula>
        <name>Panel Id Application Id Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Panel Id Application Id</fullName>
        <actions>
            <name>Panel_Id_Application_Id_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
