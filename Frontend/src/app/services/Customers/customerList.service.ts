import { Injectable } from '@angular/core';
import { Customer } from 'src/app/Customers/customer.model';
import { HttpClient } from '@angular/common/http';
import { Organization } from 'src/app/Customers/customer.model';

@Injectable()
export class CustomerListService{
      
    formData: Customer;
    formDataFK: Organization;
    list: Customer[];
    readonly rootURL = "https://localhost:5001/api";

    constructor (private http: HttpClient) {}

    postCustomer(formData: Customer) {
        return this.http.post(this.rootURL+'/Customers', formData)
    }

    postOrganization(formDataFK: Organization) {
        return this.http.post(this.rootURL+'/Customers', formDataFK)
    }

    refreshList()
    {
        this.http.get(this.rootURL+'/Customers')
        .toPromise().then(res => this.list = res as Customer[]);
    }

    add(arg0: { severity: string; summary: string; detail: string; }) {
      throw new Error("Method not implemented.");        
    }

    

    headers=["id","Name", "Role","Email", "Status", "Created_on", "Last_modified", "Rating", "Newsletter", "Subscription"];
    customers=[
        {
            id:"1",
            Name:'Alice Zune',
            Role:'Casting Assistance',
            Email:'jackBrad.yopmail.com',
            Status: "WAITING",
            Created_on: "18/03/2000",
            Last_modified : "11/03/2020",
            Rating: "5",
            Newsletter: "yes",
            Subscription: "Ristretto"
        }
    ];

    downloadFile(data, filename='data') {
        let csvData = this.ConvertToCSV(data, ['ID','Name', 'Role', 'Email', 'Status', 'Created on', 'Last modified', 'Rating', 'Newsletter', 'Subscription']);
        console.log(csvData)
        let blob = new Blob(['\ufeff' + csvData], { type: 'text/csv;charset=utf-8;' });
        let dwldLink = document.createElement("a");
        let url = URL.createObjectURL(blob);
        let isSafariBrowser = navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1;
        if (isSafariBrowser) {  //if Safari open in new window to save file with random filename.
            dwldLink.setAttribute("target", "_blank");
        }
        dwldLink.setAttribute("href", url);
        dwldLink.setAttribute("download", filename + ".csv");
        dwldLink.style.visibility = "hidden";
        document.body.appendChild(dwldLink);
        dwldLink.click();
        document.body.removeChild(dwldLink);
    }

    ConvertToCSV(objArray, headerList) {
         let array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
         let str = '';
         let row = 'S.No,';

         for (let index in headerList) {
             row += headerList[index] + ',';
         }
         row = row.slice(0, -1);
         str += row + '\r\n';
         for (let i = 0; i < array.length; i++) {
             let line = (i+1)+'';
             for (let index in headerList) {
                let head = headerList[index];

                 line += ',' + array[i][head];
             }
             str += line + '\r\n';
         }
         return str;
     }  
}
