@IsTest
public class TestUtils {
    public static User createTestUser(Id profileID, String firstName, String lastName) {
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ', '').replace(':', '').replace('-', '');
        Integer randomInt = Integer.valueOf(math.rint(math.random() * 1000000));
        String uniqueName = orgId + dateString + randomInt;
        User user = new User(
            firstname = firstName,
            lastName = lastName,
            email = uniqueName + '@test' + orgId + '.org',
            Username = uniqueName + '@test' + orgId + '.org',
            EmailEncodingKey = 'ISO-8859-1',
            Alias = uniqueName.substring(18, 23),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            ProfileId = profileID
        );
        return user;
    }

    public static List<Account> createTestAccounts(Integer numAccounts) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 1; i <= numAccounts; i++) {
            accounts.add(createTestAccount('Test_Account_' + i, 'Poland', '1212-1221-1121-1234'));
        }
        return accounts;
    }

    public static Account createTestAccount(String name, String billingCountry, String creditCard) {
        Account acct = new Account();
        acct.Name = name;
        acct.BillingCountry = billingCountry;
        acct.CreditCard__c = creditCard;
        return acct;
    }

    public static List<Account> getAccountsByName(String name) {
        return [
            SELECT Id, Name, BillingCountry, CreditCard__c
            FROM Account
            WHERE Name = :name
        ];
    }
}
