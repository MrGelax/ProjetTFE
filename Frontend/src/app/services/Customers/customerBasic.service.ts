import { Injectable } from '@angular/core';
import { Customer } from 'src/app/Customers/customer.model';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class CustomerBasicService{
        
    formData: Customer;
    list: Customer[];
    readonly rootURL = "https://localhost:44341/api";

    constructor (private http: HttpClient) {}

    postCustomer(formData: Customer) {
        return this.http.post(this.rootURL+'/Customers', formData)
    }

    refreshList()
    {
        this.http.get(this.rootURL+'/Customers')
        .toPromise().then(res => this.list = res as Customer[]);
    }
    
    add(arg0: { severity: string; summary: string; detail: string; }) {
      throw new Error("Method not implemented.");   
    }

    headers=["ID","Name", "Role","Email", "Status", "Created on", "Last modified", "Rating", "Newsletter", "Subscription", "Country", "City", "Gender", "Age"];
    customers=[
        {
            ID:"1",
            Name:'Alice Zune',
            Country: "Belgium",
            City: "Brussels",
            Gender:'Female',
            Age: "28",
            Role:'Casting Assistance',
            Email:'jackBrad.yopmail.com',
            Status: "WAITING",
            "Created on": "18/03/2000",
            "Last modified" : "11/03/2020",
            Rating: "5",
            Newsletter: "yes",
            Subscription: "Ristretto"
        },
        {
            ID:2,
            Name:'Pedro Da Silva',
            Country: "France",
            City: "Lille",
            Age: "25",
            Gender:'Male',
            Role:'Casting Director',
            Email:'pedro_dasilva.yopmail.com',
            Status: "WAITING",
            "Created on": "5/06/2012",
            "Last modified": "19/02/2020",
            Rating: "5",
            Newsletter: "no",
            Subscription: "Ristretto"
        },
        {
            ID:3,
            Name:'Reda ',
            Country: "France",
            City: "Paris",
            Gender:'Male',
            Age: "21",
            Role:'Musician',
            Email:'reda.yopmail.com',
            Status: "VALIDATION",
            "Created on": "07/08/2005",
            "Last modified": "11/03/2020",
            Rating: "5",
            Newsletter: "yes",
            Subscription: "test"
        },
        {
            ID:4,
            Name:'Betty',
            Country: "United Kingdom",
            City: "London",
            Gender:'Female',
            Age: "35",
            Role:'Musician',
            Email:'betty9.yopmail.com',
            Status: "VALIDATION",
            "Created on": "28/02/1995",
            "Last modified": "11/04/2020",
            Rating: "5",
            Newsletter: "no",
            Subscription: "test"
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