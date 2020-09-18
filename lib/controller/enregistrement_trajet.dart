import 'dart:async';

import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/compagnie.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:africarwebapp/view/my_snack.dart';
import 'package:africarwebapp/view/my_widgets/my_snack_time.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class registerTrajet extends StatefulWidget{
  compagnie factory;
  registerTrajet(@required compagnie this.factory);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return registerTrajetState();
  }

}

class registerTrajetState extends State<registerTrajet>{
  String destinationSelectionDepart='Choisir votre départ';
  String destinationSelectionArrivee='Choisir votre arrivée';
  int prix;
  GlobalKey <ScaffoldState> globalkeyTrajet = GlobalKey<ScaffoldState>();

  bool national=true;
  DateFormat formatheure = DateFormat.Hm('fr_FR');
  String uid =randomAlphaNumeric(20);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        key: globalkeyTrajet,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Trajet International"),
              Switch.adaptive(
                  value: national,
                  onChanged: (value){
                    setState(() {
                      national=value;
                    });
                  }),
              Text("Trajet National")
            ],
          ),
          Container(
            height: 65,
            child: DropdownSearch<String>(

              validator: (v) => v == null ? "required field" : null,
              hint: "Choisir la gare de départ",
              searchBoxDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Indiquer votre ville de départ',
                  alignLabelWithHint: true,

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
              ),
              showSearchBox: true,
              dropdownSearchDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))

              ),
              mode: Mode.DIALOG,
              showSelectedItem: true,
              items: (national)?gares:garesInternational,
              showClearButton: false,
              onChanged: (text){
                setState(() {
                  destinationSelectionDepart=text;
                });
              },

              selectedItem: destinationSelectionDepart,
            ),
          ),
          Container(
            height: 65,
            child: DropdownSearch<String>(

              validator: (v) => v == null ? "required field" : null,
              hint: "Choisir la gare de destination",
              searchBoxDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Indiquer votre ville de destination',
                  alignLabelWithHint: true,

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
              ),
              showSearchBox: true,
              dropdownSearchDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))

              ),
              mode: Mode.DIALOG,
              showSelectedItem: true,
              items: (national)?gares:garesInternational,
              showClearButton: false,
              onChanged: (text){
                setState(() {
                  destinationSelectionArrivee=text;
                });
              },

              selectedItem: destinationSelectionArrivee,
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: 'Prix',

            ),
            onChanged: (nombre){
              setState(() {
                prix = int.parse(nombre);
              });
            },
          ),

          (globalTimeDepart==null)?Text('Heure de départ : ${formatheure.format(DateTime.now())}'):Text('Heure de départ : ${formatheure.format(globalTimeDepart)} '),

          RaisedButton.icon(icon: Icon(Icons.watch_later,color: background,),
              color: backgroundbar,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: affichageSnack,
            label:Text("Indiquer l'heure",style: TextStyle(color: background),),

          ),

          RaisedButton(
              color: backgroundbar,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text('Enregister',style: TextStyle(color: background),),
              onPressed: validationTrajet),


        ],
      ),
    );
  }


  validationTrajet()
  {
    //enregsitrement Trajet dans la base de donnée
    Map <String,dynamic>map={
      'depart':destinationSelectionDepart,
      'destination':destinationSelectionArrivee,
      'heureDepart':globalTimeDepart,
      'prix':prix,
      'idCompagnie':widget.factory.id,
      'logoCompagnie':widget.factory.logo,

    };
    firestoreHelper().addTrajet(map, uid);










  }


  affichageSnack()
  {
    int count=0;
    int affichage;
    //globalkeyTrajet.currentState.showBottomSheet((builder) => MysnackbarTime(timerheure: heureTimer,));
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context){
          return MysnackbarTime();
        }
    ));
    Timer.periodic(Duration(seconds:2), (timer){
      if(count<10)
        {
          count++;
          print(count);
          setState(() {
            affichage=count;
          });

        }
      else
        {
          timer.cancel();
        }



    });



  }




}