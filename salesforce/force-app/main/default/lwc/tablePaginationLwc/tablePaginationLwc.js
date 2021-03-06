import { LightningElement, api, track } from "lwc";
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const DELAY = 300;

export default class TablePaginationLwc extends LightningElement {

    @api showTable = false;
    @api records;
    @api recordsperpage;
    @api columns;
    @track draftValues = [];
    @track recordsToDisplay;
    @track preSelectedRows = [];
    totalRecords;
    pageNo;
    totalPages;
    startRecord;
    endRecord;
    end = false;
    pagelinks = [];
    isLoading = false;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    ortedBy;
    preSelectedRowsBackup = [];
    @api showCheckboxColumnParam = false;
    connectedCallback() {
        this.isLoading = true;
        this.setRecordsToDisplay();
    }
    setRecordsToDisplay() {
        this.totalRecords = this.records.length;
        this.pageNo = 1;
        this.totalPages = Math.ceil(this.totalRecords / this.recordsperpage);
        this.preparePaginationList();
        for (let i = 1; i <= this.totalPages; i++) {
            this.pagelinks.push(i);
        }
        this.isLoading = false;
    }
    handleClick(event) {
        let label = event.target.label;
        if (label === "First") {
            this.handleFirst();
        } else if (label === "Previous") {
            this.handlePrevious();
        } else if (label === "Next") {
            this.handleNext();
        } else if (label === "Last") {
            this.handleLast();
        }
    }

    handleNext() {
        this.pageNo += 1;
        this.preparePaginationList();
    }

    handlePrevious() {
        this.pageNo -= 1;
        this.preparePaginationList();
    }

    handleFirst() {
        this.pageNo = 1;
        this.preparePaginationList();
    }

    handleLast() {
        this.pageNo = this.totalPages;
        this.preparePaginationList();
    }
    preparePaginationList() {
        this.isLoading = true;
        let begin = (this.pageNo - 1) * parseInt(this.recordsperpage);
        let end = parseInt(begin) + parseInt(this.recordsperpage);
        this.recordsToDisplay = this.records.slice(begin, end);
        this.startRecord = begin + parseInt(1);
        this.endRecord = end > this.totalRecords ? this.totalRecords : end;
        this.end = end > this.totalRecords ? true : false;
        const event = new CustomEvent('pagination', {
            detail: { 
                records : this.recordsToDisplay
            }
        });
        this.dispatchEvent(event);
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(() => {
            this.disableEnableActions();
        }, DELAY);
        this.preSelectedRows = [...this.preSelectedRowsBackup];
        this.isLoading = false;
    }

    disableEnableActions() {
        let buttons = this.template.querySelectorAll("lightning-button");
        buttons.forEach(bun => {
            if (bun.label === this.pageNo) {
                bun.disabled = true;
            } else {
                bun.disabled = false;
            }
            if (bun.label === "First") {
                bun.disabled = this.pageNo === 1 ? true : false;
            } else if (bun.label === "Previous") {
                bun.disabled = this.pageNo === 1 ? true : false;
            } else if (bun.label === "Next") {
                bun.disabled = this.pageNo === this.totalPages ? true : false;
            } else if (bun.label === "Last") {
                bun.disabled = this.pageNo === this.totalPages ? true : false;
            }
        });
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        const rowAction = new CustomEvent('actions', {
            detail: { 
                actionName : actionName,
                data : row
            }
        });
        console.log('rowAction====',rowAction);
        this.dispatchEvent(rowAction);
    }

    handlePage(button) {
        this.pageNo = button.target.label;
        this.preparePaginationList();
    }

    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.recordsToDisplay];
        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.recordsToDisplay = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }
    sortBy( field, reverse, primer ) {
        const key = primer
        ? function( x ) {
            return primer(x[field]);
        }
        : function( x ) {
            return x[field];
        };
        return function( a, b ) {
            a = key(a);
            b = key(b);
            return reverse * ( ( a > b ) - ( b > a ) );
        };
    }

    @api
    refreshComp(recordsParam){
        this.records = recordsParam;
        this.isLoading = true;
        this.setRecordsToDisplay();
        return refreshApex(this.recordsToDisplay);
    }
    @api
    getSelectedRows() {
        return this.preSelectedRows;
    }
    
    rowSelectionEvent(evt){
        // List of selected items from the data table event.
        let updatedItemsSet = new Set();
        // List of selected items we maintain.
        let selectedItemsSet = new Set(this.preSelectedRows);
        // List of items currently loaded for the current view.
        let loadedItemsSet = new Set();


        this.recordsToDisplay.forEach((event) => {
            loadedItemsSet.add(event.id);
        }); 
        console.log('loadedItemsSet---',loadedItemsSet)

        if (evt.detail.selectedRows) { 
            console.log('evt.detail.selectedRows---',evt.detail.selectedRows)
 
            evt.detail.selectedRows.forEach((event) => {
                updatedItemsSet.add(event.id);
            });
            console.log('updatedItemsSet---',updatedItemsSet)

            // Add any new items to the selection list
            updatedItemsSet.forEach((id) => {
                if (!selectedItemsSet.has(id)) {
                    selectedItemsSet.add(id);
                }
            });     
               
        }
        loadedItemsSet.forEach((id) => {
            if (selectedItemsSet.has(id) && !updatedItemsSet.has(id)) {
                // Remove any items that were unselected.
                selectedItemsSet.delete(id);
            }
        });


        this.preSelectedRows = [...selectedItemsSet];
        this.preSelectedRowsBackup = this.preSelectedRows;
        console.log('---selection---'+JSON.stringify(this.preSelectedRows));
        return refreshApex(this.preSelectedRows );
    }
} 