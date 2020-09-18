import 'package:africarwebapp/model/utilisateur.dart';
import 'package:flutter/material.dart';


//Gloabl user
utilisateur globalUser;
DateTime globalTimeDepart;


//Widget
Widget imagebar = Image.asset("assets/newlogo.jpg",height: 225);


//couleur
Color background = Colors.orangeAccent;
Color backgroundbar =Colors.black;



//horaire
DateTime momentDepartNational;
DateTime momentArriveeNational;
DateTime momentDepartInternational;
DateTime momentArriveeInternational;


//Gare

List <String> gares =[
  'Bamako','Bandiagara','Béma','Bla','Boni','Bougouni',
  'Diabé','Diboli','Didjan','Didjeni','Diéma','Dioïla','Djenné','Douentza',
  'Fana','Fatoma',
  'Gao','Gossi',
  'Hombori',
  'Kayes','Kéniéba','Kidal','Kita','Koffi','Kona','Konobougou','Koulikoro','Koury','Koutiala',
  'Labbezanga','Lakamani',
  'Mbessoba','Ménaka','Mopti',
  'Niéna','Niono','Nioro du Sahel',
  'San','Sandaré','Ségou','Sévaré','Sikasso',
  'Tabakoto','Taoudénit','Ténè','Tillaberry','Tombouctou','Toukoto',
  'Yangasso'
];


List<String>garesInternational=[
  'Cotonou',
  'Bobo djoulassa','Ouagadougou',
  'Abidjan','Bouaké','Daloa','Féréké Dougou','Wangolo','Yamoussokoro','Zékoua',
  'Banjul',
  'Accra','Koumassi',
  'Conakry','Divo','Siguiri','Vava',
  'Bamako','Bougouni','Dioïla','Gao','Kayes','Kidal','Koulikoro','Ménaka','Mopti','Nioro du Sahel','Ségou','Sikasso','Taoudénit','Tombouctou',
  'Aleg','Ayoune','Boutilimite','Gogui','Kiffa','Nouakchott','Tintane',
  'Niamey',
  'Dakar','Goudire','Kafrine','Kaolack','Kidira',"M'bour",'Tamba','Thiès',
  'Lomé'
];