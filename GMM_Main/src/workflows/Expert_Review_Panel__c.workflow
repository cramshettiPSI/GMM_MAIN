<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>New Task for Aapplication Feedback</fullName>
        <actions>
            <name>Panel_Assignment</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <formula>Panel_Member__r.Active__c = True</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Panel_Assignment</fullName>
        <assignedTo>Expert_Reviewers</assignedTo>
        <assignedToType>role</assignedToType>
        <description>An Application Feedback form has been assigned to you. Click the Related To hyperlink within this task to view the form</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Expert Review Panel Assignment</subject>
    </tasks>
</Workflow>
