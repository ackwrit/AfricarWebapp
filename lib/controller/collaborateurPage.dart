import 'package:africarwebapp/controller/dashboard_collaborateur.dart';
import 'package:africarwebapp/fonction/search_list.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:search_widget/search_widget.dart';
class collaborateurPage extends StatefulWidget{

  collaborateurPage();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _collaborateurState();
  }

}

class _collaborateurState extends State<collaborateurPage>{
  SearchList listeGare=SearchList();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: background,
      body:bodyPage()
    );
  }


  Widget bodyPage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.only(left:100,right: 100),
          child: TextField(
            decoration:InputDecoration(
                hintText: 'indiquer votre gare',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(

                )
            ),
            onChanged: (text){
              listeGare.copier(gares);
              setState(() {
                listeGare.chercher(text);
              });








              //mettre à zéro la liste;
              listeGare.destroy();
            },

          ),
        ),
        
        (listeGare.motTrouver=='')?Text('Gare',style:TextStyle(fontSize: 40)):Text("Gare de ${listeGare.motTrouver}",style: TextStyle(fontSize: 40),),
        RaisedButton(
            onPressed:(listeGare.motTrouver=='')?null:(){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context)
                      {
                        return dashBoardCollaborateur(gare: listeGare.motTrouver);
                      }
              ));

            },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text('Valider'),
        ),



      ],
    );
  }

}