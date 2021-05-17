import {Injectable} from '@angular/core';

@Injectable()
export class OrderListService{
    add(arg0: { severity: string; summary: string; detail: string; }) {
        throw new Error("Method not implemented.");   
    }
    headers=["ID","Name","TVA","Role","Created_On","Order_Status","Payment_Method","Product","Price","Bill"];
    orders=[
        {
            ID:154,
            CustomerID:167,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"Acteur",
            Created_On:'20/05/1259',
            Order_Status:'Pending',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"jfh"
        },
        {
            ID:157,
            CustomerID:84,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"Cinéaste",
            Created_On:'21/05/2019',
            Order_Status:'Created',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"sdfhdfsg"
        },
        {
            ID:1985,
            CustomerID:982,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"Chanteur",
            Created_On:'19/12/2020',
            Order_Status:'Blabla',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"jfdhdsj"
        },
        {
            ID:156678,
            CustomerID:84,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"Acteur",
            Created_On:'01/01/1900',
            Order_Status:'Blabla',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"jdhfj"
        },
        {
            ID:822,
            CustomerID:34,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"",
            Created_On:'Carte',
            Order_Status:'Blabla',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"dsjhf"
        },
        {
            ID:1756,
            CustomerID:84,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"",
            Created_On:'Carte',
            Order_Status:'Blabla',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"fdfsfsdsdf"
        },
        {
            ID:145,
            CustomerID:982,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"",
            Created_On:'Carte',
            Order_Status:'Blabla',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"zerarat"
        },
        {
            ID:2657,
            CustomerID:982,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"",
            Created_On:'Carte',
            Order_Status:'Blabla',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"ezagfdg"
        },
        {
            ID:157,
            CustomerID:982,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"",
            Created_On:'Carte',
            Order_Status:'Blabla',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"jujuyreaz"
        },
        {
            ID:285,
            CustomerID:167,
            Name:'Lucie Vasseur - Kasting Kafe',
            TVA:'0025-2225-9674-4785',
            Role:"",
            Created_On:'Carte',
            Order_Status:'Blabla',
            Payment_Method:"Virement bancaire",
            Product:"Chocolat",
            Price:12,
            Bill:"juigdujyugiquikj"
        }
    ];
    statusList=["Created","Pending","Completed","Canceled","Payement_Incomplete","Payement_Error"];
    payementModeList=["CC_Credit","Online","Bank_Trasnfert","Online_Wallet"];

    productList=[""];
    downloadFile(data, filename='data') {
        let csvData = this.ConvertToCSV(data, ["ID","Name",
            "TVA","Created_On","Order_Status","Payment_Method","Product","Price","Bill"]);
        console.log(csvData)
        let blob = new Blob(['\ufeff' + csvData], { type: 'text/csv;charset=utf-8;' });
        let dwldLink = document.createElement("a");
        let url = URL.createObjectURL(blob);
        let isSafariBrowser=navigator.userAgent.indexOf('Safari')!=-1&& navigator.userAgent.indexOf('Chrome') == -1;
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
    getOrdersByID(id:number){
        const order=this.orders.find(
            (s)=>{
                return s.ID===id;
            }
        );
        return order;
    }
}
