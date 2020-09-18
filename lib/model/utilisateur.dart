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
  String typeUtilisateur;
  String mail;
  String referent;


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
    uid=map['uid'];
    type_utilisateur =map['type_utilisateur'];
    typeUtilisateur=map['typeUtilisateur'];
    mail=map['mail'];
    referent=map['referent'];
  }


  Map toMap()
  {
    Map <String,dynamic>map;
    return map ={
      'mail':mail,
      'nom':nom,
      'prenom':prenom,
      'uid':uid,
      'compagnie':compagnie,
      'telephone':telephone,
      'image':image,
      'type_utilisateur':type_utilisateur,
      'referent':referent,
      'typeUtilisateur':typeUtilisateur
    };
  }
}