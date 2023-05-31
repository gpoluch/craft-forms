@IsTest
private with sharing class TriggerHandlerTests {
    @IsTest
    static void itShouldPerformBeforeInsert() {
        TestTriggerHandler testHandler = new TestTriggerHandler();
        TriggerHandler.triggerContext = TriggerOperation.BEFORE_INSERT;

        testHandler.execute();

        System.assertEquals(
            TriggerOperation.BEFORE_INSERT,
            testHandler.method,
            'Operation type should equal expected value'
        );
    }

    @IsTest
    static void itShoudlPerformBeforeUpdate() {
        TestTriggerHandler testHandler = new TestTriggerHandler();
        TriggerHandler.triggerContext = TriggerOperation.BEFORE_UPDATE;

        testHandler.execute();

        System.assertEquals(
            TriggerOperation.BEFORE_UPDATE,
            testHandler.method,
            'Operation type should equal expected value'
        );
    }

    @IsTest
    static void itShouldPerformBeforeDelete() {
        TestTriggerHandler testHandler = new TestTriggerHandler();
        TriggerHandler.triggerContext = TriggerOperation.BEFORE_DELETE;

        testHandler.execute();

        System.assertEquals(
            TriggerOperation.BEFORE_DELETE,
            testHandler.method,
            'Operation type should equal expected value'
        );
    }

    @IsTest
    static void itShouldPerformAfterInsert() {
        TestTriggerHandler testHandler = new TestTriggerHandler();
        TriggerHandler.triggerContext = TriggerOperation.AFTER_INSERT;

        testHandler.execute();

        System.assertEquals(
            TriggerOperation.AFTER_INSERT,
            testHandler.method,
            'Operation type should equal expected value'
        );
    }

    @IsTest
    static void itShouldPerformAfterUpdate() {
        TestTriggerHandler testHandler = new TestTriggerHandler();
        TriggerHandler.triggerContext = TriggerOperation.AFTER_UPDATE;

        testHandler.execute();

        System.assertEquals(
            TriggerOperation.AFTER_UPDATE,
            testHandler.method,
            'Operation type should equal expected value'
        );
    }

    @IsTest
    static void itShouldPerformAfterDelete() {
        TestTriggerHandler testHandler = new TestTriggerHandler();
        TriggerHandler.triggerContext = TriggerOperation.AFTER_DELETE;

        testHandler.execute();

        System.assertEquals(
            TriggerOperation.AFTER_DELETE,
            testHandler.method,
            'Operation type should equal expected value'
        );
    }

    @IsTest
    static void itShouldPerformAfterUndelete() {
        TestTriggerHandler testHandler = new TestTriggerHandler();
        TriggerHandler.triggerContext = TriggerOperation.AFTER_UNDELETE;

        testHandler.execute();

        System.assertEquals(
            TriggerOperation.AFTER_UNDELETE,
            testHandler.method,
            'Operation type should equal expected value'
        );
    }

    private class TestTriggerHandler extends TriggerHandler {
        public TriggerOperation method { get; private set; }

        @TestVisible
        protected override void beforeInsert(List<SObject> newRecords) {
            this.method = TriggerOperation.BEFORE_INSERT;
        }
        @TestVisible
        protected override void beforeUpdate(Map<Id, SObject> updatedRecordsMap, Map<Id, SObject> oldRecordsMap) {
            this.method = TriggerOperation.BEFORE_UPDATE;
        }
        @TestVisible
        protected override void beforeDelete(Map<Id, SObject> deletedRecordsMap) {
            this.method = TriggerOperation.BEFORE_DELETE;
        }
        @TestVisible
        protected override void afterInsert(Map<Id, SObject> newRecordsMap) {
            this.method = TriggerOperation.AFTER_INSERT;
        }
        @TestVisible
        protected override void afterUpdate(Map<Id, SObject> updatedRecordsMap, Map<Id, SObject> oldRecordsMap) {
            this.method = TriggerOperation.AFTER_UPDATE;
        }
        @TestVisible
        protected override void afterDelete(Map<Id, SObject> deletedRecordsMap) {
            this.method = TriggerOperation.AFTER_DELETE;
        }
        @TestVisible
        protected override void afterUndelete(Map<Id, SObject> undeletedRecordsMap) {
            this.method = TriggerOperation.AFTER_UNDELETE;
        }
    }
}
