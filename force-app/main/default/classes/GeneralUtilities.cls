/**
 * GeneralUtilities.cls
 * Descripción: Clase de utilidades generales para operaciones comunes en Salesforce.
 * 
 * @author: aarribas
 */
public class GeneralUtilities
{
    
    public static void clearFieldSetFields(SObject record, String objectApiName, String fieldSetName)
    {
        try {
            Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectApiName);
            
            if(objType == null){
                throw new AuraHandledException('Objeto no encontrado: ' + objectApiName);
            }
            
            Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
            Map<String, Schema.FieldSet> fieldSetMap = objDescribe.fieldSets.getMap();
            
            if(!fieldSetMap.containsKey(fieldSetName)){
                throw new AuraHandledException('FieldSet no encontrado: ' + fieldSetName);
            }
            
            Schema.FieldSet fs = fieldSetMap.get(fieldSetName);
            
            for(Schema.FieldSetMember f : fs.getFields()) {
                String fieldName = f.getFieldPath();
                if(record.getSObjectType().getDescribe().fields.getMap().containsKey(fieldName)) {
                    record.put(fieldName, null);
                }
            }
        } catch (Exception e) {
            System.debug('Error en clearFieldSetFields: ' + e.getMessage());
            throw e;
        }
    }
}