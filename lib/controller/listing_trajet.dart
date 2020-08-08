import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/model/trajet.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:africarwebapp/view/my_material.dart';

class listingTrajet extends StatelessWidget{
  String gare;
  listingTrajet(String gare)
  {
    this.gare=gare;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text('Les trajets'),

                        ),
                      )

                    ];
                  },
                  body: ListView.builder(
                    itemCount: documents.length,
                      itemBuilder: (BuildContext ctx,int index){
                      trajet entreprise = trajet(documents[index]);
                      return ListTile(
                        title: (entreprise.depart.toLowerCase()==gare.toLowerCase())?Text("${entreprise.depart} - ${entreprise.destination}"):Container(),
                      );
                      }
                  ));
            }
        });
  }

}