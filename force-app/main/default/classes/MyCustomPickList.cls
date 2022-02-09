global class MyCustomPickList extends VisualEditor.DynamicPickList{
    Integer i =0;
    global override VisualEditor.DataRow getDefaultValue(){
        List<StaticResource> docs;
        docs = [select Id,name, body from StaticResource];
        System.debug(docs); 
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('choose','choose');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        List<StaticResource> docs;
        docs = [select Id,name,body from StaticResource]; // /servel/sobject etc
        System.debug(docs); 
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();

        for(i=0;i<docs.size();i++){
            Blob cvblob = docs[i].body;
            //
           // System.debug(EncodingUtil.base64Encode(cvblob));
            VisualEditor.DataRow val = new VisualEditor.DataRow(docs[i].name,EncodingUtil.base64Encode(cvblob));
            myValues.addRow(val);
            // System.debug(val);
        }
        //System.debug(myValues);
        return myValues;
        // VisualEditor.DataRow value1 = new VisualEditor.DataRow('red', 'RED');
        // VisualEditor.DataRow value2 = new VisualEditor.DataRow('yellow', 'YELLOW');
        // VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        // myValues.addRow(value1);
        // myValues.addRow(value2);
        // return myValues;
    }
    
}