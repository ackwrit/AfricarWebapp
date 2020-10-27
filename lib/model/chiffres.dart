
import 'package:cloud_firestore/cloud_firestore.dart';

class chiffres{
  String id;
  double janvier;
  double fevrier;
  double mars;
  double avril;
  double mai;
  double juin;
  double juillet;
  double aout;
  double septembre;
  double octobre;
  double novembre;
  double decembre;
  String uidChiffre;
  String nomCompagnie;
  double total;






  chiffres(DocumentSnapshot snapshot)
  {
    id=snapshot.documentID;
    Map map = snapshot.data;
    janvier=map['Janvier'];
    fevrier=map['Fevrier'];
    mars=map['Mars'];
    avril=map['Avril'];
    mai=map['Mai'];
    juin=map['Juin'];
    juillet=map['Juillet'];
    aout=map['Aout'];
    septembre=map['Septembre'];
    octobre=map['Octobre'];
    novembre=map['Novembre'];
    decembre=map['Decembre'];
    uidChiffre=map['uidChiffre'];
    nomCompagnie=map['nomCompagnie'];
    total =map['total'];




  }


  Map toMap(){
    Map map;
    return map ={
      map['Janvier']:janvier,
      map['Fevrier']:fevrier,
      map['Mars']:mars,
      map['Avril']:avril,
      map['Mai']:mai,
      map['Juin']:juin,
      map['Juillet']:juillet,
      map['Aout']:aout,
      map['Septembre']:septembre,
      map['Octobre']:octobre,
      map['Novembre']:novembre,
      map['Decembre']:decembre,
      map['uidChiffre']:uidChiffre,
      map['nomCompagnie']:nomCompagnie,
    };

  }
}