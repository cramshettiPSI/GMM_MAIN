<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>NOFO_Status_Update_frm_Action_Reports</fullName>
        <field>Status__c</field>
        <literalValue>Setup in Progress</literalValue>
        <name>NOFO Status Update frm Action Reports</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>NOFA_ID__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open_to_Apps_Update_frm_Action_Reports</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>0</literalValue>
        <name>Open to Apps Update frm Action Reports</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>NOFA_ID__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Update Nofo Frm Action Report</fullName>
        <actions>
            <name>NOFO_Status_Update_frm_Action_Reports</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Open_to_Apps_Update_frm_Action_Reports</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( NOT(ISNEW() ),   ISPICKVAL(NOFA_ID__r.Status__c,&apos;Finalized&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
