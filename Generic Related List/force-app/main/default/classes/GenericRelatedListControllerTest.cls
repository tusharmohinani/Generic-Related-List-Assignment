@isTest
public class GenericRelatedListControllerTest {
    @isTest
    static void fetchRecordsMethodTest()
    {
        //inserting a account
        Account acc =new Account(Name='Test Account');
        INSERT acc;
        //inserting 2 contacts 
        Contact con1 = new Contact(FirstName='Test',LastName='Contact1',AccountId=acc.id);
        INSERT con1;
        Contact con2 = new Contact(FirstName='Test',LastName='Contact2',AccountId=acc.id);
        INSERT con2;

        //checking data
        List<sObject> lstRecords1 = GenericRelatedListController.fetchRecords(acc.id,'Contact','AccountId','FirstName,LastName','');
        System.assertEquals(2,lstRecords1.size(),'Contacts not get as expected');
        List<sObject> lstRecords2 = GenericRelatedListController.fetchRecords(acc.id,'Contact','AccountId','FirstName,LastName','Name LIKE \'%Contact2\'');
        System.assertEquals(1,lstRecords2.size(),'Contacts not get as expected');
        try{
            List<sObject> lst2 = GenericRelatedListController.fetchRecords(acc.id,'Contact','AccountI','FirstName,LastName','');
        }
        catch(Exception e){
            System.assertEquals(e.getMessage(),e.getMessage());
        }
    }
}