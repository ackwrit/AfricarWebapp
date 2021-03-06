import 'package:africarwebapp/controller/administrationController.dart';
import 'package:africarwebapp/controller/directorPage.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:flutter/material.dart';

class registerProController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeRegisterPro();
  }

}

class homeRegisterPro extends State<registerProController>{
  String matricule,adresse,mail,nomDirigeant,prenomDirigeant,ofrre,nomCompagnie;
  String password='Africars';
  double pourcentage;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Colors.orange,
      body: bodyPage(),

    );
  }



  Widget bodyPage(){
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Numéro de NIF
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Numéro NIF',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  matricule=value;
                });
              },

            ),
            Padding(padding: EdgeInsets.all(5),),
            //nom de la compagnie
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Nom de la compagnie',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  nomCompagnie=value;
                });
              },

            ),
            Padding(padding: EdgeInsets.all(5),),
            //Adresse locaux
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Entrer l'adresse du siège social",
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  adresse=value;
                });
              },

            ),
            Padding(padding: EdgeInsets.all(5),),
            //adresse mail
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Mail',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  mail=value;
                });
              },

            ),
            /*Padding(padding: EdgeInsets.all(5),),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'password',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  password=value;
                });
              },

            ),*/
            Padding(padding: EdgeInsets.all(5),),
            //nom dirigeant
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Nom du dirigeant',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  nomDirigeant=value;
                });
              },

            ),
            Padding(padding: EdgeInsets.all(5),),
            //Prénom du dirigeant
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Prénom du dirigeant',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  prenomDirigeant=value;
                });
              },

            ),
            Padding(padding: EdgeInsets.all(5),),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Montant du pourcenatge',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  String valeurString=value;

                  pourcentage =double.parse(valeurString);
                });
              },

            ),


            Padding(padding: EdgeInsets.all(10),),

            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.black,
              elevation: 5,
              onPressed: (){
                firestoreHelper().CreateCompagnie(NIF: matricule, mail: mail, pwd: password,adresse: adresse,nomDirigeant: nomDirigeant,prenomDirigeant: prenomDirigeant,nomCompagnie: nomCompagnie,pourcentage: pourcentage);
                setState(() {
                  mail='';
                  matricule='';
                  password='';
                  adresse='';
                  nomDirigeant='';
                  prenomDirigeant='';
                  pourcentage=0;

                });
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context){
                      return directorPage();
                    }
                ));

                //enregister les informations dans la base de donnée compagnie

              },
              child: Text('Enregistrer',style: TextStyle(color: Colors.orange),),
            ),

          ],

        ),
    );


  }

}