
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class trajet{
  String id;
  String depart;
  String destination;
  String heureDepart;
  String heureDestination;
  int prix;
  String idCompagnie;


  trajet(DocumentSnapshot snapshot)
  {
    id= snapshot.documentID;
    Map map = snapshot.data;
    depart=map['depart'];
    destination=map['destination'];
    //heureDepart=map['heureDepart'];
    //heureDestination=map['heureDestination'];
    prix=map['prix'];
    idCompagnie=map['idCompagnie'];
  }

  Map toMap(){
    Map map;
    return map={
      map['depart']:depart,
      map['destination']:destination,
      //map['heureDepart']:heureDepart,
      //map['heureDestination']:heureDestination,
      map['prix']:prix,
      map['idCompagnie']:idCompagnie,

    };

}
}

