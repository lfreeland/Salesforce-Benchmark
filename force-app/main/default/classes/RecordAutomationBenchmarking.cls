public with sharing class RecordAutomationBenchmarking {

    //https://github.com/apexlarson/LimitsProfiler

    private Integer recordCount { get; set; }
    
    public RecordAutomationBenchmarking() {
        recordCount = 200;
    }

    public void runBeforeSaveFlowOnInsertBenchmark() {
        runRecordInsertBenchmark('Before Save Flow On Insert', Before_Save_Field_Update__c.SObjectType);
    }
    
    public void runAfterSaveFlowOnInsertBenchmark() {
        runRecordInsertBenchmark('After Save Flow On Insert', After_Save_Field_Update__c.SObjectType);
    }

    public void runProcessBuilderOnInsertBenchmark() {
        runRecordInsertBenchmark('Process Builder No Criteria On Insert', Process_Builder__c.SObjectType);
    }

    public void runTriggerUpdateFieldOnInsertBenchmark() {
        runRecordInsertBenchmark('Trigger Update Field On Insert', Before_Trigger_Field_Update__c.SObjectType);
    }

    public void runWorkflowUpdateFieldOnInsertBenchmark() {
        runRecordInsertBenchmark('Workflow Update Field On Insert', Workflow_Field_Update__c.SObjectType);
    }

    public void runBeforeDeleteFlowInsertChildRecordsBenchmark() {
        runRecordDeleteBenchmark('Before Delete Flow Insert Child Records', Before_Delete_Example__c.SObjectType);
    }

    public void runBeforeDeleteTriggerInsertChildRecordsBenchmark() {
        runRecordDeleteBenchmark('Before Delete Trigger Insert Child Records', Before_Delete_Trigger_Example__c.SObjectType);
    }

    public void runSingleFlowMultipleCriteriaEvalOnInsertBenchmark() {
        runMultipleCriteriaEvalOnInsertBenchmark('Single Flow Multi Criteria Field Update', Before_Save_Single_Flow_Multi_Update__c.SObjectType);
    }

    public void runMultipleFlowSingleCriteriaEvalOnInsertBenchmark() {
        runMultipleCriteriaEvalOnInsertBenchmark('Multiple Flow Single Criteria Field Update', Before_Save_Multiple_Flow_Single_Update__c.SObjectType);
    }

    private void runRecordInsertBenchmark(String benchmarkName, SObjectType insertSObjectType) {
        List<SObject> recordsToInsert = new List<SObject>();
        
        for (Integer i = 0; i < recordCount; ++i) {
            SObject recordToInsert = insertSObjectType.newSObject();
            
            recordsToInsert.add(recordToInsert);
        }
        
        Integer startTime = Limits.getCPUTime();

        insert recordsToInsert;

        Integer endTime = Limits.getCpuTime();
        
        Integer durationInMilliseconds = endTime - startTime;
        
        BenchmarkUtil.insertResult(benchmarkName, recordCount, durationInMilliseconds);

        hardDeleteRecords(recordsToInsert);
    }

    private void runRecordDeleteBenchmark(String benchmarkName, SObjectType insertSObjectType) {
        List<SObject> recordsToInsert = buildRecordsToInsert(insertSObjectType);
        
        insert recordsToInsert;

        Integer startTime = Limits.getCPUTime();

        delete recordsToInsert;

        Integer endTime = Limits.getCpuTime();
        
        Integer durationInMilliseconds = endTime - startTime;
        
        BenchmarkUtil.insertResult(benchmarkName, recordCount, durationInMilliseconds);

        Database.emptyRecycleBin(recordsToInsert);
    }

    private void runMultipleCriteriaEvalOnInsertBenchmark(String benchmarkName, SObjectType insertSObjectType) {
        List<SObject> recordsToInsert = buildRecordsToInsert(insertSObjectType);

        for (SObject recordToInsert : recordsToInsert) {
            recordToInsert.put('Field_To_Update__c', 'Field 10');
        }

        Integer startTime = Limits.getCPUTime();

        insert recordsToInsert;

        Integer endTime = Limits.getCpuTime();
        
        Integer durationInMilliseconds = endTime - startTime;
        
        BenchmarkUtil.insertResult(benchmarkName, recordCount, durationInMilliseconds);

        hardDeleteRecords(recordsToInsert);
    }

    private List<SObject> buildRecordsToInsert(SObjectType insertSObjectType) {
        List<SObject> recordsToInsert = new List<SObject>();
        
        for (Integer i = 0; i < recordCount; ++i) {
            SObject recordToInsert = insertSObjectType.newSObject();
            
            recordsToInsert.add(recordToInsert);
        }

        return recordsToInsert;
    }

    private void hardDeleteRecords(List<SObject> newRecords) {
        delete newRecords;
        Database.emptyRecycleBin(newRecords);
    }
}