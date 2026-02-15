@IsTest
private class GeneralUtilitiesTest {
    
    @TestSetup
    static void setup() {
        // Create test data if needed
    }

    @IsTest
    static void testCalculateSum() {
        // Arrange
        Integer a = 5;
        Integer b = 10;

        // Act
        Integer result = GeneralUtilities.calculateSum(a, b);

        // Assert
        System.assertEquals(15, result, 'The sum of 5 and 10 should be 15');
    }
}