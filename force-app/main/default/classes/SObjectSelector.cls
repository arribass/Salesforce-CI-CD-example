/**
 * @description       : Selector abstract class
 * @last modified by  : aarribas
**/
public abstract with sharing class SObjectSelector
{
    public String sObjectName;
    public List<String> fields;

    /**
     * Method that sets the list of fields to retrieve in the SQL
     */
    public void setFields(List<String> fieldsToRetrieve) {
        fields = fieldsToRetrieve;
    }

    /**
     * Method that adds specific fields to the SQL
     */
    public void addFields(List<String> additionalFieldsToRetrieve) {
        fields.addAll(additionalFieldsToRetrieve);
    }

    /**
     * Method that gets the records with the given IDs
     */
    public List<SObject> selectSObjectsById(Set<Id> recordIds) {
		return Database.query(String.format('SELECT {0} FROM {1} WHERE Id in :recordIds',
                                            new List<String>{String.join(fields, ','), sObjectName}));
	}

    /**
     * Method that gets the records with the given Names
     */
    public List<SObject> selectSObjectsByName(Set<String> recordNames) {
        return Database.query(String.format('SELECT {0} FROM {1} WHERE Name in :recordNames',
                                            new List<String>{String.join(fields, ','), sObjectName}));
	}

    /**
     * Method that get records by your 'WHERE' condition
     * @param       String whereCondition
     */
    public List<SObject> selectSObjectByWhereCondition(String whereCondition)
    {
        if(String.isBlank(whereCondition))
        {
            return null;
        }
        return Database.query(String.format('SELECT {0} FROM {1} WHERE {2}',
                                            new List<String>{String.join(fields, ','), sObjectName, whereCondition}));
    }

     /**
     * Method that gets the records filter by the fields ids
     * @param       String fieldName of the object
     * @param       Set<Id> recordIds
     */
    public List<SObject> selectSObjectsByFieldId(String fieldName,Set<Id> recordIds)
    {
		return Database.query(String.format('SELECT {0} FROM {1} WHERE {2} in :recordIds',
                                            new List<String>{String.join(fields, ','), sObjectName, fieldName }));
	}

    /**
     * Method that gets the records with the given Names and additional conditions
     * @author aberuete
     * @date 01/04/2025
     */
    public List<SObject> selectSObjectsByNameWithAdditionalConditions(Set<String> recordNames, List<String> additionalConditions)
    {
        String baseQuery = 'SELECT {0} FROM {1} WHERE Name in :recordNames';

        if (!additionalConditions.isEmpty())
        {
            baseQuery += ' AND ' + String.join(additionalConditions, ' AND ');
        }

        return Database.query(String.format(baseQuery, new List<String>{String.join(fields, ','), sObjectName}));
    }

    /**
     * Gets all records using SOQL
     * This avoids the 255 character truncation issue of getAll()
     * @return List of records
     */
    public List<SObject> selectAllRecords() {
        if (fields == null || fields.isEmpty()) {
            throw new SObjectSelectorException('No fields specified. Use setFields() before querying.');
        }
        return Database.query(
            String.format(
                'SELECT {0} FROM {1}',
                new List<String>{String.join(fields, ','), sObjectName}
            )
        );
    }

    /**
     * Custom exception for SObjectSelector
     * @author glopez5
     * @date 02/02/2026
     */
    public class SObjectSelectorException extends Exception {}
}