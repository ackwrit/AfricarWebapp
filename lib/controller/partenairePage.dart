import 'package:africarwebapp/controller/affichage_contact.dart';
import 'package:africarwebapp/controller/financePartener.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:africarwebapp/view/my_material.dart';

class partenairePage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _partenaireState();
  }

}

class _partenaireState extends State<partenairePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundbar,
          bottom: TabBar(

              indicatorColor: background,
              tabs: [



                Tab(icon: Icon(Icons.account_circle),child: Text('Contacts'),),

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
      contact(),
      financePartenaire(),
    ];
  }

}