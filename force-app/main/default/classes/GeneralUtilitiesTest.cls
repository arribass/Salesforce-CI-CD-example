@IsTest
private class GeneralUtilitiesTest {
    
    @IsTest
    static void testClearFieldSetFields() {
        // 1. Crear un Account con valores
        Account acc = new Account(
            Name = 'Test Account',
            Phone = '123456789',
            Website = 'www.test.com'
        );
        
        insert acc;
        
        // 2. Llamar al método que limpia los campos
        GeneralUtilities.clearFieldSetFields(
            acc, 
            'Account', 
            'ClearableFields' // <-- este fieldset debe existir en Account
        );
        
        // 3. Verificar que los campos fueron puestos a null
        System.assertEquals(null, acc.Phone, 'Phone debería estar en null');
        System.assertEquals(null, acc.Website, 'Website debería estar en null');
        
        // 4. Verificar que otros campos no se tocan
        System.assertEquals('Test Account', acc.Name, 'Name no debería haberse limpiado');
    }
}