import 'package:flutter/material.dart';

class SearchList {
  List <String>liste;
  String motTrouver;
  SearchList(){
    liste=[];
    motTrouver='';
  }


   List copier(List listeacopier){
    int limit =listeacopier.length-1;
    int index=0;
    while(index<=limit){
      this.liste.add(listeacopier[index]);
      index++;
    }
    return this.liste;
    }


    String chercher(String element){
      int index=0;
      bool exit=false;
      while(index<=this.liste.length-1){

        if(this.liste[index].toLowerCase()==element.toLowerCase()) {
          this.motTrouver=this.liste[index];
          exit=true;
          return this.motTrouver;
        }
        index++;
      }
      if(exit==false)
        {
          this.motTrouver='';
          return this.motTrouver;
        }


    }


    List destroy(){
    this.liste=[];
    return this.liste;
    }


  }




