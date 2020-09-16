import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/pages/detail_compagnie.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class listCompagnie extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return listCompagnieState();
  }

}

class listCompagnieState extends State<listCompagnie>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: firestoreHelper().fire_compagnie.snapshots(),
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
                        title: Text('Les Compagnies'),
                        centerTitle: true,




                      ),


                    ),


                  ];
                },

                body: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext ctx,int index){
                      compagnie entreprise=compagnie(documents[index]);


                        return  InkWell(
                          child:Card(
                            elevation: 10,
                            child: ListTile(
                              leading: (entreprise.logo==null)?Image.asset("assets/indisponible.png"):Image.network(entreprise.logo),
                              trailing: Text("${entreprise.prenomDirigeant} ${entreprise.nomDirigeant}"),
                              title: (entreprise.nomCompagnie==null)?Text(''):Text(entreprise.nomCompagnie),

                              // trailing: Text('Date : ${formatjour.format(entreprise.depart)} - ${formatheure.format(entreprise.depart)}'),
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context)
                                    {
                                      return settingsCompagnie(entreprise);
                                    }
                            ));

                          },

                        );







                    }
                ));
          }
        }
    );
  }

}