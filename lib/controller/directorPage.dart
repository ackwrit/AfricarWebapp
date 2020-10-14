import 'package:africarwebapp/controller/affichage_compagnie.dart';
import 'package:africarwebapp/controller/affichage_trajet.dart';
import 'package:africarwebapp/controller/ajouter_partenaire.dart';
import 'package:africarwebapp/controller/ajouter_trajet.dart';
import 'package:africarwebapp/controller/contact_partenaire.dart';
import 'package:africarwebapp/controller/dashboard_recrue.dart';
import 'package:africarwebapp/controller/financeCompagnieController.dart';
import 'package:africarwebapp/controller/finance_dashboard_factory.dart';
import 'package:africarwebapp/controller/liste_trajet.dart';
import 'package:africarwebapp/controller/registerProController.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:flutter/material.dart';

class directorPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return directorState();
  }

}

class directorState extends State<directorPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home),
          centerTitle: true,
          title: Text('Direction'),
          backgroundColor: backgroundbar,
          bottom: TabBar(
              indicatorColor: background,
              tabs: [

                Tab(icon: Icon(Icons.business),child: Text('Compagnie'),),

                Tab(icon: Icon(Icons.account_circle),child: Text('Contacts'),),
                Tab(icon: Icon(Icons.list),child: Text('Nouveaux trajets'),),
                Tab(icon: Icon(Icons.list),child: Text('Liste trajets'),),

                Tab(icon: Icon(Icons.person_add),child: Text('Nouvelle recrue'),),
                Tab(icon: Icon(Icons.departure_board),child: Text('Ajout Compagnie'),),
                Tab(icon: Icon(Icons.show_chart),child: Text('Bilan financier'),),
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
      addTrajet(),
      listTrajet(),


      dashboardPersonnel(),
      registerProController(),
      dashboardfinacial(),
    ];
  }

}