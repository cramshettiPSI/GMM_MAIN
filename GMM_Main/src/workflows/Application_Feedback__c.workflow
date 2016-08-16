<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Application_Feedback_Form_Submission_Notification</fullName>
        <description>Application Feedback Form Submission Notification</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Application_Feedback_Submission_notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Panel_Coordinator</fullName>
        <description>Send Email to Panel Coordinator</description>
        <protected>false</protected>
        <recipients>
            <field>Panel_Coordinator__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Feedback_Review</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Staff_Liaison</fullName>
        <description>Send Email to Staff Liaison</description>
        <protected>false</protected>
        <recipients>
            <field>Staff_Liaison__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Feedback_Review</template>
    </alerts>
    <rules>
        <fullName>AppFeedBack Notification From PC</fullName>
        <actions>
            <name>Send_Email_to_Staff_Liaison</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED(Status__c ) &amp;&amp; ISPICKVAL(Status__c , &apos;Submitted&apos;) &amp;&amp; ( LastModifiedBy.FirstName+&apos; &apos;+ LastModifiedBy.LastName ==  Panel_Coordinator__r.FirstName+&apos; &apos;+Panel_Coordinator__r.LastName) &amp;&amp;  Staff_Liaison__c &lt;&gt; null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppFeedback PC Notification</fullName>
        <actions>
            <name>Send_Email_to_Panel_Coordinator</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>Panel_Coordinator__c  &lt;&gt; null &amp;&amp;  ISCHANGED(Status__c) &amp;&amp; ISPICKVAL(Status__c  , &apos;Submitted&apos;) &amp;&amp;  LastModifiedBy.Profile.Name == &apos;Expert Reviewers&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppFeedback SL Notification</fullName>
        <actions>
            <name>Send_Email_to_Staff_Liaison</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>Staff_Liaison__c &lt;&gt; null &amp;&amp; Panel_Coordinator__c = null &amp;&amp; ISCHANGED(Status__c) &amp;&amp; ISPICKVAL(Status__c , &apos;Submitted&apos;) &amp;&amp; LastModifiedBy.Profile.Name == &apos;Expert Reviewers&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppFeedback SL Notification After PC Accepts</fullName>
        <actions>
            <name>Send_Email_to_Staff_Liaison</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>Accepted_by_Panel_Coordinator__c  &amp;&amp;  Staff_Liaison__c &lt;&gt; null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Application Feedback submission notification</fullName>
        <actions>
            <name>Application_Feedback_Form_Submission_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application_Feedback__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
