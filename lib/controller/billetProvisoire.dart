import 'package:africarwebapp/controller/validation_billet.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/billet.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class billetProvisoire extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeProvisoire();
  }

}

class homeProvisoire extends State<billetProvisoire>{

  DateFormat formatjour = DateFormat.yMMMMd('fr_FR');
  DateFormat formatheure = DateFormat.Hm('fr_FR');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }



  Widget bodyPage(){
    return StreamBuilder(
      stream: firestoreHelper().fire_billet.snapshots(),
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
                      title: Text('Les billets'),
                      centerTitle: true,



                    ),

                  )

                ];
              },

              body: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext ctx,int index){
                    billet entreprise=billet(documents[index]);

                    if(entreprise.validate==false){
                      return InkWell(
                        child: Card(
                          elevation: 10,
                          child: ListTile(
                            title: Text("${entreprise.lieuDepart} - ${entreprise.lieuArrivee} "),
                            trailing: Text('Date : ${formatjour.format(entreprise.depart)} - ${formatheure.format(entreprise.depart)}'),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context){
                                return billetValidation(billets: entreprise,);
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
    );
  }

}