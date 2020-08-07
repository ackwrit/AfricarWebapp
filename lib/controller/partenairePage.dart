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
    return Scaffold(
      backgroundColor: background,
      body: Text(globalUser.nom),
    );
  }

}