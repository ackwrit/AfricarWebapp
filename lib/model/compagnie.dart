
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class compagnie{
  String id;
  String matricule;
  String adresse;
  String mail;
  String nomDirigeant;
  String prenomDirigeant;
  String offre;
  String logo;
  String nomCompagnie;
  double pourcentage;



  compagnie(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    Map map = snapshot.data;
    matricule = map['matricule'];
    adresse = map['adresse'];
    mail = map['mail'];
    nomDirigeant = map['nomDirigeant'];
    prenomDirigeant = map['prenomDirigeant'];
    offre = map['offre'];
    logo =map['logo'];
    nomCompagnie =map['nomCompagnie'];
    pourcentage =map['pourcentage'];

  }

  Map toMap(){
    Map map;
    return map ={
      map['id']:id,
      map['matricule']:matricule,
      map['adresse']:adresse,
      map['mail']:mail,
      map['nomDirigeant']:nomDirigeant,
      map['prenomDirigeant']:prenomDirigeant,
      map['offre']:offre,
      map['logo']:logo,
      map['nomCompagnie']:nomCompagnie,
      map['pourcentage']:pourcentage,

    };
  }

}