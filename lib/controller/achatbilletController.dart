import 'package:africarwebapp/model/trajet.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class achatBillet extends StatefulWidget{
  trajet voyage;
  achatBillet({trajet this.voyage});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return achatBilletState();
  }

}

class achatBilletState extends State<achatBillet>{
  DateFormat formatjour = DateFormat.yMMMMd('fr_FR');
  DateFormat formatheure = DateFormat.Hm('fr_FR');
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
    return WidgetContainer();
  }
  
  
  
  
  
  WidgetCard(){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("${widget.voyage.nomCompagnie}"),
          Text("${widget.voyage.depart}"),
          Text("${widget.voyage.destination}"),
          Text("${widget.voyage.heureDepart}"),
          Text("${widget.voyage.prix}"),
        ],

      ),
    );
  }
  
  
  WidgetContainer(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
        
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("${widget.voyage.nomCompagnie}"),
          Text("${widget.voyage.depart} - ${widget.voyage.destination}"),
          Text("Heure : ${formatjour.format(globalDateDepart)} - ${formatheure.format(widget.voyage.heureDepart)}"),
          Text("Prix : ${widget.voyage.prix} €"),
          RaisedButton(
            color: Colors.black,
            onPressed: (){
              //allez page enregistrement contact
              print("coucou");
              },
            child: Text('Validation',style: TextStyle(color: background),),

          ),
        ],
      ),
    );
  }

}