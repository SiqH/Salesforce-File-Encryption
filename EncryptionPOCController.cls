public class EncryptionPOCController {
	
	@AuraEnabled
    public static Boolean showButton() {
        // Control access to this action based on profiles mentioned in the 
        // "Profile Permission" custom setting

        User currentUser = [select id,Profile.Name from user where id = : UserInfo.getUserId()].get(0);
        Profile_Permission__c permission = Profile_Permission__c.getInstance(currentUser.Profile.Name);
        if(permission.View_Access__c == true && permission.Create_Access__c == true){
            return true;
        }else{
            return false;
        }
    }
	
    @AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) {
        // check if fileId id ''(Always blank in first chunk), then call the saveTheFile method,
        //  which is save the check data and return the attachemnt Id after insert, 
        //  next time (in else) we are call the appentTOFile() method
        //   for update the attachment with reamins chunks   
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
 
        return Id.valueOf(fileId);
    }
 
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) {
        system.debug('Start==>'+system.now().millisecond());
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 		Blob data = EncodingUtil.base64Decode(base64Data);
        
        //Encrypt the text body
        Utility__c EncryptionKey = Utility__c.getInstance('AES Key');
        Blob key = EncodingUtil.base64decode(EncryptionKey.value__c);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES256', key, data);
        
        ContentVersion cv = new ContentVersion();
        cv.versionData = encryptedData;
        cv.title = fileName;
        cv.pathOnClient ='/somepath.txt';
        insert cv;
        
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
        cdl.LinkedEntityId = parentId;
        cdl.ShareType = 'V';
        insert cdl;

 		system.debug('End==>'+system.now().millisecond());
        return cv.Id;
    }
 
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 
        ContentVersion cv = [
            SELECT Id, VersionData
            FROM ContentVersion
            WHERE Id =: fileId
        ];
 
        String existingBody = EncodingUtil.base64Encode(cv.VersionData);
 
        cv.VersionData = EncodingUtil.base64Decode(existingBody + base64Data);
        update cv;
        
    }
}