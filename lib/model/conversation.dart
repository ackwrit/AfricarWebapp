import 'package:africarwebapp/model/utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation{
  String idConversation;
  String idmoi;
  String lastMessage;
  utilisateur user;
  String destinateur;

  Conversation(DocumentSnapshot snapshot){
    idConversation =snapshot.documentID;
    Map map =snapshot.data;
    idConversation = map['idConversation'];
    lastMessage = map['lastMessage'];
    idmoi = map['idmoi'];
    user= utilisateur(snapshot);
    destinateur=user.uid;






  }





}