import 'package:africarwebapp/controller/affichage_compagnie.dart';
import 'package:africarwebapp/controller/ajouter_partenaire.dart';
import 'package:africarwebapp/controller/contact_partenaire.dart';
import 'package:africarwebapp/controller/registerProController.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:flutter/material.dart';

class commercialPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return commercialState();
  }

}

class commercialState extends State<commercialPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home),
          centerTitle: true,
          title: Text('Commercial'),
          backgroundColor: backgroundbar,
          bottom: TabBar(
              indicatorColor: background,
              tabs: [

                Tab(icon: Icon(Icons.account_circle),child: Text('Compagnie'),),

                Tab(icon: Icon(Icons.account_circle),child: Text('Contacts'),),
                Tab(icon: Icon(Icons.list),child: Text('Promotion'),),

                Tab(icon: Icon(Icons.new_releases),child: Text('Création promotion'),),
                Tab(icon: Icon(Icons.departure_board),child: Text('Ajout Compagnie'),),
                Tab(icon: Icon(Icons.person_add),child: Text('Ajout Partenaire'),),
              ]
          ),
        ),
        backgroundColor: background,
        body: TabBarView(children: controllers()
        ),
      ),
    );
  }



  List<Widget> controllers(){
    return [
      listCompagnie(),
      contactPartner(),
      Text('Liste promotion'),

      Text('création des promotions'),
      registerProController(),
      addPartner(),
    ];
  }

}