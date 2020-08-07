import 'package:africarwebapp/controller/administrationController.dart';
import 'package:africarwebapp/controller/main_app_controller.dart';
import 'package:africarwebapp/controller/registerProController.dart';
import 'package:africarwebapp/fonction/firebaseHelper.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Africar Professionnel',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller andcd
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mail,password,identifiant;
  utilisateur personne;


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //zsh
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Image.asset("assets/logo.png",height: 225,),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.orange,
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                hintText: "Entrer votre adresse mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )

              ),
            ),
            Padding(padding: EdgeInsets.all(5),),
            TextField(
              obscureText: true,
              onChanged: (value){
                setState(() {
                  password=value;
                });
              },

              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Entrer votre mot de passe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )

              ),
            ),

            FlatButton(
                onPressed: (){
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: mail, password: password).then((value){
                    identifiant=value.user.uid;

                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return MainAppController(identifiant);
                      }
                  ));


                  }).catchError((onError){
                    print(onError);

                  });

                },
                child: Text('Connexion')
            ),

              ],
        ),

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
