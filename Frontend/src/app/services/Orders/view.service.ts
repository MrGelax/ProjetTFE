import {Injectable} from '@angular/core';

@Injectable()
export class OrderViewService{
    add(arg0: { severity: string; summary: string; detail: string; }) {
        throw new Error("Method not implemented.");   
    }
    views=[
        {
            Culture:"FR",
            url:'http://staging.kastingkafe.fr/a-propos-de'
        },
        {
            Culture:"DE",
            url:'http://staging.kastingkafe.fr/a-propos-de'
        },
        {
            Culture:"EN",
            url:'http://staging.kastingkafe.fr/a-propos-de'
        },
    ];
}
