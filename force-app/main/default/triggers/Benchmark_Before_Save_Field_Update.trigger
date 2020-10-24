trigger Benchmark_Before_Save_Field_Update on Before_Trigger_Field_Update__c (before insert) {
    for (Before_Trigger_Field_Update__c newRecord : Trigger.new) {
        newRecord.Test_1__c = 'Benchmark Test';
    }
}