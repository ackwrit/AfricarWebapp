import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/message.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:africarwebapp/view/my_widgets/messageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messagecontroller extends StatefulWidget{
  utilisateur id;
  utilisateur idPartner;
  Messagecontroller(@required utilisateur this.id,@required utilisateur this.idPartner);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessagecontrollerState();
  }

}

class MessagecontrollerState extends State<Messagecontroller> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: firestoreHelper().fire_message.orderBy('envoiMessage',descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot) {
          if (!snapshot.hasData) {
            return LoadingCenter();
          }
          else {
            List<DocumentSnapshot>documents = snapshot.data.documents;

            return ListView.builder(
              itemCount: documents.length,
                itemBuilder: (BuildContext ctx,int index)
                {
                  Message discussion = Message(documents[index]);
                  if((discussion.from==widget.id.uid && discussion.to==widget.idPartner.uid)||(discussion.from==widget.idPartner.uid&&discussion.to==widget.id.uid))
                    {

                      return messageBubble(widget.id.uid, widget.idPartner, discussion);
                    }
                  else
                    {
                      return Container();
                    }

                }
            );


          }
        }
    );
  }
}