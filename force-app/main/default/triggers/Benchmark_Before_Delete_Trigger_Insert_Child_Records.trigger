trigger Benchmark_Before_Delete_Trigger_Insert_Child_Records on Before_Delete_Trigger_Example__c (Before Delete) {
    List<Before_Delete_Child__c> childrenToInsert = new List<Before_Delete_Child__c>();
    
    for (Before_Delete_Trigger_Example__c deletedRecord : Trigger.Old) {
        Before_Delete_Child__c childToInsert = new Before_Delete_Child__c(
            Description__c = 'Before Delete Benchmark'
        );
        
        childrenToInsert.add(childToInsert);
    }
    
    insert childrenToInsert;
}