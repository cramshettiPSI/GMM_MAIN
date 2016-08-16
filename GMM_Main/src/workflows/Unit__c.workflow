<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Terminated_By</fullName>
        <field>Unit_Terminated_By1__c</field>
        <formula>$User.FirstName + &quot; &quot; + $User.LastName</formula>
        <name>Terminated By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Unit_Name</fullName>
        <field>Unit_Name__c</field>
        <formula>UPPER(LEFT(Unit_Name__c, 1)) &amp;
MID(Unit_Name__c, 2, LEN(Unit_Name__c))</formula>
        <name>Unit Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Capitalize Unit Name</fullName>
        <actions>
            <name>Unit_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Capitalize the first letter of the Unit Name</description>
        <formula>AND(     NOT(ISBLANK(Unit_Name__c)),     OR(         ISNEW(),         ISCHANGED(Unit_Name__c)     ),     LEFT(Unit_Name__c, 1) &lt;&gt; UPPER(LEFT(Unit_Name__c, 1)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Terminated by User</fullName>
        <actions>
            <name>Terminated_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Unit__c.End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
