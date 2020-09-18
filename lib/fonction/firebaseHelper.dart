
import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/model/trajet.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_database/firebase_database.dart';


class firebaseHelper{
//authetification
  final auth = FirebaseAuth.instance;
  String verificationId;




//Authentification par mail

  Future<FirebaseUser> handleCreateMailCompagnie({String nif,String adresse,String mail,String password,String nomDirigeant,String prenomDirigeant})async{
    final AuthResult authResult = await auth.createUserWithEmailAndPassword(email: mail, password: password);
    FirebaseUser user =authResult.user;
    String uid= user.uid;
    Map map ={
      'id':uid,
      'matricule':nif,
      'adresse':adresse,
      'mail':mail,
      'nomeDirigeant':nomDirigeant,
      'prenomDirigeant':prenomDirigeant,
      'offre':'gratuit'
    };
    addCompagnie(uid, map);
    return user;

  }


  Future <void> handleSignPhone(String phone) async
  {
    final PhoneVerificationCompleted verified = (AuthCredential credential){
      auth.signInWithCredential(credential);

    };

    final PhoneVerificationFailed failed =(AuthException exception){
      print(exception);
    };


    final PhoneCodeSent phoneCodeSent =(String verifId,[int forceResend]){
      this.verificationId = verifId;


    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout =(String verifId){
      this.verificationId = verifId;

    };


    auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: failed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout
    );

  }


  Future<void> signOTP(smsCode,verifId)async{
    AuthCredential authCredential=PhoneAuthProvider.getCredential(
        verificationId: verifId,
        smsCode: smsCode);
    AuthResult authResult = await auth.signInWithCredential(authCredential);
    FirebaseUser user=authResult.user;
    String uid=user.uid;
    Map map={
      'nom':'',
      'prenom':'',
      'id':'',
      'compagnie':'',
      'telephone':'',
      'image':'',
      'type_utilisateur':'',
    };

  }


//database
  static final base=FirebaseDatabase.instance.reference();
  final base_user=base.child("utilisateur");
  final base_compagnie=base.child('compagnie');
  final base_trajet=base.child('trajet');

  static final data_instance = Firestore.instance;

  final base_billet=base.child('billet');
  final fire_compagnie = data_instance.collection("compagnie");
  final fire_user =data_instance.collection("utilisateur");
  final fire_trajet=data_instance.collection("trajets");
  final fire_billet=data_instance.collection("billets");




  Future<String> myId() async{
    FirebaseUser user = await auth.currentUser();
    return user.uid;


  }

  addUser(String uid,Map map)
  {
    fire_user.document(uid).setData(map);
  }


  Future<utilisateur> getUser(String uid) async
  {
    DocumentSnapshot snapshot = await fire_user.document(uid).get();
    return utilisateur(snapshot);
  }

  addCompagnie(String uid,Map map)
  {
    base_compagnie.child(uid).set(map);
  }











  addTrajet(String uid,Map map)
  {
    base_trajet.child(uid).set(map);
  }




}