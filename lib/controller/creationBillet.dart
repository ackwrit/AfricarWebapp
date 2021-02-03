import 'dart:async';

import 'package:africarwebapp/controller/listingCreationTrajet.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:africarwebapp/view/my_widgets/my_snack_date.dart';
import 'package:africarwebapp/view/my_widgets/my_snack_time.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class creationBillet extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreationState();
  }

}

class CreationState extends State<creationBillet>{
  bool trajetinternational=false;
  DateFormat formatheure = DateFormat.Hm('fr_FR');
  DateFormat formatjour = DateFormat.yMMMMd('fr_FR');
  String destinationSelectionDepart='Choisir votre départ';
  String destinationSelectionArrivee='Choisir votre arrivée';
  GlobalKey <ScaffoldState> globalkeyTrajet = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();

  }


  Widget bodyPage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SliderInternational(),
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
            items: (trajetinternational)?gares:garesInternational,
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
            items: (trajetinternational)?gares:garesInternational,
            showClearButton: false,
            onChanged: (text){
              setState(() {
                destinationSelectionArrivee=text;
              });
            },

            selectedItem: destinationSelectionArrivee,
          ),
        ),
        (globalDateDepart==null)?Text('Jour de départ : ${formatjour.format(DateTime.now())}'):Text('Jour de départ : ${formatjour.format(globalDateDepart)} '),

        RaisedButton.icon(icon: Icon(Icons.watch_later,color: background,),
          color: backgroundbar,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: affichageSnack,
          label:Text("Indiquer le jour",style: TextStyle(color: background),),

        ),



        RaisedButton(
            color: backgroundbar,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('Enregister',style: TextStyle(color: background),),
            onPressed: TrajetCreation),



      ],
    );
  }




  Widget SliderInternational()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Trajet International'),
        Switch(
          value: trajetinternational,
            onChanged: (bool b){
              setState(() {
                trajetinternational=b;
              });


            },

        ),
        Text('Trajet national')
      ],
    );
  }


  affichageSnack()
  {
    int count=0;
    int affichage;
    //globalkeyTrajet.currentState.showBottomSheet((builder) => MysnackbarTime(timerheure: heureTimer,));
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context){
          return MysnackbarDate();
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


  TrajetCreation(){
    return Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext ctx){
        return listingCreationTrajet(depart: destinationSelectionDepart,destination: destinationSelectionArrivee,);
      }
    ));
  }


}





