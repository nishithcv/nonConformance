public with sharing class CaseTriggerHandler {
    
    public static void createNonConformance(List<Case> caseList){

        //If user does not have permission no need to continue;
        if(!FeatureManagement.checkPermission('Nonconformance_Access')) return;

        List<case> casesToProcess = new List<case>();

        for(case cs :caseList){

            if(cs.Type != 'Problem' || cs.Nonconformance__c != null) continue;

            casesToProcess.add(cs);
        }

        map<string,SQX_Nonconformance__c> nonConformanceMap = new map<string,SQX_Nonconformance__c>();
        SQX_Nonconformance__c nonConf;

        if(casesToProcess.size() == 0) return;

        for(case cs :casesToProcess){

            nonConf = new SQX_Nonconformance__c();

            nonConf.Priority__c = cs.Priority;
            nonConf.Title__c = cs.Subject;
            nonConf.Description__c = cs.Description;
            nonConf.QMS_Reference__c = cs.CaseNumber;

            nonConformanceMap.put(nonConf.QMS_Reference__c,nonConf);
        }

        insert nonConformanceMap.values();

        for(case cs :casesToProcess){
            cs.Nonconformance__c = nonConformanceMap.get(cs.CaseNumber).Id;
        }
    }
}
