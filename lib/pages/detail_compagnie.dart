
import 'dart:io';


import 'package:africarwebapp/controller/adminPage.dart';
import 'package:africarwebapp/controller/directorPage.dart';
import 'package:africarwebapp/fonction/firebaseHelper.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:africarwebapp/pages/commercialPage.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:file_picker/file_picker.dart';
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

class settingsCompagnieState extends State<settingsCompagnie> {

  utilisateur profil;
  File image;
  String urlimage;
  String uid;
  String nom;
  String prenom;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/newlogo.jpg", height: 225,),
        leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white, size: 40,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return (globalUser.typeUtilisateur!='commercial')?directorPage():commercialPage();
                  }
              ));
            }),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.orangeAccent,
      body: bodyPage(),

    );
  }


  Widget bodyPage() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             /* Padding(padding: EdgeInsets.all(5),),
             (widget.factory.logo==null)?Image.asset("assets/indisponible.png",height: 250,):Image.network(widget.factory.logo,width: 250,height: 250,

             ),

              RaisedButton(
                shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20)),
                color: Colors.black,
                onPressed: imagePicker,
                child: Text(
                  "Modifier l'image", style: TextStyle(color: Colors.orange),),
              ),
              Padding(padding: EdgeInsets.all(5),),*/


              (globalUser.typeUtilisateur!='commercial')?TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Nom du dirigeant',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (text){
                setState(() {
                  nom=text;
                });
              },
            ):Text(widget.factory.nomDirigeant),


              Padding(padding: EdgeInsets.all(5),),


              (globalUser.typeUtilisateur!='commercial')?TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Prénom du dirigeant',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (text){
                  setState(() {
                    prenom=text;
                  });
                },
              ):Text(widget.factory.prenomDirigeant),

              //Text(widget.factory.nomDirigeant),

              Padding(padding: EdgeInsets.all(5),),
              //Text(widget.factory.prenomDirigeant),
              Padding(padding: EdgeInsets.all(5),),
              (globalUser.typeUtilisateur!='commercial')?RaisedButton(
                child: Text(
                  'Enregsitrer', style: TextStyle(color: Colors.orange),),
                onPressed: () {
                  Map <String, dynamic> map = {
                    'id':widget.factory.id,
                    'matricule':widget.factory.matricule,
                    'nomCompagnie':widget.factory.nomCompagnie,
                    'logo':urlimage,
                    'adresse':widget.factory.adresse,
                    'mail':widget.factory.mail,
                    'nomDirigeant':nom,
                    'prenomDirigeant':prenom,
                    'offre':widget.factory.offre

                  };
                  firestoreHelper().addCompagnie(map, widget.factory.id);
                  if(globalUser.typeUtilisateur=='admin')
                    {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return adminPage();
                          }
                      ));
                    }
                  if(globalUser.typeUtilisateur=='directeur')
                    {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return directorPage();
                          }
                      ));
                    }
                  if(globalUser.typeUtilisateur=='commercial')
                    {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return commercialPage();
                          }
                      ));
                    }


                },
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ):Container(),
              RaisedButton(
                onPressed: () {
                  if(globalUser.typeUtilisateur=='admin')
                    {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return adminPage();
                          }
                      ));
                    }
                  if(globalUser.typeUtilisateur=='directeur')
                    {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return directorPage();
                          }
                      ));
                    }
                  if(globalUser.typeUtilisateur=='commercial')
                  {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return commercialPage();
                        }
                    ));
                  }

                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Retour', style: TextStyle(color: Colors.orange),),
                color: Colors.black,
              )

              //Portemonnaie virtuel


            ],
          ),
        ),

      ),

    );
  }


  imagePicker() async {
    image = await FilePicker.getFile(

    );
    setState(() async {
      urlimage = await firestoreHelper().savePicture(
          image, firestoreHelper().storage_logoCompagnie.child(uid));
    });

    setState(() async {
      urlimage = await firestoreHelper().savePicture(
          image, firestoreHelper().storage_logoCompagnie.child(uid));
      globalUser.image = urlimage;
    });
  }
}