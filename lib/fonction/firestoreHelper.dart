import 'dart:io';

import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class firestoreHelper{
  //auth
  final authStore = FirebaseAuth.instance;


  Future<FirebaseUser> SignIn (String mail,String pwd,{String telephone,String prenom,String compagnie,String nom,String image,String typeUser}) async{
    final AuthResult authResult = await authStore.signInWithEmailAndPassword(email: mail, password: pwd);
    final FirebaseUser user=authResult.user;


    return user;
  }


  Future<FirebaseUser> record (String mail,String pwd,{String telephone,String prenom,String compagnie,String nom,String image,String typeUser,String referent}) async{
    final AuthResult authResult = await authStore.createUserWithEmailAndPassword(email: mail, password: pwd);
    final FirebaseUser user=authResult.user;
    String uid=user.uid;
    Map <String,dynamic>map={
      'telephone':telephone,
      'prenom':prenom,
      'compagnie':compagnie,
      'typeUtilisateur':typeUser,
      'uid':uid,
      'nom':nom,
      'image':image,
      'mail':mail,
      'referent':referent
    };
    addUser(map, uid);

    return user;
  }


  Future<FirebaseUser> CreateCompagnie(
      {@required String NIF,
        @required String mail,
        @required String pwd,
        @required String nomCompagnie,
        String nomDirigeant,
        String prenomDirigeant,
        String adresse,
        double pourcentage,
      })
  async {
    AuthResult authResult = await authStore.createUserWithEmailAndPassword(email: mail, password: pwd);
    FirebaseUser user =authResult.user;
    String uid =user.uid;
    Map <String,dynamic>map={
      'id':uid,
      'matricule':NIF,
      'nomCompagnie':nomCompagnie,
      'adresse':adresse,
      'mail':mail,
      'nomDirigeant':nomDirigeant,
      'logo':null,
      'prenomDirigeant':prenomDirigeant,
      'offre':'gratuit',
      'pourcentage':pourcentage,
    };
    addCompagnie(map, uid);
    return user;

  }




  //storage









  Future <String> savePicture(File file,StorageReference storageReference) async{
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }


  sendMessage(String texte,utilisateur user,utilisateur moi){
    DateTime date=DateTime.now();
    Map <String,dynamic>map={
      'from':moi.uid,
      'to':user.uid,
      'texte':texte,
      'envoiMessage':date
    };
    String idDate = date.microsecondsSinceEpoch.toString();
    addMessage(map, getMessageRef(moi.uid, user.uid, idDate));
    addConversation(getConversation(moi.uid, user, texte, date), moi.uid);
    addConversation(getConversation(user.uid, moi, texte, date), user.uid);




  }

  Map getConversation(String sender,utilisateur partenaire,String texte,DateTime date){
    Map <String,dynamic> map = partenaire.toMap();
    map ['idmoi']=sender;
    map['lastmessage']=texte;
    map['envoimessage']=date;
    map['destinateur']=partenaire.uid;

    return map;

  }


  String getMessageRef(String from,String to,String date){
    String resultat="";
    List<String> liste=[from,to];
    liste.sort((a,b)=>a.compareTo(b));
   for(var x in liste){
     resultat += x+"+";
   }
   resultat =resultat + date;
   return resultat;

  }









  //Database
static final data_instance = Firestore.instance;
  final fire_compagnie = data_instance.collection("compagnie");
  final fire_user =data_instance.collection("utilisateur");
  final fire_trajet=data_instance.collection("trajets");
  final fire_billet=data_instance.collection("billets");
  final fire_chiffre=data_instance.collection("chiffres");
  final fire_message=data_instance.collection('messages');
  final fire_conversation=data_instance.collection('conversations');
  final fire_soldBillet=data_instance.collection('soldBillets');


  addCompagnie(Map <String,dynamic>map,String uid)
  {
    fire_compagnie.document(uid).setData(map);
  }

  addUser(Map <String,dynamic>map,String uid)
  {
    fire_user.document(uid).setData(map);
  }


  addTrajet(Map <String,dynamic>map,String uid)
  {
    fire_trajet.document(uid).setData(map);
  }

  addMessage(Map<String,dynamic> map,String uid){
    fire_message.document(uid).setData(map);

  }

  addConversation(Map<String,dynamic> map,String uid){
    fire_conversation.document(uid).setData(map);

  }


  //Storage

  static final storage_instance=FirebaseStorage.instance.ref();
  final storage_logoCompagnie= storage_instance.child("logoCompagnie");
  final storage_logoUsers =storage_instance.child('logoUsers');


  Future<String> addImage(File file,StorageReference reference) async{
    StorageUploadTask task = reference.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String urlString = await snapshot.ref.getDownloadURL();
    return urlString;

  }


}