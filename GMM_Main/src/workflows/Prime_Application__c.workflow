<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>FieldUpdate_PrmApp_Ready_for_Ranking</fullName>
        <description>Updates Field &quot;Ready For Ranking&quot; if &quot;SubApplication Due Date&quot; &lt; Today</description>
        <field>Ready_for_Ranking__c</field>
        <literalValue>Yes</literalValue>
        <name>FieldUpdate PrmApp Ready for Ranking</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Name</fullName>
        <field>Prime_Application_ID_Number__c</field>
        <formula>RIGHT( Text(NOFO_RFP__r.Fiscal_Yr__c), 2)+  NOFO_RFP__r.Corporate_Program__r.Short_Code__c + AutoNumber__c</formula>
        <name>Update Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Standard_Name</fullName>
        <field>Name</field>
        <formula>RIGHT( Text(NOFO_RFP__r.Fiscal_Yr__c), 2)+ NOFO_RFP__r.Corporate_Program__r.Short_Code__c + AutoNumber__c</formula>
        <name>Update Standard Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Record Name</fullName>
        <actions>
            <name>Update_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Standard_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>UpdatePrmAppReadyForRanking</fullName>
        <actions>
            <name>FieldUpdate_PrmApp_Ready_for_Ranking</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Prime_Application__c.Sub_Application_Due_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Rule Criteria is  &quot;SubApplication  Due Date&quot;  &lt; Today</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
