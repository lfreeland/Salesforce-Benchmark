public with sharing class BenchmarkUtil {


    public static void insertResult(String benchmarkName, Integer recordCount, Integer durationInMilliseconds) {
    
        Benchmark_Result__c result = new Benchmark_Result__c(
            Benchmark_Name__c = benchmarkName,
            Duration_Milliseconds__c = durationInMilliseconds,
            Record_Count__c = recordCount
        );
        
        insert result;
    }
}