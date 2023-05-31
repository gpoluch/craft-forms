import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { APPLICATION_SCOPE, MessageContext, subscribe, unsubscribe } from 'lightning/messageService';
import refreshMessageChannel from '@salesforce/messageChannel/refreshMessageChannel__c';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import accountCreator from '@salesforce/label/c.AccountCreator';
import accountWithNameCreatedSuccessfully from '@salesforce/label/c.AccountWithNameCreatedSuccessfully';
import save from '@salesforce/label/c.Save';
import success from '@salesforce/label/c.Success';

export default class AccountCreator extends LightningElement {
    objectApiName = ACCOUNT_OBJECT;
    nameField = NAME_FIELD;

    label = {
        accountCreator,
        save
    };

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                refreshMessageChannel,
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            );
        }
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    handleMessage() {
        const inputFields = this.template.querySelectorAll('lightning-input-field');
        if (inputFields) {
            inputFields.forEach((field) => {
                field.reset();
            });
        }
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: success,
            message: this._interpolate(accountWithNameCreatedSuccessfully, [
                event.detail.fields[this.nameField.fieldApiName].value
            ]),
            variant: 'success'
        });

        this.dispatchEvent(evt);
    }

    _interpolate(str, values) {
        return str.replace(/{([^{}]*)}/g, (match, key) => values[key.trim()] || match);
    }
}
