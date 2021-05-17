import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CustomerManageService } from 'src/app/services/Customers/customerManage.service';
import { FormBuilder, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-profile-info-edit',
  templateUrl: './profile-info-edit.component.html',
  styleUrls: ['./profile-info-edit.component.css']
})
export class ProfileInfoEditComponent implements OnInit {
  obj:any;
  form:FormGroup;
  constructor(private custom:CustomerManageService,private route:ActivatedRoute,
    private router:Router,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    const id=this.route.snapshot.params['id'];
    this.obj=this.custom.getProfileInfoID(+id);
    this.form=this.formBuilder.group({
      secteur:this.formBuilder.group({
        archi:[this.obj.Secteur.archi],
        cine:[this.obj.Secteur.cine],
        mode:[this.obj.Secteur.mode],
        event:[this.obj.Secteur.event],
        artsSpec:[this.obj.Secteur.artsSpec],
        musique:[this.obj.Secteur.musique],
        theatre:[this.obj.Secteur.theatre],
        tVMedia:[this.obj.Secteur.tVMedia],
        miniDoc:[this.obj.Secteur.miniDoc],
        platMultiCam:[this.obj.Secteur.platMultiCam]
      }),
      specialisation:this.formBuilder.group({
        accessoires:[this.obj.Specialisation.accessoires],
        shoot_Com:[this.obj.Specialisation.shoot_Com],
        deco:[this.obj.Specialisation.deco],
        effetsFx:[this.obj.Specialisation.effetsFx],
        defile:[this.obj.Specialisation.defile]
      }),
      competence:this.formBuilder.group({
        art:[this.obj.Competence.art],
        regi_Lum:[this.obj.Competence.regi_Lum],
        regiSon:[this.obj.Competence.regiSon],
        staf:[this.obj.Competence.staf],
        menui:[this.obj.Competence.menui],
        studio:[this.obj.Competence.studio],
        constru:[this.obj.Competence.constru],
        ensemblier:[this.obj.Competence.ensemblier],
        peintre:[this.obj.Competence.peintre],
        lum:[this.obj.Competence.lum]
      }),
      experience:this.formBuilder.group({
        presentation:[this.obj.Experience.presentation],
        ansExp:[this.obj.Experience.ansExp]
      }),
      references:this.formBuilder.group({
        refs:[this.obj.Refs.refs],
        site:[this.obj.Refs.site],
        insta:[this.obj.Refs.insta],
        fb:[this.obj.Refs.fb],
        twit:[this.obj.Refs.twit]
      }),
      diplomes:[this.obj.Diplomes.diplome_formation],
      langues:this.formBuilder.group({
        fr:[this.obj.Langues.fr],
        en:[this.obj.Langues.en],
        it:[this.obj.Langues.it],
        es:[this.obj.Langues.es],
        de:[this.obj.Langues.de],
        ndls:[this.obj.Langues.ndls],
        ru:[this.obj.Langues.ru],
        ch:[this.obj.Langues.ch],
        other:[this.obj.Langues.other],
      })
    });
  }
  createTab(){
    let tab=new Array;
    let i=1;
    for (let index=0;index<50; index++) {
      tab[index]=i;
      i++;
    }
    return tab;
  }
  onSubmit(){
    this.obj.Specialisation.accessoires=this.form.get('specialisation').get('accessoires').value;
    this.obj.Specialisation.shoot_Com=this.form.get('specialisation').get('shoot_Com').value;
    this.obj.Specialisation.deco=this.form.get('specialisation').get('deco').value;
    this.obj.Specialisation.effetsFx=this.form.get('specialisation').get('effetsFx').value;
    this.obj.Specialisation.defile=this.form.get('specialisation').get('defile').value;

    this.obj.Competence.art=this.form.get('competence').get('art').value;
    this.obj.Competence.regi_Lum=this.form.get('competence').get('regi_Lum').value;
    this.obj.Competence.regiSon=this.form.get('competence').get('regiSon').value;
    this.obj.Competence.staf=this.form.get('competence').get('staf').value;
    this.obj.Competence.menui=this.form.get('competence').get('menui').value;
    this.obj.Competence.studio=this.form.get('competence').get('studio').value;
    this.obj.Competence.constru=this.form.get('competence').get('constru').value;
    this.obj.Competence.ensemblier=this.form.get('competence').get('ensemblier').value;
    this.obj.Competence.peintre=this.form.get('competence').get('peintre').value;
    this.obj.Competence.lum=this.form.get('competence').get('lum').value;

    this.obj.Experience.presentation=this.form.get('experience').get('presentation').value;
    this.obj.Experience.ansExp=this.form.get('experience').get('ansExp').value;

    this.obj.Refs.refs=this.form.get('references').get('refs').value;
    this.obj.Refs.site=this.form.get('references').get('site').value;
    this.obj.Refs.insta=this.form.get('references').get('insta').value;
    this.obj.Refs.fb=this.form.get('references').get('fb').value;
    this.obj.Refs.twit=this.form.get('references').get('twit').value;

    this.obj.Langues.fr=this.form.get('langues').get('fr').value;
    this.obj.Langues.en=this.form.get('langues').get('en').value;
    this.obj.Langues.it=this.form.get('langues').get('it').value;
    this.obj.Langues.es=this.form.get('langues').get('es').value;
    this.obj.Langues.de=this.form.get('langues').get('de').value;
    this.obj.Langues.ndls=this.form.get('langues').get('ndls').value;
    this.obj.Langues.ru=this.form.get('langues').get('ru').value;
    this.obj.Langues.ch=this.form.get('langues').get('ch').value;
    this.obj.Langues.other=this.form.get('langues').get('other').value;
    
    this.obj.Diplomes.diplome_formation=this.form.get('diplomes').value;

    this.obj.Secteur.archi=this.form.get('secteur').get('archi').value;
    this.obj.Secteur.cine=this.form.get('secteur').get('cine').value;
    this.obj.Secteur.mode=this.form.get('secteur').get('mode').value;
    this.obj.Secteur.event=this.form.get('secteur').get('event').value;
    this.obj.Secteur.artsSpec=this.form.get('secteur').get('artsSpec').value;
    this.obj.Secteur.musique=this.form.get('secteur').get('musique').value;
    this.obj.Secteur.theatre=this.form.get('secteur').get('theatre').value;
    this.obj.Secteur.tVMedia=this.form.get('secteur').get('tVMedia').value;
    this.obj.Secteur.miniDoc=this.form.get('secteur').get('miniDoc').value;
    this.obj.Secteur.platMultiCam=this.form.get('secteur').get('platMultiCam').value;
    this.custom.updateCustomerProfilInfo(this.obj);
    this.router.navigate(['Customer/view/'+this.obj.ID]);
  }
}
