<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>TeamTermination</fullName>
        <field>Team_Terminated_By__c</field>
        <formula>LastModifiedBy.LastName + &apos; &apos; + LastModifiedBy.FirstName</formula>
        <name>TeamTermination</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Terminated_By</fullName>
        <field>Team_Terminated_By__c</field>
        <formula>$User.FirstName + &quot; &quot; + $User.LastName</formula>
        <name>Terminated By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Active feild</fullName>
        <active>false</active>
        <formula>AND( Effective_Date__c &lt;=  TODAY(), OR( End_Date__c == null,End_Date__c &gt;=TODAY()))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Team Terminated By</fullName>
        <actions>
            <name>Terminated_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Team__c.End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Team terminated username</fullName>
        <actions>
            <name>TeamTermination</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>IF( (Reason_No_Longer_in_Use__c != &apos;&apos; || Reason_No_Longer_in_Use__c != null) &amp;&amp;  ISCHANGED(Reason_No_Longer_in_Use__c)  ,  true, false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
