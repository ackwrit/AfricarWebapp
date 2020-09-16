import 'package:africarwebapp/model/compagnie.dart';
import 'package:flutter/material.dart';

class settingsCompagnie extends StatefulWidget{
  compagnie factory;
  settingsCompagnie(@required this.factory);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return settingsCompagnieState();
  }

}

class settingsCompagnieState extends State<settingsCompagnie>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('compgnaie modfication');
  }

}