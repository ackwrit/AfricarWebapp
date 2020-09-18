import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class registerPartner extends StatefulWidget{
  String nomCompagnie;
  registerPartner(@required String this.nomCompagnie);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return registerPartnerState();
  }

}

class registerPartnerState extends State<registerPartner>{
  String mail,prenom,nom;
  String uid=randomAlphaNumeric(20);
  String password=randomAlphaNumeric(8);
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


  Widget bodyPage(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            onChanged: (value){
              setState(() {
                mail=value;
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
            onChanged: (value){
              setState(() {
                prenom=value;
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
            onChanged: (value){
              setState(() {
                nom=value;
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('Enregister',style: TextStyle(color: background),),
              onPressed: validationPartenaire),


        ],
      ),
    );
  }


  validationPartenaire()
  {
    //enregsitrement utilisatteur dans la base de donnée
    firestoreHelper().record(mail, password,
        typeUser: 'partenaire',
      nom: nom,
      prenom: prenom,
      compagnie: widget.nomCompagnie,
      referent: globalUser.uid

    );
    //envoyer dans la boite mail.
    



  }

}