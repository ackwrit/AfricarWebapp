import 'package:africarwebapp/controller/billetProvisoire.dart';
import 'package:africarwebapp/controller/creationBillet.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:flutter/material.dart';

class helpdeskPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeHelpdesk();
  }

}

class homeHelpdesk extends State<helpdeskPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Helpdesk'),
            backgroundColor: backgroundbar,
            bottom: TabBar(
              indicatorColor: background,
                tabs: [
                  Tab(icon: Icon(Icons.list),child: Text('Billets'),),
                  Tab(icon: Icon(Icons.assignment),child: Text('création Billets'),)
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
      billetProvisoire(),
      creationBillet()
    ];
  }





}