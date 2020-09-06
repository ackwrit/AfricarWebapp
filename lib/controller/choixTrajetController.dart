import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/model/trajet.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class choixTrajetController extends StatefulWidget{
  bool retour;
  String depart;
  String arrivee;
  DateTime heureDepart;
  DateTime HeureArrivee;
  int nombrepassager;

  choixTrajetController({bool retour,String depart,String arrivee,DateTime heureDepart,DateTime heureArrivee,int nombrepassager}){
    this.retour =retour;
    this.depart=depart;
    this.arrivee=arrivee;
    this.heureDepart=heureDepart;
    this.HeureArrivee=heureArrivee;
    this.nombrepassager=nombrepassager;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeTrajet();
  }

}

class homeTrajet extends State<choixTrajetController>{
  compagnie partenaire;
  String offrepartenaire,logoCompagnie;
  String nameCompagnie;
  bool sortie=false;
  int compteur=0;


  DateFormat formatjour = DateFormat.yMMMMd('fr_FR');
  DateFormat formatheure = DateFormat.Hm('fr_FR');
  var formatchiffre = new NumberFormat("#,###", "fr_FR");
  String heuredepart;
  String heurearrivee;






  @override
  Widget build(BuildContext context) {
    bool retour=widget.retour;


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png",height: 225,),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.orangeAccent,
      body: bodyPage(),
    );
  }


  Widget bodyPage(){

    return StreamBuilder<QuerySnapshot>
      (
        stream:firestoreHelper().fire_trajet.snapshots(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot){
          if (!snapshot.hasData){
            return LoadingCenter();
          }
          else
          {
            List<DocumentSnapshot>documents =snapshot.data.documents;
            return NestedScrollView(
                headerSliverBuilder: (BuildContext build,bool srolled){
                  return [
                    SliverAppBar(
                      leading: Container(),
                      pinned: true,
                      backgroundColor: Colors.orangeAccent,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text('Les trajets'),
                        centerTitle: true,



                      ),

                    )

                  ];
                },

                body: Container(),
            );
          }




        });






  }










}