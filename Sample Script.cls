String fileName = 'SampleTextFile_200kb.txt';

Utility__c EncryptionKey = Utility__c.getInstance('AES Key');

Blob key = EncodingUtil.base64decode(EncryptionKey.value__c);
ContentVersion cv = [SELECT VersionData FROM ContentVersion WHERE Title =:fileName order by createddate desc limit 1];
String encoded = EncodingUtil.base64Encode(cv.VersionData);

Blob data = EncodingUtil.base64Decode(encoded); 
Blob decryptedData = Crypto.decryptWithManagedIV('AES256', key, data);
String decryptedDataString = decryptedData.toString();

system.debug('Decrypted Data**'+decryptedDataString);