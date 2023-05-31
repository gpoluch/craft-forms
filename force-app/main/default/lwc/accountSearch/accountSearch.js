import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { APPLICATION_SCOPE, MessageContext, subscribe, unsubscribe } from 'lightning/messageService';
import getAccountsByName from '@salesforce/apex/AccountController.getAccountsByName';
import refreshMessageChannel from '@salesforce/messageChannel/refreshMessageChannel__c';
import ID_FIELD from '@salesforce/schema/Account.Id';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import BILLING_COUNTRY_FIELD from '@salesforce/schema/Account.BillingCountry';
import accountSearch from '@salesforce/label/c.AccountSearch';
import billingCountry from '@salesforce/label/c.BillingCountry';
import name from '@salesforce/label/c.Name';
import search from '@salesforce/label/c.Search';
import typeExactNameAndClickSearchButton from '@salesforce/label/c.TypeExactNameAndClickSearchButton';

const COLUMNS = [
    {
        label: 'Id',
        fieldName: 'Url',
        type: 'url',
        typeAttributes: { label: { fieldName: ID_FIELD.fieldApiName }, target: '_blank' }
    },
    { label: name, fieldName: NAME_FIELD.fieldApiName },
    { label: billingCountry, fieldName: BILLING_COUNTRY_FIELD.fieldApiName }
];

export default class AccountSearch extends LightningElement {
    columns = COLUMNS;
    @track rows;
    @track isEditMode;
    @track phrase;
    @track isLoading;

    label = {
        accountSearch,
        search,
        typeExactNameAndClickSearchButton
    };

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.isLoading = false;
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
        this.phrase = null;
        this._refreshAccounts();
    }

    handlePhraseChange(event) {
        this.phrase = event.target.value;
    }

    handleSearchClick() {
        this._refreshAccounts();
    }

    handleModeChange(event) {
        this.isEditMode = event.detail;
        this.columns = this.columns.map((column) => ({ ...column, editable: this.isEditMode }));
    }

    handleRefresh() {
        this._refreshAccounts();
    }

    _refreshAccounts() {
        this.isLoading = true;
        getAccountsByName({ name: this.phrase })
            .then((result) => {
                this.rows = result.map((row) => ({ ...row, Url: `/${row.Id}` }));
                this.isLoading = false;
            })
            .catch((error) => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(event);
            });
    }
}
