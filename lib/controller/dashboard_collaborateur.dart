import 'package:africarwebapp/controller/create_billet.dart';
import 'package:africarwebapp/controller/listing_trajet.dart';
import 'package:africarwebapp/controller/registerProController.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:flutter/material.dart';

class dashBoardCollaborateur extends StatefulWidget{
  String gare;
  dashBoardCollaborateur({String gare}){
    this.gare=gare;

  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _dashBoardState();
  }

}

class _dashBoardState extends State<dashBoardCollaborateur> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: imagebar,
            backgroundColor: Colors.black,
            centerTitle: true,
            bottom: TabBar
              (
                indicatorColor: Colors.orange,

                tabs: [
                  Tab(icon: new Icon(Icons.format_list_bulleted), child: new Text("Trajet"),),
                 // Tab(icon: new Icon(Icons.bookmark),
                   // child: new Text("Création billet"),),
                ]
            ),

          ),
          body: TabBarView(
              children: controllers()
          ),
        )
    );
  }


  List <Widget> controllers() {
    return [
      listingTrajet(widget.gare),
     // createBillet(),



    ];
  }
}