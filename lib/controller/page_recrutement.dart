import 'package:africarwebapp/controller/adminPage.dart';
import 'package:africarwebapp/controller/directorPage.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/view/my_material.dart';
import'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class recrutement extends StatefulWidget{
  String fonction;
  recrutement(@required this.fonction);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return recrutementState();
  }

}

class recrutementState extends State<recrutement> {
  String mail, prenom, nom;
  String uid = randomAlphaNumeric(20);
  String password = 'Africars';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: imagebar,
        backgroundColor: backgroundbar,
      ),
      backgroundColor: background,
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                mail = value;
              });
            },

            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "adresse mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )

            ),
          ),
          SizedBox(height: 10,),
          TextField(
            onChanged: (value) {
              setState(() {
                prenom = value;
              });
            },

            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "prénom",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )

            ),
          ),
          SizedBox(height: 10,),
          TextField(
            onChanged: (value) {
              setState(() {
                nom = value;
              });
            },

            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "nom",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )

            ),
          ),
          SizedBox(height: 10,),
          RaisedButton(
              color: backgroundbar,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text('Enregister', style: TextStyle(color: background),),
              onPressed: validationRecrutement),


        ],
      ),
    );
  }


  validationRecrutement() {
    //enregsitrement utilisatteur dans la base de donnée
    firestoreHelper().record(mail, password,
        typeUser: widget.fonction,
        nom: nom,
        prenom: prenom,
        compagnie: 'africar',
        referent: 'africar'

    );


    //envoyer dans la boite mail.

    if(globalUser.typeUtilisateur!='directeur'){
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context)
              {
                return adminPage();
              }
      ));
    }
    else
      {
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context)
            {
              return directorPage();
            }
        ));

      }


  }
}