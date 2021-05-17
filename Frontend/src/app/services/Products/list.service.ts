export class ProductsListService{
    headers=["ID","Typologie","Culture","ProductType","PayementType","ProductFunctionality","Status","Title"];
    productList=[
        {
            ID:1,
            Typologie:'Pro, Talent',
            Culture:'United Kingdom',
            ProductType:'FUNCTIONALITY',
            PayementType:'MONEY',
            ProductFunctionality:'29/45/4894',
            Status:'Published',
            Title:'casting 123',
            EitCultureId:{ label: 'Bulgaria',id: 15},
            DisplayOrder:20,
            IsFavorite:true,
            Description:"Blabla Une deux trois",
            Price:75.00,
            Discount:"",
            Numcredit:15,
            Setupfee:"",
            minQt:10,
            LinkedRoles:[]
        },
        {
            ID:15,
            Typologie:'Betty',
            Culture:'Belgium',
            ProductType:'FUNCTIONALITY',
            PayementType:'CC_CREDIT',
            ProductFunctionality:'29/45/4894',
            Status:'Completed',
            Title:'20/45/789',
            EitCultureId:{ label: 'Bulgaria',id: 1},
            DisplayOrder:"",
            IsFavorite:"",
            Description:"",
            Price:"",
            Discount:"",
            Numcredit:"",
            Setupfee:"",
            minQt:10,
            LinkedRoles:[]
        },
        {
            ID:5,
            Typologie:'Betty',
            Culture:'Belgïe',
            ProductType:'ACCESS',
            PayementType:'CC_CREDIT',
            ProductFunctionality:'29/45/4894',
            Status:'Payement Incomplete',
            Title:'20/45/789',
            EitCultureId:{ label: 'Bulgaria',id: 1},
            DisplayOrder:"",
            IsFavorite:"",
            Description:"",
            Price:"",
            Discount:"",
            Numcredit:"",
            Setupfee:"",
            minQt:10,
            LinkedRoles:[]
        },
        {
            ID:987,
            Typologie:'Betty',
            Culture:'Actrice',
            ProductType:'ACCESS',
            PayementType:'MONEY',
            ProductFunctionality:'29/45/4894',
            Status:'Canceled',
            Title:'20/45/789',
            EitCultureId:{ label: 'Bulgaria',id: 1},
            DisplayOrder:"",
            IsFavorite:"",
            Description:"",
            Price:"",
            Discount:"",
            Numcredit:"",
            Setupfee:"",
            minQt:10,
            LinkedRoles:[]
        },
        {
            ID:547,
            Typologie:'Betty',
            Culture:'Actrice',
            ProductType:'CREDIT',
            PayementType:'CC_CREDIT',
            ProductFunctionality:'29/45/4894',
            Status:'Created',
            Title:'20/45/789',
            EitCultureId:{ label: 'Bulgaria',id: 1},
            DisplayOrder:"",
            IsFavorite:"",
            Description:"",
            Price:"",
            Discount:"",
            Numcredit:"",
            Setupfee:"",
            minQt:10,
            LinkedRoles:[]
        },
        {
            ID:924,
            Typologie:'Betty',
            Culture:'Actrice',
            ProductType:'FUNCTIONALITY',
            PayementType:'MONEY',
            ProductFunctionality:'29/45/4894',
            Status:'Completed',
            Title:'20/45/789',
            EitCultureId:{ label: 'Bulgaria',id: 1},
            DisplayOrder:"",
            IsFavorite:"",
            Description:"",
            Price:"",
            Discount:"",
            Numcredit:"",
            Setupfee:"",
            minQt:10,
            LinkedRoles:[]
        }
    ];
    statusList=[
        { label: 'Created', value: 'Created' },
        { label: 'Pending', value: 'Pending' },
        { label: 'Completed', value: 'Completed' },
        { label: 'Canceled', value: 'Canceled' },
        { label: 'Payement Incomplete', value: 'Payement Incomplete' },
        { label: 'Payement Error', value: 'Payement Error' }
    ];
    payType=[
        { label: 'CC_CREDIT', value: 'CC_CREDIT' },
        { label: 'MONEY', value: 'MONEY' }
    ];
    prodType=[
        { label: 'FUNCTIONALITY', value: 'FUNCTIONALITY' },
        { label: 'CREDIT', value: 'CREDIT' },
        { label: 'ACCESS', value: 'ACCESS' }
    ];
    create_statusList=["Published","Unpublished"];
    create_eitcultureList=[
        { label: 'Bulgaria',id: 15},
        { label: 'Belgium', id: 278},
        { label: 'Austria', id: 93},
        { label: 'Germany', id: 42},
        { label: 'Irland', id: 502},
        { label: 'Spain', id: 768}
    ];
    getProducsByID(id:number){
        const produc=this.productList.find(
            (s)=>{
                return s.ID===id;
            }
        );
        return produc;
    }
}
