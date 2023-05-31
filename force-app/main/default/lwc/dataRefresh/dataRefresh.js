import { LightningElement, wire } from 'lwc';
import { MessageContext, publish } from 'lightning/messageService';
import refreshMessageChannel from '@salesforce/messageChannel/RefreshMessageChannel__c';
import refresh from '@salesforce/label/c.Refresh';
import refreshForms from '@salesforce/label/c.RefreshForms';

export default class DataRefresh extends LightningElement {
    @wire(MessageContext)
    messageContext;

    label = {
        refresh,
        refreshForms
    };

    handleRefreshClick() {
        publish(this.messageContext, refreshMessageChannel);
    }
}
