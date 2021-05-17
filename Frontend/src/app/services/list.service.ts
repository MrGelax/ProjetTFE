import { Block } from '../Blocks/block.model';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

interface BlockListResponse {
        totalCount: string;
        blocks: Block[];
} 
 
@Injectable()
export class ListService{
      
    formData: Block;
    blockList: Block[];
    data: BlockListResponse; 
    readonly rootURL = "https://localhost:5001/api";


    constructor (private http: HttpClient) {}

    postBlock(formData: Block) {
        return this.http.post(this.rootURL+'/Block', formData)
    }

    refreshList(): Promise<any>
    {
        return this.http.get(this.rootURL+'/Block')
        .toPromise().then(res => {this.data = res as BlockListResponse;
        console.log(res);
        //this.blockList = res.blocks;
          })
    }

    headers=["ID","System_Name","Label","URL"];
    listBlock=[
        {
            ID:1,
            System_Name:'Actrice',
            Label:'Carte',
            URL:'Demain'
        }
        
    ];
   blocks=[
        {
            ID:16,
            System_Name:'Account_Increase_My_Visibility',
            Label:'Block displayed as information about buying of visibility.',
            URL:'BlaBla/Jean/123'
        }
    ]; 
}