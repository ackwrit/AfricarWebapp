import 'package:africarwebapp/controller/detailTrajetController.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';

import 'package:africarwebapp/model/trajet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class listingTrajet extends StatelessWidget{
  String gare;

  listingTrajet(String gare)
  {
    this.gare=gare;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR');
    DateFormat formatjour = DateFormat.yMMMMd('fr_FR');
    DateFormat formatheure = DateFormat.Hm('fr_FR');
    var formatchiffre = new NumberFormat("#,###", "fr_FR");

    // TODO: implement build
    return StreamBuilder<QuerySnapshot>
      (
        stream:firestoreHelper().fire_trajet.orderBy('heureDepart').snapshots(),
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

                  body: ListView.builder(
                    itemCount: documents.length,
                      itemBuilder: (BuildContext ctx,int index){
                      trajet entreprise = trajet(documents[index]);
                      return InkWell(
                        onTap: (){
                          //print('direction page détail voyageur');
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context)
                                  {
                                    return detailTrajetController(entreprise);
                                  }
                          ));
                        },
                        child:((entreprise.depart.toLowerCase()==gare.toLowerCase()))?
                        Card(
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  (entreprise.logoCompagnie==null)?Image.asset("assets/indisponible.png",width: 100,):Image.network(entreprise.logoCompagnie,width: 100,),
                                  (entreprise.nomCompagnie==null)?Container():Text(entreprise.nomCompagnie),
                                  Text("${entreprise.depart} - ${entreprise.destination}"),

                                ],
                              ),

                             trailing: Text("Départ : ${formatheure.format(entreprise.heureDepart)}"),
                            )

                        ) :Container()

                      );



                      }
                  ));
            }
        });
  }

}