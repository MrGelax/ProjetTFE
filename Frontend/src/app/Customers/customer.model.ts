export class Customer {
id: number;

    // UserId: number;

    // ProfessionnalName: string;

    email: string;

    firstName: string;

    lastName: string;

    // Avatar: string;

    // NationalRegistrationNumber: string;

    // Phone: string;

    // ParentFirstName: string;

    // ParentLastName: string;

    // IsChild: boolean;

    // IsBillingAddressSameAsAddress: boolean;

    // VAT: string;

    // IBAN: string;

    // BIC: string;

    // Birthdate: Date;

    // CreatedDateTime: Date;
    
    // LastmodifiedDateTime: Date;
    
    // LastProfileModification: Date;

    // ProfileViews: number;

    // CoverFile: string;

    // AddressStreet: string;

    // BillingAddressStreet: string;

    // AddressNumber: string;

    // AddressBox: string;

    // BillingAddressBox: string;

    // BillingAddressNumber: string;

    // Rating: number;

     mainRole: CustomerRole;

    // CustomerSubscription: CustomerSubscription;
    customerStatus: number;

    organizationId: number;

    // MainRoleId: number;

    // CultureId: number;

     CountryId: number;

    // CustomerSubscriptionId: number;

    // CustomerEventSetupId: number;

    organization: Organization;

       Country: Country;
}

export class CustomerRole {
    Id: number;

    systemName: string;

    CanBeChild: boolean;

    CreatedDateTime: Date;

    DeletedDateTime: Date;

    LastModifiedDateTime: Date;
}

export class CustomerSubscription {
    Id: number;

    Quantity: number;

    Credits: number;

    CreatedDateTime: Date;

    LastModifiedDateTime: Date;
}

export class Organization
    {
        id: number;

        companyName: string;
        
       /*  ContactFirstName: string;

        ContactLastName: string;

        Website: string;

        CreatedDateTime: Date;

        DeletedDateTime: Date;
        
        LastModifiedDateTime: Date; */
    }

    export class Country {
        id: number;
        name:string;
        code: string;
        createdDateTime:Date;
        lastModifiedDateTime:Date;
        currencyId:number;
        label:string;
        currency:Currency;
    }
export class Currency {
    id: number;
    systemName:string;
    code: string;
    symbole:string;
    codeSIPS:number
    createdDateTime:Date;
    lastModifiedDateTime:Date;
}
export class State {
    id: number;
    label:string;
    title: string;
    countryId:number
    createdDateTime:Date;
    lastModifiedDateTime:Date;
    country:Country;
}
export class City {
    id:number;
    label:string;
    title:string;
    zip:string;
    geography:string;
    createdDateTime:Date;
    lastModifiedDateTime:Date;
    geoPostCodeId:number;
    countryId:number;
    state:State;
    country:Country;
}