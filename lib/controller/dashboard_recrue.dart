import 'package:africarwebapp/controller/page_recrutement.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:flutter/material.dart';

class dashboardPersonnel extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashboardPersonnelState();
  }

}

class dashboardPersonnelState extends State<dashboardPersonnel>{
  List<String> dashboard=['directeur','commercial','helpdesk','collaborateur'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: background,
      body: bodyPage(),
    );
  }


  Widget bodyPage(){
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4),
      children: List.generate(dashboard.length, (index){
        return InkWell(
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Center(

              child: Text(dashboard[index]),
            ),

          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return recrutement(dashboard[index]);
                }
            ));
          },
        );

      }),
    );
  }

}