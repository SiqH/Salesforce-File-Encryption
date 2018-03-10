# Salesforce-File-Encryption

## Encrypt with AES 256 algorithm while uploading files in Salesforce.


<b> Pre-Requisites :<b>

    Define following 2 List Custom Settings in your Org:
      1. Utility__c with field 'AES Key' to store your Encryption Key
      2. Profile_Permission__c with applicable values(true/false) for 'View_Access__c' and 
         'Create_Access__c' fields
