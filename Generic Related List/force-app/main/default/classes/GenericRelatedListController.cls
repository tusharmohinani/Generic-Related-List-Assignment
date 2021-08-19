public class GenericRelatedListController {
    //method to fetch related records as per recordId, object name,relation,fields,filters by an query
    @AuraEnabled
    public static List<sobject> fetchRecords(String recordId,String objectName,String relation,String fields,String filters )
    {
        try{
            //in case filters is null
            if(filters==null||filters=='')
            {
            	return database.query('SELECT '+fields+' FROM '+objectName+' WHERE '+relation+' = '+'\''+ recordId + '\'');
            }
            //in case filters is applied
            else
            {
                return database.query('SELECT '+fields+' FROM '+objectName+' WHERE '+relation+' = '+'\''+ recordId + '\''+' AND '+filters);
            }
        }
        catch(Exception e){
            //in case there is any expection
            throw new AuraHandledException(e.getMessage());
        }
    }
}