import 'package:africarwebapp/model/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:africarwebapp/view/my_material.dart';
class directorPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _directorState();
  }

}

class _directorState extends State<directorPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: background,
      body: Text(globalUser.nom),
    );
  }

}