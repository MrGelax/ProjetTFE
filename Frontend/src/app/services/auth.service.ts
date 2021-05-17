
export class AuthService{
    isAuth=false;
    user=[
        {droit:"Staging"},
        {droit:"Production"},
        {droit:"Staging"},

    ];
    signIn(){
        let i=0;
        while(i<this.user.length ){
            if(this.user[i].droit=="Jean"){
                this.isAuth=true;
            }
            i++
        }
        
    }
}