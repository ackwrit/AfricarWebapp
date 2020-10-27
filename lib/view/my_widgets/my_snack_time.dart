import 'package:africarwebapp/view/my_material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';


class MysnackbarTime extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SnackbarStateTime();
  }

}

class SnackbarStateTime extends State<MysnackbarTime>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: imagebar,
        backgroundColor: backgroundbar,
      ),
      backgroundColor: background,
      body: Container(
          height: MediaQuery.of(context).size.height/2.3,
          color: background,
          child:Container(

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                TimePickerSpinner(
                  isForce2Digits: true,
                  minutesInterval: 15,
                  highlightedTextStyle: TextStyle(color: background,fontSize: 20),
                  normalTextStyle: TextStyle(color: Colors.black,fontSize: 10),
                  onTimeChange: (time)
                  {

                    setState(() {
                      DateTime debut=DateTime(2020,1,1,time.hour,time.minute);
                      globalTimeDepart=debut;

                    });
                  },

                ),
                RaisedButton(
                  onPressed: (){
                    print('valeur snack');

                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: backgroundbar,
                  child: Text("Valider",style: TextStyle(color: background),),
                )

              ],
            ),
          )
      )

    );

  }

}