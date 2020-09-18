import 'package:africarwebapp/controller/Messagecontroller.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:africarwebapp/view/my_widgets/my_zone_text.dart';
import 'package:flutter/material.dart';

class chatController extends StatefulWidget{
  utilisateur moi;
  utilisateur partenaire;
  chatController(@required this.moi,@required this.partenaire);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return chatControllerState();
  }

}

class chatControllerState extends State<chatController>{
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
      child: InkWell(
       //onTap: ()=>FocusScope.of(context).requestFocus(new FocusNode()),
        child: Column(
          children: [
            //Zone de chat
            new Flexible(child: Container(
              height: 600,
              child: Messagecontroller(widget.moi.uid),
            )),
            //Divider
            new Divider(height: 1.5,),
            //Zone de text
            ZoneText(widget.partenaire,widget.moi),
          ],
        ),
      ),
    );
  }

}