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

    // MainRole: CustomerRole;

    // CustomerSubscription: CustomerSubscription;

    // CustomerStatus: number;

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

    SystemName: string;

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

    export class Country
    {
        
        Id: number;

        //public string SystemName { get; set; }

        Code: string;

        //public int CurrencyId { get; set; }//FK

        CreatedDateTime: Date;

        LastModifiedDateTime: Date;
    }