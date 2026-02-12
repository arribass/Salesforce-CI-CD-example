/**
 * @description       : SObjectSelector Test Class
**/
@isTest(SeeAllData=false)
private class SObjectSelectorTest
{
    @testSetup
    private static void setupTestData()
    {
        List<Account> testAccounts = new List<Account>
        {
            new Account(Name = 'Test Account 1', BillingCountry = 'Uruguay'),
            new Account(Name = 'Test Account 2', BillingCountry = 'Spain'),
            new Account(Name = 'Test Account 3', BillingCountry = 'Uruguay')
        };
        insert testAccounts;
    }

    /**
     * Clase helper para testing
     */
    private class SObjectSelectorTestImpl extends SObjectSelector {
        public SObjectSelectorTestImpl() {
            this.sObjectName = 'Account';
            this.fields = new List<String>();
        }
    }
}