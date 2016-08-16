<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>NOFO_approval</fullName>
        <description>NOFO approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>cmonson@cns.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pdavis@cns.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>wschmitt@cns.gov</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/NOFO_sumbit</template>
    </alerts>
    <fieldUpdates>
        <fullName>Allow_Prime_Applicant</fullName>
        <field>RecordTypeId</field>
        <lookupValue>State_Commission</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Allow Prime Applicant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>Status__c</field>
        <literalValue>Finalized</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type</fullName>
        <description>Change Record Type to &quot;NOFA Application&quot;.</description>
        <field>RecordTypeId</field>
        <lookupValue>NOFA_Application</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_Intent</fullName>
        <field>RecordTypeId</field>
        <lookupValue>NOFA_Intent_to_Apply</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_Intent_NOFA</fullName>
        <field>RecordTypeId</field>
        <lookupValue>NOFO</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type_Intent_NOFA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_for_NOFA</fullName>
        <field>RecordTypeId</field>
        <lookupValue>NOFA_Intent_to_Apply</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type for NOFA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CheckboxTrue</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>1</literalValue>
        <name>CheckboxTrue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CheckboxUpdate</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>0</literalValue>
        <name>CheckboxUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FieldUpdate_Nofa_Ready_For_Ranking</fullName>
        <description>Updates Field &quot;Ready For Ranking&quot; if &quot;SubApplication Due Date&quot; &lt; Today</description>
        <field>Ready_for_Ranking__c</field>
        <literalValue>Yes</literalValue>
        <name>FieldUpdate Nofa Ready for Ranking</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FinalizeStatus</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Finalize_Status</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>FinalizeStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FinalizeStatusFreeze</fullName>
        <field>Status__c</field>
        <literalValue>Finalized</literalValue>
        <name>FinalizeStatusFreeze</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open_for_application_End_Date</fullName>
        <description>Unchecks when RFP ebd date is less than current date</description>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>0</literalValue>
        <name>Open for application End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open_for_application_End_Dates</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>0</literalValue>
        <name>Open for application End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open_for_application_Start_Date</fullName>
        <description>Checks after the RFP Start Date</description>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>1</literalValue>
        <name>Open for application Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open_for_application_Start_Dates</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>1</literalValue>
        <name>Open for application Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open_for_applications</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>1</literalValue>
        <name>Open for applications</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Past_Application_Due_Date</fullName>
        <field>Past_Application_Due_Date__c</field>
        <literalValue>1</literalValue>
        <name>Past Application Due Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RFP_Status_Closed</fullName>
        <field>RFP_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>RFP Status - Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RFP_Status_False</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>0</literalValue>
        <name>RFP Status - False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RFP_Status_In_Progress</fullName>
        <field>RFP_Status__c</field>
        <literalValue>In-Progress</literalValue>
        <name>RFP Status - In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RFP_Status_Open_to_Applications</fullName>
        <field>RFP_Status__c</field>
        <literalValue>Open to Applicants</literalValue>
        <name>RFP Status - Open to Applications</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RFP_Status_True</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>1</literalValue>
        <name>RFP Status - True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RFP_Status_Update</fullName>
        <field>RFP_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>RFP Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RFP_Status_Update_2</fullName>
        <field>RFP_Status__c</field>
        <literalValue>Open to Applicants</literalValue>
        <name>RFP Status Update 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recall_action</fullName>
        <field>Status__c</field>
        <literalValue>Set up in Progress</literalValue>
        <name>Recall action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record</fullName>
        <field>RecordTypeId</field>
        <lookupValue>NOFA_Concept_Paper</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reject</fullName>
        <field>Status__c</field>
        <literalValue>Returned for Rework</literalValue>
        <name>Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Return_for_Rework_update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Return_for_Rework</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Return for Rework update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Review</fullName>
        <field>Status__c</field>
        <literalValue>Review in Progress</literalValue>
        <name>Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Open_for_Applications_to_False</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>0</literalValue>
        <name>Set Open for Applications to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Change</fullName>
        <field>RFP_Status__c</field>
        <literalValue>Open to Applicants</literalValue>
        <name>Status Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Change1</fullName>
        <field>RFP_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Status Change1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateStatus</fullName>
        <field>Status__c</field>
        <literalValue>Set up in Progress</literalValue>
        <name>UpdateStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Open_for_Applications</fullName>
        <field>NOFA_Active_Inactive__c</field>
        <literalValue>1</literalValue>
        <name>Update Open for Applications</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>popNOFAId</fullName>
        <field>Legacy_NOFA_ID__c</field>
        <formula>VALUE( NOFA_Sequence__c )</formula>
        <name>popNOFAId</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Allow Application</fullName>
        <actions>
            <name>Change_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Allow_Concept_Paper__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>When &quot;Allow Concept Paper&quot; is &quot;No&quot;, change the Record Type to &quot;NOFA Application&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Allow concept paper</fullName>
        <actions>
            <name>Record</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>When &quot;Allow Concept Paper&quot; is &quot;Yes&quot;, change the Record Type to &quot;NOFA Concept Paper&quot;.</description>
        <formula>AND( ISPICKVAL(Allow_Concept_Paper__c,&apos;Yes&apos;), RecordType.Name != &quot;RFP&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CV Workflow Test</fullName>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Status__c</field>
            <operation>equals</operation>
            <value>Finalized</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Set_Open_for_Applications_to_False</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>NOFA__c.Applications_due_date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Change Record Type for NOFA</fullName>
        <actions>
            <name>Change_Record_Type_for_NOFA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Change the Record Type of NOFA when &quot;Intent to Apply Required?&quot; field contains &apos;Optional&apos; or &apos;Required&apos; values.</description>
        <formula>OR(ISPICKVAL (Notification_of_Intent_to_Apply_Required__c , &apos;Optional&apos;),  ISPICKVAL (Notification_of_Intent_to_Apply_Required__c , &apos;Required&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type_Intent_NOFA</fullName>
        <actions>
            <name>Change_Record_Type_Intent_NOFA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NOFA__c.Notification_of_Intent_to_Apply_Required__c</field>
            <operation>contains</operation>
            <value>Not Applicable</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>FinalizeStatus</fullName>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Status__c</field>
            <operation>equals</operation>
            <value>Finalized</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FinalizeStatusChange</fullName>
        <actions>
            <name>CheckboxUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateStatus</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( 

AND(ISPICKVAL(PRIORVALUE(Status__c),&quot;Finalized&quot;),NOT(NOFA_Active_Inactive__c),NOT( $Profile.Name = &apos;System Administrator&apos;)), 

AND(ISPICKVAL(PRIORVALUE(Status__c),&quot;Finalized&quot;), PRIORVALUE(NOFA_Active_Inactive__c),NOFA_Active_Inactive__c,NOT( $Profile.Name = &apos;System Administrator&apos;))

)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>If concept is required</fullName>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Allow_Concept_Paper__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>KeepStatusFinalized</fullName>
        <actions>
            <name>CheckboxTrue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>FinalizeStatusFreeze</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Status__c</field>
            <operation>equals</operation>
            <value>Finalized</value>
        </criteriaItems>
        <criteriaItems>
            <field>NOFA__c.NOFA_Active_Inactive__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification Required</fullName>
        <actions>
            <name>Change_Record_Type_Intent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Notification_of_Intent_to_Apply_Required__c</field>
            <operation>contains</operation>
            <value>Required,Optional</value>
        </criteriaItems>
        <description>Change the Record Type of NOFA to NOFA - &quot;Intent to Apply&quot; when the Notification of Intent to Apply is &quot;Required&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Open for application End Date</fullName>
        <actions>
            <name>RFP_Status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>RFP</value>
        </criteriaItems>
        <criteriaItems>
            <field>NOFA__c.RFP_End_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Uncheck when RFP End date is less than current date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Open_for_application_End_Dates</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>NOFA__c.RFP_End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Open for application Start Date</fullName>
        <actions>
            <name>RFP_Status_Update_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>RFP</value>
        </criteriaItems>
        <criteriaItems>
            <field>NOFA__c.RFP_Start_Date__c</field>
            <operation>lessOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Check when RFP start Date is greater than Current Date</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Open_for_application_Start_Dates</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>NOFA__c.RFP_Start_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Past Application Due Date</fullName>
        <actions>
            <name>Past_Application_Due_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Check &quot;Past Application Due Date&quot; checkbox on NOFO once the Application Due Date is past.</description>
        <formula>Applications_due_date__c &lt; Today()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Program Name</fullName>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>RFP Status - Closed</fullName>
        <actions>
            <name>RFP_Status_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NOFA__c.RFP_End_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>RFP_Status_False</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>NOFA__c.RFP_End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>RFP Status - In Progress</fullName>
        <actions>
            <name>RFP_Status_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NOFA__c.RFP_Start_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>RFP Status - Open to Applications</fullName>
        <actions>
            <name>RFP_Status_Open_to_Applications</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NOFA__c.RFP_Start_Date__c</field>
            <operation>lessOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>NOFA__c.RFP_End_Date__c</field>
            <operation>greaterOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>RFP_Status_True</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>NOFA__c.RFP_Start_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>RFP Status Change</fullName>
        <actions>
            <name>Status_Change</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.RFP_Start_Date__c</field>
            <operation>greaterOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>RFP Status Change1</fullName>
        <actions>
            <name>Status_Change1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.RFP_End_Date__c</field>
            <operation>lessOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update NOFA Name</fullName>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update NOFA Ready For Ranking</fullName>
        <actions>
            <name>FieldUpdate_Nofa_Ready_For_Ranking</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Sub_Application_Due_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Rule Criteria is  &quot;SubApplication  Due Date&quot;  &lt; Today</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Parent NOFA ID</fullName>
        <active>false</active>
        <formula>$User.ProfileId  = &quot;00et0000000U7wf&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>UpdateNOFOFinalize</fullName>
        <actions>
            <name>FinalizeStatus</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NOFA__c.Status__c</field>
            <operation>equals</operation>
            <value>Finalized</value>
        </criteriaItems>
        <criteriaItems>
            <field>NOFA__c.NOFA_Active_Inactive__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpdateNOFOStatus</fullName>
        <actions>
            <name>Return_for_Rework_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 and 2</booleanFilter>
        <criteriaItems>
            <field>NOFA__c.Status__c</field>
            <operation>equals</operation>
            <value>Review in Progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>NOFA__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>RFP</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>popLegacyNOFAId</fullName>
        <actions>
            <name>popNOFAId</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>NOFA__c.Name</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
