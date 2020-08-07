import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class firestoreHelper{
  //auth
  final authStore = FirebaseAuth.instance;


  Future<FirebaseUser> SignIn (String mail,String pwd) async{
    final AuthResult authResult = await authStore.signInWithEmailAndPassword(email: mail, password: pwd);
    final FirebaseUser user=authResult.user;
    return user;
  }


  Future<FirebaseUser> CreateCompagnie(
      {@required String NIF,
        @required String mail,
        @required String pwd,
        String nomDirigeant,
        String prenomDirigeant,
        String adresse,
      })
  async {
    AuthResult authResult = await authStore.createUserWithEmailAndPassword(email: mail, password: pwd);
    FirebaseUser user =authResult.user;
    String uid =user.uid;
    Map <String,dynamic>map={
      'id':uid,
      'matricule':NIF,
      'adresse':adresse,
      'mail':mail,
      'nomeDirigeant':nomDirigeant,
      'prenomDirigeant':prenomDirigeant,
      'offre':'gratuit'
    };
    addCompagnie(map, uid);
    return user;

  }









  //Database
static final data_instance = Firestore.instance;
  final fire_compagnie = data_instance.collection("compagnie");
  final fire_user =data_instance.collection("utilisateur");


  addCompagnie(Map <String,dynamic>map,String uid)
  {
    fire_compagnie.document(uid).setData(map);
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