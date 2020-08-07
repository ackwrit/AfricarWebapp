import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class utilisateur{
  String uid;
  String nom;
  String prenom;
  String compagnie;
  String telephone;
  String image;
  String type_utilisateur;


  utilisateur(DocumentSnapshot snapshot)
  {
    uid=snapshot.documentID;
    //id=snapshot.key;
    Map <String,dynamic>map = snapshot.data;
    nom = map['nom'];
    prenom = map['prenom'];
    compagnie =map['compagnie'];
    telephone =map['telephone'];
    image =map['image'];
    type_utilisateur =map['type_utilisateur'];
  }


  Map toMap()
  {
    Map map;
    return map ={
      map['nom']:nom,
      map['prenom']:prenom,
      map['uid']:uid,
      map['compagnie']:compagnie,
      map['telephone']:telephone,
      map['image']:image,
      map['type_utilisateur']:type_utilisateur,
    };
  }
}