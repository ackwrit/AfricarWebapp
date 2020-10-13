import 'package:africarwebapp/fonction/conversion.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';



class analyseCompagnie {

  DateTime annee = DateTime.now();
  String identifiant = '';

  analyseCompagnie(String identifiant) {
    this.identifiant = identifiant;
    //this.affaireJan=getChiffreMois(DateTime(annee.year,DateTime.january));
    //this.affaireFev=getChiffreMois(DateTime(annee.year,DateTime.february));
    //this.affaireMar=getChiffreMois(DateTime(annee.year,DateTime.march));
    //this.affaireAvr=getChiffreMois(DateTime(annee.year,DateTime.april));
    // this.affaireMai=getChiffreMois(DateTime(annee.year,DateTime.may));
    //this.affaireJuin=getChiffreMois(DateTime(annee.year,DateTime.june));
    //this.affaireJuil=getChiffreMois(DateTime(annee.year,DateTime.july));
    //this.affaireAou=getChiffreMois(DateTime(annee.year,DateTime.august));
    //affaireSep=getChiffreMois(DateTime(annee.year,DateTime.september));
    //this.affaireOct=getChiffreMois(DateTime(annee.year,DateTime.october));
    //this.affaireNov=getChiffreMois(DateTime(annee.year,DateTime.november));
    //this.affaireDec=getChiffreMois(DateTime(annee.year,DateTime.december));


  }


  int getNombre(int number) {
    return number;
  }


  int getChiffreMois(DateTime periode) {
    int chiffreAffaire = 0;
    Stream flux;
    String idCompAller;
    String idCompRetour;
    int prixA;
    int prixB;
    bool valide;
    DateTime emis;
    int compteur = 0;
    List<Map<String, dynamic>>listMap = [];
    flux = firestoreHelper().fire_billet.orderBy('emission').snapshots();

    flux.listen((event) {
      event.documents.forEach((doc) {
        idCompAller = doc.data['idCompagnieAller'];
        idCompRetour = doc.data['idCompagnieRetour'];
        prixA = doc.data['prixAller'];
        prixB = doc.data['prixRetour'];
        valide = doc.data['validate'];
        emis = conversion().readTimestamp(doc.data['emission']);
        Map <String, dynamic>map = {
          'idCompagnieAller': idCompAller,
          'idCompagnieRetour': idCompRetour,
          'prixAller': prixA,
          'prixRetour': prixB,
          'validate': valide,
          'emission': emis
        };
        listMap.add(map);
      });


      while (compteur < listMap.length) {
        Map provisionMap = listMap[compteur];

        if (provisionMap.values
            .elementAt(5)
            .month == periode.month) {
          print('mois de septembre');
          //tester pour l'id compagnie aller et retour;
          chiffreAffaire = chiffreAffaire + provisionMap.values.elementAt(2);
        }


        //print('taille getMois');
        compteur++;
      }
      print(chiffreAffaire);
      return chiffreAffaire;
    });
    return chiffreAffaire;
  }



}






