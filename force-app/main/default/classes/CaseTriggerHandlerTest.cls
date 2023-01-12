@isTest
public with sharing class CaseTriggerHandlerTest {
    
    
    @TestSetup
    static void makeData(){
        
        test.startTest();
        case cs = new case();

        cs.Priority = 'Medium';
        cs.Description = 'Random';
        cs.Subject = 'Random Subject';
        
        insert cs;

        createUserAndAssignPermissionSet();

        test.stopTest();
    }

    @future static void createUserAndAssignPermissionSet(){
        list<Profile> standardUserProfile = [Select Id, name from Profile where name = :System.Label.Test_User_Name];

        List<PermissionSet> permSet = [Select Id, name from PermissionSet where name = 'Case_Admin'];
        
        User u = new User(
        ProfileId = standardUserProfile[0].Id,
        LastName = 'last',
        Email = 'puserTest000@amamama.com',
        Username = 'puser000@amamama.com' + System.currentTimeMillis(),
        CompanyName = 'TEST',
        Title = 'title',
        Alias = 'alias',
        TimeZoneSidKey = 'America/Los_Angeles',
        EmailEncodingKey = 'UTF-8',
        LanguageLocaleKey = 'en_US',
        LocaleSidKey = 'en_US');

        insert u;

        permissionSetAssignment permSetAdd = new permissionSetAssignment();
        permSetAdd.PermissionSetId =  permSet[0].Id;
        permSetAdd.AssigneeId = u.Id;

        insert permSetAdd;
    }

    @isTest static void createNonConfUserTest(){

        user u = [Select id, name from user where email = 'puserTest000@amamama.com'];
        case cs = [Select Id, type from case Limit 1];

        System.runAs(u){
            Test.startTest();
            cs.Type = 'Problem';
            update cs;
            Test.stopTest();
        }

        SQX_Nonconformance__c[] NonConfList = [Select Id from SQX_Nonconformance__c];

        System.assertEquals(1, NonConfList.size(), 'A Nonconformance record has been created');
    }
}
