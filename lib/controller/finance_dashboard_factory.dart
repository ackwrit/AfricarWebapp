import 'package:africarwebapp/controller/affichage_trajet.dart';
import 'package:africarwebapp/controller/financeCompagnieController.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class dashboardfinacial extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashboardfinacialState();
  }

}

class dashboardfinacialState extends State<dashboardfinacial>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: firestoreHelper().fire_compagnie.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
          if (!snapshot.hasData) {
            return LoadingCenter();
          }
          else {
            List<DocumentSnapshot>documents = snapshot.data.documents;
            return GridView.builder(
                itemCount: documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6),
                itemBuilder: (BuildContext ctx, int index) {
                  compagnie factory = compagnie(documents[index]);


                  return InkWell(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          (factory.logo == null) ? Image.asset(
                            'assets/indisponible.png', height: 125,) : Image
                              .network(factory.logo, height: 125,),
                          Text(factory.nomCompagnie),

                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context){
                            return financeCompagnieController(factory: factory,actuel: DateTime.now(),);
                          }
                      ));
                    },

                  );

                }
            );
          }
        }
    );
  }

}