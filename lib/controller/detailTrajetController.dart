import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/billet.dart';
import 'package:africarwebapp/model/trajet.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class detailTrajetController extends StatelessWidget{
  trajet trajets;


  detailTrajetController(this.trajets);


  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR');
    DateFormat formatjour = DateFormat.yMMMMd('fr_FR');
    DateFormat formatheure = DateFormat.Hm('fr_FR');

    // TODO: implement build
    return StreamBuilder<QuerySnapshot>
      (
        stream:firestoreHelper().fire_billet.snapshots(),
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
                        title: Text('Liste des voyageurs'),
                        centerTitle: true,



                      ),

                    )

                  ];
                },

                body: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext ctx,int index){
                      billet entreprise = billet(documents[index]);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                        ],
                      );



                    }
                ));
          }
        });
  }

}