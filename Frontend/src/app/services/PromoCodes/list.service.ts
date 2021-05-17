export class PromoCodesListService {
    headers = ["ID", "Name", "Code", "Type", "Reduction", "Valid_from", "Valid_until"];
    promoCodeList = [
        {
            ID: 25,
            Name: "Promo école ESA",
            Code: "Promo ESA",
            Type: "amount",
            Reduction: "100",
            Valid_from: "24/03/2020",
            Valid_until: "24/04/2020",
            qtMax: 10,
            Role: {
                Talent: ["Actor", "Art Director", "Builder"],
                Pro: ["Location Manager", "Model", "Musician"]
            },
            Product: {
                belgique: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                belgium: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                fr: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                uk: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],

            }
        },
        {
            ID: 256,
            Name: "Promo �cole ESA",
            Code: "Promo ESA",
            Type: "amount",
            Reduction: "100",
            Valid_from: "24/03/2020",
            Valid_until: "24/04/2020",
            qtMax: 15,
            Role: {
                Talent: ["Actor", "Art Director", "Builder"],
                Pro: ["Location Manager", "Model", "Musician"]
            },
            Product: {
                belgique: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                belgium: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                fr: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                uk: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],

            }
        },
        {
            ID: 5,
            Name: "Promo �cole ESA",
            Code: "Promo ESA",
            Type: "amount",
            Reduction: "100",
            Valid_from: "24/03/2020",
            Valid_until: "24/04/2020",
            qtMax: 53,
            Role: {
                Talent: ["Actor", "Art Director", "Builder"],
                Pro: ["Location Manager", "Model", "Musician"]
            },
            Product: {
                belgique: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                belgium: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                fr: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                uk: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],

            }
        },
        {
            ID: 145,
            Name: "Promo �cole ESA",
            Code: "Promo ESA",
            Type: "amount",
            Reduction: "100",
            Valid_from: "24/03/2020",
            Valid_until: "24/04/2020",
            qtMax: 7,
            Role: {
                Talent: ["Actor", "Art Director", "Builder"],
                Pro: ["Location Manager", "Model", "Musician"]
            },
            Product: {
                belgique: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                belgium: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                fr: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                uk: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],

            }
        },
        {
            ID: 51,
            Name: "Promo �cole ESA",
            Code: "Promo ESA",
            Type: "amount",
            Reduction: "100",
            Valid_from: "24/03/2020",
            Valid_until: "24/04/2020",
            qtMax: 15,
            Role: {
                Talent: ["Actor", "Art Director", "Builder"],
                Pro: ["Location Manager", "Model", "Musician"]
            },
            Product: {
                belgique: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                belgium: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                fr: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                uk: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],

            }
        },
        {
            ID: 14,
            Name: "Promo �cole ESA",
            Code: "Promo ESA",
            Type: "amount",
            Reduction: "100",
            Valid_from: "24/03/2020",
            Valid_until: "24/04/2020",
            qtMax: 15,
            Role: {
                Talent: ["Actor", "Art Director", "Builder"],
                Pro: ["Location Manager", "Model", "Musician"]
            },
            Product: {
                belgique: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                belgium: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                fr: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],
                uk: ["Ristretto - Published", "Lungo - Unpublished", "Mocha - Unpublished"],

            }
        }
    ];
    statusList = [
        { label: 'Created', value: 'Created' },
        { label: 'Pending', value: 'Pending' },
        { label: 'Completed', value: 'Completed' },
        { label: 'Canceled', value: 'Canceled' },
        { label: 'Payement Incomplete', value: 'Payement Incomplete' },
        { label: 'Payement Error', value: 'Payement Error' }
    ];
    type = [
        { label: 'AMOUNT', value: 'amount' },
        { label: 'PERCENTAGE', value: 'percentage' }
    ];
    prodType = [
        { label: 'FUNCTIONALITY', value: 'FUNCTIONALITY' },
        { label: 'CREDIT', value: 'CREDIT' },
        { label: 'ACCESS', value: 'ACCESS' }
    ];
    create_statusList = ["Published", "Unpublished"];
    create_eitcultureList = [
        { label: 'Bulgaria', id: 1 },
        { label: 'Belgium', id: 2 },
        { label: 'Austria', id: 3 },
        { label: 'Germany', id: 4 },
        { label: 'Irland', id: 5 },
        { label: 'Spain', id: 6 }
    ];
    views = [
        {
            Culture: "FR",
            url: 'http://staging.kastingkafe.fr/a-propos-de'
        },
        {
            Culture: "DE",
            url: 'http://staging.kastingkafe.fr/a-propos-de'
        },
        {
            Culture: "EN",
            url: 'http://staging.kastingkafe.fr/a-propos-de'
        },
    ];
    getpromoCodeByID(id: number) {
        const promoCode = this.promoCodeList.find(
            (s) => {
                return s.ID === id;
            }
        );
        return promoCode;
    }
    downloadFile(data, filename = 'data') {
        let csvData = this.ConvertToCSV(data, ["ID", "Name", "Code", "Type", "Reduction", "Valid_from", "Valid_until"]);
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
            let line = (i + 1) + '';
            for (let index in headerList) {
                let head = headerList[index];

                line += ',' + array[i][head];
            }
            str += line + '\r\n';
        }
        return str;
    }
}