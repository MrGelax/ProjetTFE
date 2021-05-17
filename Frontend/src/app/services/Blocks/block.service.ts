import { Injectable } from '@angular/core';
import {Block} from "../../Blocks/block.model";
import {HttpClient} from "@angular/common/http";
import {BlocksModel} from "../../Blocks/blocks.model";
import {Observable} from "rxjs";
import {BlockLocal} from "../../Blocks/blockLocal.modal";

@Injectable()
export class BlockService {
  rootURL = "https://localhost:5001/api";
  constructor(private http: HttpClient) { }

  headers=["ID","System_Name","Label","URL"];

  GetAllBlocksBis()
  {
    return this.http.get(this.rootURL+'/Block');
  }
  GetAllBlocks(): Observable<BlocksModel>{
    return this.http.get<BlocksModel>(this.rootURL+'/Block');
  }
  CreateBlock(b:Block){
    return this.http.post<Block>(this.rootURL+'/Block',b);
  }
  CreateBlockLocal(b:BlockLocal){
    return this.http.post<BlockLocal>(this.rootURL+'/BlockLocal',b);
  }
  GetById(id:number){
    return this.http.get<Block>(this.rootURL+'/Block/'+id);
  }
  deleteBlock(id:number){
    return this.http.delete<Block>(this.rootURL+'/Block/'+id);
  }
}