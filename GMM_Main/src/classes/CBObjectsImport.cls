public class CBObjectsImport {
    public static void importObjects(String resourceName) {
        String logMessage='';
        try {
            StaticResource sr = [SELECT Body FROM StaticResource WHERE Name =: resourceName LIMIT 1];
            String body = sr.Body.toString();
            Map<String,cb3__Organization__c> budgetsMap = new Map<String,cb3__Organization__c>();
            Map<String,cb3__Organization__c> unitsMap = new Map<String,cb3__Organization__c>();
            Map<String,cb3__Organization__c> locationsMap = new Map<String,cb3__Organization__c>();
            Map<String,cb3__Account_class__c> accountsMap = new Map<String,cb3__Account_class__c>();
            Map<String,cb3__Budget_Settings__c> budgetSettingsMap = new Map<String,cb3__Budget_Settings__c>();
            Map<String,cb3__BASection1Level__c> settings1Map = new Map<String,cb3__BASection1Level__c>();
            Map<String,cb3__BASection2Level__c> settings2Map = new Map<String,cb3__BASection2Level__c>();
            Map<String,cb3__BASection3Level__c> settings3Map = new Map<String,cb3__BASection3Level__c>();
            List<String> importedObjectTypes = body.split('--object--');
            List<String> importedBudgetSettings = importedObjectTypes.get(0).split('\n');
            List<String> importedSettings1 = importedObjectTypes.get(1).split('\n');
            List<String> importedSettings2 = importedObjectTypes.get(2).split('\n');
            List<String> importedSettings3 = importedObjectTypes.get(3).split('\n');
            List<String> importedDescrioptionItems = importedObjectTypes.get(4).split('\n');
            List<String> importedRelatedAccounts = importedObjectTypes.get(5).split('\n');
            List<String> importedRelatedAmounts = importedObjectTypes.get(6).split('\n');
            List<String> importedBudgets = importedObjectTypes.get(7).split('\n');
            List<String> importedUnits = importedObjectTypes.get(8).split('\n');
            List<String> importedLocations = importedObjectTypes.get(9).split('\n');
            List<String> importedAccounts = importedObjectTypes.get(10).split('\n');
            for(String currentRecord: importedBudgets) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                cb3__Organization__c newRecord = new cb3__Organization__c(name = recordFields.get(1)=='null'?null:recordFields.get(1),
                cb3__ImportRCImmediately__c=recordFields.get(2)=='null'?null:Boolean.valueOf(recordFields.get(2)),
                cb3__CRMAccounts__c=recordFields.get(3)=='null'?null:Boolean.valueOf(recordFields.get(3)), 
                cb3__Active__c = recordFields.get(4)=='null'?null:Boolean.valueOf(recordFields.get(4)),
                cb3__Start__c=recordFields.get(5)=='null'?null:Date.valueOf(recordFields.get(5)),
                cb3__Periods__c=recordFields.get(6)=='null'?null:recordFields.get(6),
                cb3__IntegrateFF__c=recordFields.get(8)=='null'?null:Boolean.valueOf(recordFields.get(8)), 
                cb3__DeadlineToSubmit__c=recordFields.get(9)=='null'?null:Date.valueOf(recordFields.get(9)),
                cb3__DeadlineToApprove__c=recordFields.get(10)=='null'?null:Date.valueOf(recordFields.get(10)),
                cb3__discriminator__c = 'organization',
                cb3__CFO__c=System.UserInfo.getUserId());
                budgetsMap.put(recordFields.get(0), newRecord);
            }
            insert budgetsMap.values();
            for(String currentRecord: importedUnits) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                cb3__Organization__c newRecord = new cb3__Organization__c(name=recordFields.get(1)=='null'?null:recordFields.get(1),
                cb3__Industry__c=recordFields.get(3)=='null'?null:recordFields.get(3),
                cb3__Wage__c=recordFields.get(4)=='null'?null:Boolean.valueOf(recordFields.get(4)),
                cb3__Multicurrency__c=recordFields.get(5)=='null'?null:Boolean.valueOf(recordFields.get(5)),
                cb3__Periods__c=recordFields.get(6)=='null'?null:recordFields.get(6),
                cb3__WageToExpensesEnabled__c=recordFields.get(7)=='null'?null:Boolean.valueOf(recordFields.get(7)),
                cb3__Parent__c=recordFields.get(8)=='null'?null:budgetsMap.get(recordFields.get(8)).Id,
                cb3__discriminator__c = 'unit',
                cb3__CFO__c=System.UserInfo.getUserId());
                unitsMap.put(recordFields.get(0), newRecord);
            }
            insert unitsMap.values();
            for(String currentRecord: importedLocations) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                cb3__Organization__c newRecord = new cb3__Organization__c(name=recordFields.get(1)=='null'?null:recordFields.get(1),
                cb3__Iterator__c=recordFields.get(2)=='null'?null:Decimal.valueOf(recordFields.get(2)),
                cb3__Parent__c=recordFields.get(3)=='null'?null:unitsMap.get(recordFields.get(3)).Id,
                cb3__discriminator__c = 'location');
                locationsMap.put(recordFields.get(0), newRecord);
            }   
            insert locationsMap.values();
            for(String currentRecord: importedAccounts) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                cb3__Account_class__c newRecord = new cb3__Account_class__c(name=recordFields.get(1)=='null'?null:recordFields.get(1),
                cb3__GLA__c=recordFields.get(2)=='null'?null:recordFields.get(2),
                cb3__Required__c=recordFields.get(3)=='null'?null:Boolean.valueOf(recordFields.get(3)),
                cb3__Type__c=recordFields.get(4)=='null'?null:recordFields.get(4),
                cb3__Units__c=recordFields.get(5)=='null'?null:recordFields.get(5),
                cb3__Subtype__c=recordFields.get(6)=='null'?null:recordFields.get(6),
                cb3__Default__c=recordFields.get(7)=='null'?null:Boolean.valueOf(recordFields.get(7)),
                cb3__Active__c=recordFields.get(8)=='null'?null:Boolean.valueOf(recordFields.get(8)),
                cb3__Ident__c=recordFields.get(9)=='null'?null:recordFields.get(9),
                cb3__Description__c=recordFields.get(10)=='null'?null:recordFields.get(10),
                cb3__Other__c=recordFields.get(11)=='null'?null:Boolean.valueOf(recordFields.get(11)),
                cb3__Organization__c=recordFields.get(12)=='null'?null:unitsMap.get(recordFields.get(12)).Id);
                accountsMap.put(recordFields.get(0), newRecord);
            }
            insert accountsMap.values();
            List<cb3__Budget_Settings__c> newBudgetSettings = new List<cb3__Budget_Settings__c>();
            for(String currentRecord: importedBudgetSettings) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                cb3__Budget_Settings__c newRecord = new cb3__Budget_Settings__c(cb3__AP1AllocationDifference__c=recordFields.get(2)=='null'?null:Boolean.valueOf(recordFields.get(2)),
                cb3__AP2AllocationDifference__c=recordFields.get(3)=='null'?null:Boolean.valueOf(recordFields.get(3)),
                cb3__AP3AllocationDifference__c=recordFields.get(4)=='null'?null:Boolean.valueOf(recordFields.get(4)),
                cb3__AP4AllocationDifference__c=recordFields.get(5)=='null'?null:Boolean.valueOf(recordFields.get(5)),
                cb3__Business_Unit__c=recordFields.get(6)=='null'?null:unitsMap.get(recordFields.get(6)).Id,
                cb3__CB_AP_Account_1__c=recordFields.get(7)=='null'?null:accountsMap.get(recordFields.get(7)).Id,
                cb3__CB_AP_Account_2__c=recordFields.get(8)=='null'?null:accountsMap.get(recordFields.get(8)).Id,
                cb3__CB_AP_Account_3__c=recordFields.get(9)=='null'?null:accountsMap.get(recordFields.get(9)).Id,
                cb3__CB_AP_Account_4__c=recordFields.get(10)=='null'?null:accountsMap.get(recordFields.get(10)).Id,
                cb3__Column_1_Name__c=recordFields.get(11)=='null'?null:recordFields.get(11),
                cb3__Column_2_Name__c=recordFields.get(12)=='null'?null:recordFields.get(12),
                cb3__Column_3_Name__c=recordFields.get(13)=='null'?null:recordFields.get(13),
                cb3__Column_4_Name__c=recordFields.get(14)=='null'?null:recordFields.get(14),
                cb3__Title__c=recordFields.get(15)=='null'?null:recordFields.get(15),
                cb3__Description__c=recordFields.get(16)=='null'?null:recordFields.get(16),
                cb3__CNCS_Column__c=recordFields.get(17)=='null'?null:recordFields.get(17),
                cb3__Grantee_Share_Column__c=recordFields.get(18)=='null'?null:recordFields.get(18),
                cb3__CostMatch__c=recordFields.get(19)=='null'?null:Decimal.valueOf(recordFields.get(19)));
                budgetSettingsMap.put(recordFields.get(0), newRecord);
                newBudgetSettings.add(newRecord);
            }
            insert newBudgetSettings;
            List<cb3__BASection1Level__c> newSettings1 = new List<cb3__BASection1Level__c>();
            for(String currentRecord: importedSettings1) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                cb3__BASection1Level__c newRecord = new cb3__BASection1Level__c(cb3__SectionName__c=recordFields.get(2)=='null'?null:recordFields.get(2),
                cb3__Budget_Application_Settings__c=recordFields.get(3)=='null'?null:budgetSettingsMap.get(recordFields.get(3)).Id);
                settings1Map.put(recordFields.get(0), newRecord);
                newSettings1.add(newRecord);
            }
            insert newSettings1;
            List<cb3__BASection2Level__c> newSettings2 = new List<cb3__BASection2Level__c>();
            for(String currentRecord: importedSettings2) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                cb3__BASection2Level__c newRecord = new cb3__BASection2Level__c(cb3__SectionName__c=recordFields.get(2)=='null'?null:recordFields.get(2),
                cb3__basection1level__c=recordFields.get(3)=='null'?null:settings1Map.get(recordFields.get(3)).Id);
                settings2Map.put(recordFields.get(0), newRecord);
                newSettings2.add(newRecord);
            }
            insert newSettings2;
            List<cb3__BASection3Level__c> newSettings3 = new List<cb3__BASection3Level__c>();
            for(String currentRecord: importedSettings3) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                cb3__BASection3Level__c newRecord = new cb3__BASection3Level__c(cb3__SectionName__c=recordFields.get(2)=='null'?null:recordFields.get(2),
                cb3__Type__c=recordFields.get(3)=='null'?null:recordFields.get(3),
                cb3__Lower_Bound__c=recordFields.get(4)=='null'?null:Decimal.valueOf(recordFields.get(4)),
                cb3__Upper_Bound__c=recordFields.get(5)=='null'?null:Decimal.valueOf(recordFields.get(5)),
                cb3__BASection2Level__c=recordFields.get(6)=='null'?null:settings2Map.get(recordFields.get(6)).Id,
                cb3__DescriptionColumnName__c=recordFields.get(7)=='null'?null:recordFields.get(7),
                cb3__Description2ColumnName__c=recordFields.get(8)=='null'?null:recordFields.get(8),
                cb3__RateColumnName__c=recordFields.get(9)=='null'?null:recordFields.get(9),
                cb3__AmountColumnName__c=recordFields.get(10)=='null'?null:recordFields.get(10),
                cb3__PercentageColumnName__c=recordFields.get(11)=='null'?null:recordFields.get(11),
                cb3__Col1Name__c=recordFields.get(12)=='null'?null:recordFields.get(12),
                cb3__Col2Name__c=recordFields.get(13)=='null'?null:recordFields.get(13),
                cb3__Col3Name__c=recordFields.get(14)=='null'?null:recordFields.get(14),
                cb3__Col4Name__c=recordFields.get(15)=='null'?null:recordFields.get(15),
                cb3__RateLB__c=recordFields.get(16)=='null'?null:Decimal.valueOf(recordFields.get(16)),
                cb3__RateUB__c=recordFields.get(17)=='null'?null:Decimal.valueOf(recordFields.get(17)),
                cb3__AmountLB__c=recordFields.get(18)=='null'?null:Decimal.valueOf(recordFields.get(18)),
                cb3__AmountUB__c=recordFields.get(19)=='null'?null:Decimal.valueOf(recordFields.get(19)),
                cb3__PercentageLB__c=recordFields.get(20)=='null'?null:Decimal.valueOf(recordFields.get(20)),
                cb3__PercentageUB__c=recordFields.get(21)=='null'?null:Decimal.valueOf(recordFields.get(21)),
                cb3__Col1LB__c=recordFields.get(22)=='null'?null:Decimal.valueOf(recordFields.get(22)),
                cb3__Col1UB__c=recordFields.get(23)=='null'?null:Decimal.valueOf(recordFields.get(23)),
                cb3__Col2LB__c=recordFields.get(24)=='null'?null:Decimal.valueOf(recordFields.get(24)),
                cb3__Col2UB__c=recordFields.get(25)=='null'?null:Decimal.valueOf(recordFields.get(25)),
                cb3__Col3LB__c=recordFields.get(26)=='null'?null:Decimal.valueOf(recordFields.get(26)),
                cb3__Col3UB__c=recordFields.get(27)=='null'?null:Decimal.valueOf(recordFields.get(27)),
                cb3__UserLinesAllowed__c=recordFields.get(28)=='null'?null:Boolean.valueOf(recordFields.get(28)),
                cb3__IndirectPercentageLB__c=recordFields.get(29)=='null'?null:Decimal.valueOf(recordFields.get(29)),
                cb3__IndirectPercentageUB__c=recordFields.get(30)=='null'?null:Decimal.valueOf(recordFields.get(30)),
                cb3__PreDefinedLinesAllowed__c=recordFields.get(31)=='null'?null:Boolean.valueOf(recordFields.get(31)),
                cb3__DescriptionAllowed__c=recordFields.get(32)=='null'?null:Boolean.valueOf(recordFields.get(32)),
                cb3__Column1Available__c=recordFields.get(33)=='null'?null:Boolean.valueOf(recordFields.get(33)),
                cb3__Column2Available__c=recordFields.get(34)=='null'?null:Boolean.valueOf(recordFields.get(34)),
                cb3__Column3Available__c=recordFields.get(35)=='null'?null:Boolean.valueOf(recordFields.get(35)),
                cb3__Column4Available__c=recordFields.get(36)=='null'?null:Boolean.valueOf(recordFields.get(36)),
                cb3__OnlyTotalLB__c=recordFields.get(37)=='null'?null:Decimal.valueOf(recordFields.get(37)),
                cb3__OnlyTotalUB__c=recordFields.get(38)=='null'?null:Decimal.valueOf(recordFields.get(38)),
                cb3__OnlyTotalColumnName__c=recordFields.get(39)=='null'?null:recordFields.get(39),
                cb3__isMembers__c=recordFields.get(40)=='null'?null:Boolean.valueOf(recordFields.get(40)));
                settings3Map.put(recordFields.get(0), newRecord);
                newSettings3.add(newRecord);
            }
            insert newSettings3;
            List<cb3__BADescriptionItem__c> newDescriptionItems = new List<cb3__BADescriptionItem__c>();
            for(String currentRecord: importedDescrioptionItems) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                newDescriptionItems.add(new cb3__BADescriptionItem__c(name=recordFields.get(1)=='null'?null:recordFields.get(1),
                cb3__BASection3Level__c=recordFields.get(2)=='null'?null:settings3Map.get(recordFields.get(2)).Id, 
                cb3__Description__c=recordFields.get(3)=='null'?null:recordFields.get(3)));
            }
            insert newDescriptionItems;
            List<cb3__RelatedAccount__c> newRelatedAccounts = new List<cb3__RelatedAccount__c>();
            for(String currentRecord: importedRelatedAccounts) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                newRelatedAccounts.add(new cb3__RelatedAccount__c(cb3__Account_Class__c=recordFields.get(2)=='null'?null:accountsMap.get(recordFields.get(2)).Id,
                cb3__Budget_Application_Section_3rd_Level__c=recordFields.get(3)=='null'?null:settings3Map.get(recordFields.get(3)).Id,
                cb3__SeniorCorpPosition__c=recordFields.get(5)=='null'?null:Boolean.valueOf(recordFields.get(5)),
                cb3__Type__c=recordFields.get(6)=='null'?null:recordFields.get(6),
                cb3__Percentage__c=recordFields.get(7)=='null'?null:Decimal.valueOf(recordFields.get(7)),
                cb3__AmountLB__c=recordFields.get(8)=='null'?null:Decimal.valueOf(recordFields.get(8)),
                cb3__AmountUB__c=recordFields.get(9)=='null'?null:Decimal.valueOf(recordFields.get(9)),
                cb3__Col1LB__c=recordFields.get(10)=='null'?null:Decimal.valueOf(recordFields.get(10)),
                cb3__Col1UB__c=recordFields.get(11)=='null'?null:Decimal.valueOf(recordFields.get(11)),
                cb3__Col2LB__c=recordFields.get(12)=='null'?null:Decimal.valueOf(recordFields.get(12)),
                cb3__Col2UB__c=recordFields.get(13)=='null'?null:Decimal.valueOf(recordFields.get(13)),
                cb3__Col3LB__c=recordFields.get(14)=='null'?null:Decimal.valueOf(recordFields.get(14)),
                cb3__Col3UB__c=recordFields.get(15)=='null'?null:Decimal.valueOf(recordFields.get(15)),
                cb3__IndirectPercentageLB__c=recordFields.get(16)=='null'?null:Decimal.valueOf(recordFields.get(16)),
                cb3__IndirectPercentageUB__c=recordFields.get(17)=='null'?null:Decimal.valueOf(recordFields.get(17)),
                cb3__PercentageLB__c=recordFields.get(18)=='null'?null:Decimal.valueOf(recordFields.get(18)),
                cb3__PercentageUB__c=recordFields.get(19)=='null'?null:Decimal.valueOf(recordFields.get(19)),
                cb3__RateLB__c=recordFields.get(20)=='null'?null:Decimal.valueOf(recordFields.get(20)),
                cb3__RateUB__c=recordFields.get(21)=='null'?null:Decimal.valueOf(recordFields.get(21)),
                cb3__OnlyTotalUB__c=recordFields.get(22)=='null'?null:Decimal.valueOf(recordFields.get(22)),
                cb3__OnlyTotalLB__c=recordFields.get(23)=='null'?null:Decimal.valueOf(recordFields.get(23)),
                cb3__StipendAmountDescription__c=recordFields.get(24)=='null'?null:recordFields.get(24),
                cb3__PredefinedRate__c=recordFields.get(25)=='null'?null:Decimal.valueOf(recordFields.get(25)),
                cb3__StipendAmountDescriptionName__c=recordFields.get(26)=='null'?null:recordFields.get(26)));
            }
            insert newRelatedAccounts;
            List<cb3__BA_RelatedAmount__c> newRelatedAmounts = new List<cb3__BA_RelatedAmount__c>();
            for(String currentRecord: importedRelatedAmounts) {
                if (String.isBlank(currentRecord)) {
                    continue;
                }
                List<String> recordFields = currentRecord.split('&#124;');
                newRelatedAmounts.add(new cb3__BA_RelatedAmount__c(name=recordFields.get(1)=='null'?null:recordFields.get(1),
                cb3__SectionSettings__c=recordFields.get(2)=='null'?null:settings3Map.get(recordFields.get(2)).Id,
                cb3__Amount__c=recordFields.get(3)=='null'?null:Decimal.valueOf(recordFields.get(3))));
            }
            insert newRelatedAmounts;
            
            logMessage += 'Status: successful';
        } catch (Exception e) {
            logMessage += 'Exception in line ' + e.getLineNumber() + '\n';
            logMessage += e.getCause() + '\n';
            logMessage += e.getTypeName() + '\n';
            logMessage += e.getMessage() + '\n';
            logMessage += e.getStackTraceString() + '\n';
            System.debug(e);
        } finally {
            Messaging.EmailFileAttachment logAttachment = new Messaging.EmailFileAttachment();
            Blob logBlob = blob.valueOf(logMessage);
            logAttachment.setFileName('PSI_import_log.txt');
            logAttachment.setBody(logBlob);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[]{'yfilipov@cloudbudget.com'};
            String subject = 'PSI import log';
            email.setSubject(subject);
            email.setToAddresses(toAddresses);
            email.setPlainTextBody('PSI import log attached below');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{logAttachment});
            try {
                Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
            } catch (Exception mailException) {
                System.debug(mailException.getStackTraceString());
            }
        }
    }
}