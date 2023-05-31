# Craft Forms (Craftware recruitment task)

Craft forms is a recruitment task project which is a simple App Page with 4 lwc components

## Assumptions

1. The component for creating Account records should have one text field (Account Name) and a _Save_ button.
   An Account record should be created in the Salesforce database after the button is clicked.
2. The component with search functionality for Account records should contain a text field where the user enters the exact name of the record they want to find, and a Search button. Upon clicking the button, the system should search for Accounts with the exact name provided and display them in a table with columns (Account Id, Account Name, and Billing Country). The table component should be located within an LWC component.
3. The component with a table used to display Account records should have an additional button that allows switching between "View Mode" and "Edit Mode". In "View Mode", records should be simply displayed. In "Edit Mode", records should be editable by the user. A _Save_ button to save modified records and a _Cancel_ button to undo changes made to records should also be available. When "Edit Mode" is active, the text field in component 2 and the button should be disabled.
4. The component used to refresh data on the page should have a _Refresh_ button. When clicked, all fields in the above components must be cleared.
5. The Account object should have a text field called "Credit Card". Each time the Account is modified, the system should call the service https://random-data-api.com/api/v2/credit_cards, which generates a random credit card number. The received number should be saved in the "Credit Card" field. Here is the documentation for the service: https://random-data-api.com/documentation.

## Screenshots

![Create](https://i.postimg.cc/KYJ6JHXJ/create.png)

![Changes](https://i.postimg.cc/ZRqSmhPG/2023-05-31.png)

![Search](https://i.postimg.cc/CKhyCV2R/search.png)
