public virtual class TriggerHandler {
    @TestVisible
    private static TriggerOperation triggerContext;

    protected TriggerHandler() {
        if (!Trigger.isExecuting && !Test.isRunningTest()) {
            throw new TriggerHandlerException(Constants.TRIGGER_HANDLER_USED_OUTSIDE);
        }
    }

    public void execute() {
        TriggerOperation context = triggerContext != null ? triggerContext : Trigger.operationType;
        switch on context {
            when BEFORE_INSERT {
                this.beforeInsert(Trigger.new);
            }
            when BEFORE_UPDATE {
                this.beforeUpdate(Trigger.newMap, Trigger.oldMap);
            }
            when BEFORE_DELETE {
                this.beforeDelete(Trigger.newMap);
            }
            when AFTER_INSERT {
                this.afterInsert(Trigger.newMap);
            }
            when AFTER_UPDATE {
                this.afterUpdate(Trigger.newMap, Trigger.oldMap);
            }
            when AFTER_DELETE {
                this.afterDelete(Trigger.oldMap);
            }
            when AFTER_UNDELETE {
                this.afterUndelete(Trigger.newMap);
            }
        }
        this.andFinally();
    }

    protected virtual void beforeInsert(List<SObject> newRecords) {
        return;
    }

    protected virtual void beforeUpdate(Map<Id, SObject> updatedRecordsMap, Map<Id, SObject> oldRecordsMap) {
        return;
    }

    protected virtual void beforeDelete(Map<Id, SObject> deletedRecordsMap) {
        return;
    }

    protected virtual void afterInsert(Map<Id, SObject> newRecordsMap) {
        return;
    }

    protected virtual void afterUpdate(Map<Id, SObject> updatedRecordsMap, Map<Id, SObject> oldRecordsMap) {
        return;
    }

    protected virtual void afterDelete(Map<Id, SObject> deletedRecordsMap) {
        return;
    }

    protected virtual void afterUndelete(Map<Id, SObject> undeletedRecordsMap) {
        return;
    }

    protected virtual void andFinally() {
        return;
    }

    private class TriggerHandlerException extends Exception {
    }
}
