import 'dart:async';
import 'package:africarwebapp/controller/adminPage.dart';
import 'package:africarwebapp/controller/collaborateurPage.dart';
import 'package:africarwebapp/controller/directorPage.dart';
import 'package:africarwebapp/controller/managerPage.dart';
import 'package:africarwebapp/controller/partenairePage.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:africarwebapp/pages/commercialPage.dart';
import 'package:africarwebapp/pages/helpdeskPage.dart';
import 'package:flutter/material.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:intl/date_symbol_data_local.dart';


class MainAppController extends StatefulWidget{
  String identifiant;
  MainAppController(this.identifiant);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainState();
  }

}

class _MainState extends State<MainAppController>{
  StreamSubscription streamListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting('fr_FR');
    //crétation de la souscription au stream
    streamListener = firestoreHelper().fire_user.document(widget.identifiant).snapshots().listen((event) {
      setState(() {

        globalUser =utilisateur(event);
      });

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //arrete le stream
    streamListener.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR','');
    // TODO: implement build
    return (globalUser==null)?LoadingScaffold():Scaffold(
      appBar: AppBar(
        title: imagebar,
        backgroundColor: backgroundbar,
      ),
      backgroundColor: background,
      body: bodyPage(),
    );
  }



  Widget bodyPage(){
    return Center(
      child: showPage(globalUser.type_utilisateur)
    );
  }


  showPage(String type)
  {
    switch(type){
      case "collaborateur": return collaborateurPage();
      case "partenaire":return partenairePage();
      case "helpdesk": return helpdeskPage();
      case "manager": return managerPage();
      case "commercial":return commercialPage();
      case "directeur": return directorPage();
      case "admin": return adminPage();
      default:return collaborateurPage();

    }

  }

}