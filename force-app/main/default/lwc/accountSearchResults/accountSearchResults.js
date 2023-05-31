import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import updateAccounts from '@salesforce/apex/AccountController.updateAccounts';
import changesSavedSuccessfully from '@salesforce/label/c.ChangesSavedSuccessfully';
import editMode from '@salesforce/label/c.EditMode';
import viewMode from '@salesforce/label/c.ViewMode';
import loading from '@salesforce/label/c.Loading';
import success from '@salesforce/label/c.Success';

export default class AccountSearchResults extends LightningElement {
    @api columns;
    @api rows;
    @api phrase;
    @api isLoading;

    label = {
        editMode,
        viewMode,
        loading
    };

    isEditable = false;

    get isEmpty() {
        return !((this.rows && this.rows.length) || this.isLoading);
    }

    handleChangeModeClick() {
        this.isEditable = !this.isEditable;
        this._dispatchModeChangeEvent();
        if (!this.isEmpty && this.isEditable) {
            this.draftValues = [{}];
        } else {
            this.draftValues = [];
        }
    }

    handleCancel() {
        this.isEditable = false;
        this._dispatchModeChangeEvent();
        this.draftValues = [];
    }

    handleSave(event) {
        this.draftValues = event.detail.draftValues;

        updateAccounts({ accountsToUpdate: this.draftValues })
            .then(() => {
                this.dispatchEvent(new CustomEvent('refresh'));
                this.isEditable = false;
                this._dispatchModeChangeEvent();
                this.draftValues = [];
                const toastEvent = new ShowToastEvent({
                    title: success,
                    message: changesSavedSuccessfully,
                    variant: 'success'
                });

                this.dispatchEvent(toastEvent);
            })
            .catch((error) => {
                const toastEvent = new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(toastEvent);
            });
    }

    _dispatchModeChangeEvent() {
        this.dispatchEvent(new CustomEvent('modechange', { detail: this.isEditable }));
    }
}
