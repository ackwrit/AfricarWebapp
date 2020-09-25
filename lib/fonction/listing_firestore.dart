

import 'dart:html';

import 'package:africarwebapp/fonction/conversion.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/billet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';


class analyseCompagnie{
  int affaireJan=0;
  int affaireFev=0;
  int affaireMar=0;
  int affaireAvr=0;
  int affaireMai=0;
  int affaireJuin=0;
  int affaireJuil=0;
  int affaireAou=0;
  int affaireSep=0;
  int affaireOct=0;
  int affaireNov=0;
  int affaireDec=0;
  int affaitreTotal=0;
  DateTime annee =DateTime.now();
  String identifiant='';

  analyseCompagnie(String identifiant){
    this.identifiant=identifiant;

  }


  int getNombre(var number){
    return number;
  }



  reset(){
    this.affaireJan=0;
    this.affaireFev=0;
    this.affaireMar=0;
    this.affaireAvr=0;
    this.affaireMai=0;
    this.affaireJuin=0;
    this.affaireJuil=0;
    this.affaireAou=0;
    this.affaireSep=0;
    this.affaireOct=0;
    this.affaireNov=0;
    this.affaireDec=0;
    this.affaitreTotal=0;

  }



  void parcours(){
    reset();
    Stream flux;
    String idCompAller;
    String idCompRetour;
    int prixA;
    int prixB;
    bool valide;
    DateTime emis;
    flux=firestoreHelper().fire_billet.orderBy('emission').snapshots();
    flux.listen((snapshot){
      snapshot.documents.forEach((doc){
        idCompAller=doc.data['idCompagnieAller'];
        idCompRetour=doc.data['idCompagnieRetour'];
        prixA=doc.data['prixAller'];
        prixB=doc.data['prixRetour'];
        valide=doc.data['validate'];
        emis=conversion().readTimestamp(doc.data['emission']);
        Map <String,dynamic>map={
          'idCompagnieAller':idCompAller,
          'idCompagnieRetour':idCompRetour,
          'prixAller':prixA,
          'prixRetour':prixB,
          'validate':valide,
          'emission':emis
        };
        if(valide==true && annee.year==emis.year)
          {
            //verifciation idCompagnie et CompagnieRetourId
            if(idCompAller==identifiant){
              //test pour enregsitrer dans les différents mois analyse
              if(emis.month-1==0)
              {
                this.affaireJan=this.affaireJan+prixA;
              }
              if(emis.month-1==1)
              {
                this.affaireFev=this.affaireFev+prixA;
              }
              if(emis.month-1==2)
              {
                this.affaireMar=this.affaireMar+prixA;
              }
              if(emis.month-1==3)
              {
                this.affaireAvr=this.affaireAvr+prixA;
              }
              if(emis.month-1==4)
              {
                this.affaireMai=this.affaireMai+prixA;
              }
              if(emis.month-1==5)
              {
                this.affaireJuin=this.affaireJuin+prixA;
              }
              if(emis.month-1==6)
              {
                this.affaireJuil=this.affaireJuil+prixA;
              }
              if(emis.month-1==7)
              {
                this.affaireAou=this.affaireAou+prixA;
              }
              if(emis.month-1==8)
              {
                this.affaireSep=this.affaireSep+prixA;
              }
              if(emis.month-1==9)
              {
                this.affaireOct=this.affaireOct+prixA;
              }
              if(emis.month-1==10)
              {
                this.affaireNov=this.affaireNov+prixA;
              }
              if(emis.month-1==11)
              {
                this.affaireDec=this.affaireDec+prixA;
              }
            }
            this.affaitreTotal=this.affaireDec+this.affaireNov+this.affaireOct+this.affaireSep+this.affaireJan+this.affaireFev+this.affaireMar+this.affaireMai+this.affaireJuin+this.affaireJuil+this.affaireAou;
            print(affaitreTotal);











          }

      });
    });



    
  }

  void listingCA()
  {
    parcours();

  }






}