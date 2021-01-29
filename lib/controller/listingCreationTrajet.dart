import 'package:africarwebapp/controller/listing_trajet.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/billet.dart';
import 'package:africarwebapp/model/trajet.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class listingCreationTrajet extends StatefulWidget{
  String depart;
  String destination;

  listingCreationTrajet({String this.depart,String this.destination});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return listingTrajetState();
  }

}

class listingTrajetState extends State<listingCreationTrajet>{
  DateFormat formatjour = DateFormat.yMMMMd('fr_FR');
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
      body: bodyPage(),
    );
  }



  Widget bodyPage(){
    return StreamBuilder(
      stream: firestoreHelper().fire_trajet.where("depart",isEqualTo: widget.depart).where("destination",isEqualTo: widget.destination).snapshots(),
      builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot>snapshot){
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
                      trajet entreprise=trajet(documents[index]);

                        return InkWell(
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              leading: Text('Compagnie : ${entreprise.nomCompagnie}'),
                              title: Text("${entreprise.depart} - ${entreprise.destination} "),
                              trailing: Text('Heure : ${formatheure.format(entreprise.heureDepart)}'),
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context){
                                  //return billetValidation(billets: entreprise,);
                                  return null;
                                }
                            ));
                          },
                        );





                    }
                ));

          }
      },
    );
  }

}