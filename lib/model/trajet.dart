
import 'package:africarwebapp/fonction/conversion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class trajet{
  String id;
  String depart;
  String destination;
  DateTime heureDepart;
  DateTime heureDestination;
  double prix;
  String idCompagnie;
  String logoCompagnie;
  String nomCompagnie;
  double pourcentage;



  trajet(DocumentSnapshot snapshot)
  {
    id= snapshot.documentID;
    Map map = snapshot.data;
    depart=map['depart'];
    destination=map['destination'];
    heureDepart=conversion().readTimestamp(map['heureDepart']);
    //heureDestination=conversion().readTimestamp(map['heureDestination']);
    prix=map['prix'];
    idCompagnie=map['idCompagnie'];
    logoCompagnie=map['logoCompagnie'];
    nomCompagnie=map['nomCompagnie'];
    pourcentage =map['pourcentage'];
  }

  Map toMap(){
    Map map;
    return map={
      map['depart']:depart,
      map['destination']:destination,
      map['heureDepart']:heureDepart.millisecondsSinceEpoch,
      //map['heureDestination']:Timestamp.fromMillisecondsSinceEpoch(heureDestination.millisecondsSinceEpoch),
      map['prix']:prix,
      map['idCompagnie']:idCompagnie,
      map['nomCompagnie']:nomCompagnie,
      map['logoCompagnie']:logoCompagnie,
      map['pourcentage']:pourcentage,

    };

}
}

