import 'package:flutter/material.dart';
import 'package:africarwebapp/view/my_material.dart';

class LoadingScaffold extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: imagebar,
        backgroundColor: backgroundbar,
      ),
      backgroundColor: background,
      body:LoadingCenter()

    );
  }




}