import 'package:africarwebapp/controller/affichage_messagerie.dart';
import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/utilisateur.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class contactPartner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return contactPartnerState();
  }

}

class contactPartnerState extends State<contactPartner>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: firestoreHelper().fire_user.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(!snapshot.hasData){
            return LoadingCenter();

          }
          else
          {
            List<DocumentSnapshot>documents =snapshot.data.documents;
            return NestedScrollView(
                headerSliverBuilder: (BuildContext build,bool srolled){
                  return [
                    SliverAppBar(
                      leading: Container(),
                      pinned: true,
                      backgroundColor: Colors.orangeAccent,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text('Contacts'),
                        centerTitle: true,




                      ),


                    ),


                  ];
                },

                body: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext ctx,int index){
                      utilisateur user=utilisateur(documents[index]);
                      if(globalUser.typeUtilisateur=='directeur' || globalUser.typeUtilisateur=='admin')
                        {
                          if(user.typeUtilisateur=='partenaire'||user.typeUtilisateur=='collaborateur'||user.typeUtilisateur=='commercial'||user.typeUtilisateur=='helpdesk'||user.typeUtilisateur=='directeur'||user.typeUtilisateur=='admin'){
                            if(globalUser.uid==user.uid)
                              {
                                return Container();
                              }
                            else
                              {
                                return  InkWell(
                                  child:Card(
                                    elevation: 10,
                                    child: ListTile(
                                      leading: (user.telephone==null)?Text("Tel non disponible"):Text('Tel: ${user.telephone}'),
                                      trailing: Icon(Icons.chat_bubble),
                                      title: Text('prénom :${user.prenom}  nom: ${user.nom} mail: ${user.mail}'),

                                      // trailing: Text('Date : ${formatjour.format(entreprise.depart)} - ${formatheure.format(entreprise.depart)}'),
                                    ),
                                  ),
                                  onTap: (){
                                   //partenaire discussion
                                    Navigator.push(context,MaterialPageRoute(
                                        builder: (BuildContext context){
                                          return chatController(globalUser,user);
                                        }
                                    ));


                                  },

                                );
                              }


                          }
                          else
                          {
                            return Container();

                          }
                        }
                      else
                        {
                          if((user.typeUtilisateur=='partenaire' && user.referent==globalUser.uid)||(user.typeUtilisateur=='admin')||(user.typeUtilisateur=='directeur')){
                            return  InkWell(
                              child:Card(
                                elevation: 10,
                                child: ListTile(
                                  leading: (user.telephone==null)?Text("Tel non disponible"):Text('Tel: ${user.telephone}'),
                                  trailing: Icon(Icons.chat_bubble),
                                  title: Text('${user.prenom} ${user.nom} ${user.mail}'),

                                  // trailing: Text('Date : ${formatjour.format(entreprise.depart)} - ${formatheure.format(entreprise.depart)}'),
                                ),
                              ),
                              onTap: (){
                                print('messagerie');


                              },

                            );

                          }
                          else
                          {
                            return Container();

                          }
                        }











                    }
                ));
          }
        }
    );
  }

}