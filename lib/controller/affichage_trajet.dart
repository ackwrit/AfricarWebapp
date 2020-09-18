import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/model/trajet.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class trajetPrint extends StatefulWidget{
  compagnie factory;
  trajetPrint(@required this.factory);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return trajetPrintState();
  }

}

class trajetPrintState extends State<trajetPrint>{
  DateFormat formatheure = DateFormat.Hm('fr_FR');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: imagebar,
        backgroundColor: backgroundbar,
      ),
      backgroundColor: background,
      body: StreamBuilder(
          stream: firestoreHelper().fire_trajet.orderBy('heureDepart',descending: false).snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
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


                      ),


                    ];
                  },

                  body: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (BuildContext ctx,int index){
                        trajet trajets=trajet(documents[index]);
                        if(trajets.idCompagnie==widget.factory.id)
                        {
                          return  InkWell(
                            child:Card(
                              elevation: 10,
                              child: ListTile(
                                leading: (trajets.logoCompagnie==null)?Image.asset("assets/indisponible.png"):Image.network(trajets.logoCompagnie),
                                trailing: Text("Prix : ${trajets.prix} CFA"),
                                title: Text("${trajets.depart} - ${trajets.destination} ${formatheure.format(trajets.heureDepart)}"),

                                // trailing: Text('Date : ${formatjour.format(entreprise.depart)} - ${formatheure.format(entreprise.depart)}'),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context)
                                  {
                                    return null;
                                  }
                              ));

                            },

                          );
                        }
                        else
                        {
                          return Container();
                        }













                      }
                  ));
            }
          }
      )

    );

  }

}