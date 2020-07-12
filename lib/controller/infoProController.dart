import 'package:africarwebapp/fonction/firebaseHelper.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class infoProController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeInfoPro();
  }
}

class homeInfoPro extends State<infoProController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }





  Widget bodyPage(){
    return FirebaseAnimatedList(
        query: firebaseHelper().base_user,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index)
        {
          utilisateur user =utilisateur(snapshot);
          return ListTile(
            title: Text(user.id),
          );
        }
    );
  }

}