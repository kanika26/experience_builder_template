@RestResource(urlMapping='/SyncAttachments/*')
    global with sharing class ContentController  {
    
        global class Image {
           public String primaryKey;
           public String base64;
           public String parentId;
        }
    
        @HttpPost   
        global static Map<String, String> syncAttachments(Image image) {
            List<Document> documents = [SELECT Id, Name, Body FROM Document WHERE Id =:image.primaryKey];
            Folder dummyFolder = [SELECT Id FROM Folder LIMIT 1];
            Document myDocument;
            if (documents.size() == 0) {
                myDocument = new Document();
                myDocument.FolderId = dummyFolder.id;
                myDocument.Body = EncodingUtil.base64Decode(image.base64);
                myDocument.ContentType = 'image/jpg';
                myDocument.Name = image.parentId;
                insert myDocument;
            }
            else {
                myDocument = documents[0];
            }       
            Map<String, String> responseMap = new Map<String, String>();
            responseMap.put('Success', '1');
            responseMap.put('Message', 'Sync Document ' + myDocument.Name + ' Successfully');
            return responseMap;
        }
    }

