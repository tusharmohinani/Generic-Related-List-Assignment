import { LightningElement,api } from 'lwc';
import fetchRecords from '@salesforce/apex/GenericRelatedListController.fetchRecords';  
export default class GenericRelatedList extends LightningElement {
    @api recordId;
    @api objectName;
    @api relation;
    @api fields;
    @api filters;
    data;
    columns=[];
    error;
    spinner=false;
    //method called when component runs
    connectedCallback()
    {
        //pushing the values in columns as fields to show
        if(this.fields!=null && this.relation!=null && this.objectName!=null)
        {
            var field=this.fields.split(',');
            for(var i=0;i<field.length;i++)
            {
                this.columns.push({label:field[i],fieldName:field[i]});
            }
            console.log(this.columns);
            this.spinner=true;
            this.fetchRecords();
        }
        else
        {
            this.error="Properties of component should not be null";
        }
    }
    fetchRecords()
    {
        //calling method of apex to get the records
        fetchRecords({'recordId':this.recordId,'objectName':this.objectName,'relation':this.relation,'fields':this.fields,'filters':this.filters})
        .then(result=>{
            console.log(result);
            this.data=result;
            this.spinner=false;
        })
        .catch(error=>{
            //in case their is any error storing that in a variable
            this.error=error.body.message;
            this.spinner=false;
        })
    }
}