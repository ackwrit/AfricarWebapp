
import 'package:africarwebapp/fonction/conversion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class billet{
  String id;
  bool billetRetour;
  DateTime emission;
  DateTime depart;
  DateTime retour;
  String lieuDepart;
  String lieuArrivee;
  String qrCodeAller;
  String qrCodeRetour;
  int nbPassager;
  String nomPassager;
  String prenomPassager;
  String logoCompagnieAller;
  String logoCompagnieRetour;
  String telephobne;
  bool validate;
  double prixAller;
  double prixRetour;
  String idCompagnieAller;
  String idCompagnieRetour;
  String idVoyageur;
  double pourcentageAller;
  double pourcentageRetour;
  bool onboarding;



  billet(DocumentSnapshot snapshot)
  {
    id=snapshot.documentID;
    Map map = snapshot.data;
    billetRetour = map['billerRetour'];
    //Convertir  les informations en DateTime
    emission = conversion().readTimestamp(map['emission']);
    depart = conversion().readTimestamp(map['jourAller']);
    retour = conversion().readTimestamp(map['jourRetour']);
    lieuDepart = map['lieuDepart'];
    lieuArrivee = map['lieuArrivee'];
    logoCompagnieAller= map['logoCompagnieAller'];
    logoCompagnieRetour= map['logoCompagnieRetour'];
    qrCodeAller = map['qrCodeAller'];
    qrCodeRetour =map['qrCodeRetour'];
    nbPassager = map['nbPassager'];
    nomPassager = map['nomPassager'];
    prenomPassager = map['prenomPassager'];
    telephobne =map ['telephone'];
    validate =map['validate'];
    prixAller=map['prixAller'];
    prixRetour=map['prixRetour'];
    idCompagnieAller=map['idCompagnieAller'];
    idCompagnieRetour=map['idCompagnieRetour'];
    idVoyageur=map['idVoyageur'];
    pourcentageAller=map['pourcentageAller'];
    pourcentageRetour=map['pourcentageRetour'];
    onboarding=map['onboarding'];

  }


  Map toMap(){
    Map map;
    return map ={
      map['emission']:emission,
      map['depart']:depart,
      map['retour']:retour,
      map['lieuDepart']:lieuDepart,
      map['lieuArrivee']:lieuArrivee,
      map['qrCodeAller']:qrCodeAller,
      map['qrCodeRetour']:qrCodeRetour,
      map['nbPassager']:nbPassager,
      map['nomPassager']:nomPassager,
      map['prenomPassager']:prenomPassager,
      map['logoCompagnieAller']:logoCompagnieAller,
      map['logoCompagnieRetour']:logoCompagnieRetour,
      map['telephone']:telephobne,
      map['validate']:validate,
      map['prixAller']:prixAller,
      map['prixRetour']:prixRetour,
      map['idCompagnieAller']:idCompagnieAller,
      map['idCompagnieRetour']:idCompagnieRetour,
      map['idVoyageur']:idVoyageur,
      map['idBillet']:id,
      map['pourcentageAller']:pourcentageAller,
      map['pourcentageRetour']:pourcentageRetour,
      map['onboarding']:onboarding,

    };
  }



  billet.fromMap(Map<String,dynamic> map)
      ://assert(map['idBillet']!=null),
        //assert(map['idCompagnieRetour']!=null),
        //assert(map['prixAller'!=null]),
        //assert(map['prixRetour']!=null),
        //assert(map['validate']!=null),
        //assert(map['emission']!=null),
        //emission = conversion().readTimestamp(map['emission']),
        //validate =map['validate'],
        id=map['idBillet'],
        idCompagnieAller=map['idCompagnieAller'],
        lieuDepart = map['lieuDepart'],
        emission = conversion().readTimestamp(map['emission']),




        //idCompagnieRetour=map['idCompagnieRetour'],
        prixAller=map['prixAller'];
        //prixRetour=map['prixRetour'];




  @override
  String toString() => "Record<$id:$prixAller>";




}