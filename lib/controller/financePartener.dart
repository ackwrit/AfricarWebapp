import 'dart:async';

import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/fonction/listing_firestore.dart';
import 'package:africarwebapp/model/billet.dart';
import 'package:africarwebapp/view/my_material.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class financePartenaire extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return financepartenaireState();
  }

}

class financepartenaireState extends State<financePartenaire>{

  var cutOffYValue = 1.0;
  int prix=0;
  DateFormat formatannee= new DateFormat.y('fr_FR');

  var dateTextStyle =
  TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  DateTime annee = new DateTime.now();
  var formatchiffre =new NumberFormat('#,###','fr_FR');
  int compteur;
  analyseCompagnie analyse= new analyseCompagnie(globalUser.uid);

  Widget build(BuildContext context) {
    compteur=0;
    Timer(Duration(minutes:0), () {

          setState(() {

            analyse.listingCA();

          });





    });














    // TODO: implement build
    return   SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width,
        child:Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height/2,
          width:MediaQuery.of(context).size.width/2,
          child: SizedBox(
            width: 300,
            height: 140,
            child:LineChart(
              LineChartData(
                lineTouchData: LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, analyse.affaireJan.toDouble()),
                      FlSpot(1, analyse.affaireFev.toDouble()),
                      FlSpot(2, analyse.affaireMar.toDouble()),
                      FlSpot(3, analyse.affaireAvr.toDouble()),
                      FlSpot(4, analyse.affaireMai.toDouble()),
                      FlSpot(5, analyse.affaireJuin.toDouble()),
                      FlSpot(6, analyse.affaireJuil.toDouble()),
                      FlSpot(7, analyse.affaireAou.toDouble()),
                      FlSpot(8, analyse.affaireSep.toDouble()),
                      FlSpot(9, analyse.affaireOct.toDouble()),
                      FlSpot(10, analyse.affaireNov.toDouble()),
                      FlSpot(11, analyse.affaireDec.toDouble()),
                    ],
                    isCurved: false,
                    barWidth: 4,
                    colors: [
                      Colors.black,
                    ],
                    belowBarData: BarAreaData(
                      show: true,
                      colors: [Colors.green],
                      cutOffY: cutOffYValue,
                      applyCutOffY: true,
                    ),
                    aboveBarData: BarAreaData(
                      show: true,
                      colors: [Colors.red],
                      cutOffY: cutOffYValue,
                      applyCutOffY: true,
                    ),
                    dotData: FlDotData(
                      show: false,
                    ),
                  ),
                ],
                minY: 0,
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 14,
                      textStyle: dateTextStyle,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Jan';
                          case 1:
                            return 'Fév';
                          case 2:
                            return 'Mar';
                          case 3:
                            return 'Avr';
                          case 4:
                            return 'Mai';
                          case 5:
                            return 'Juin';
                          case 6:
                            return 'Juil';
                          case 7:
                            return 'Aou';
                          case 8:
                            return 'Sep';
                          case 9:
                            return 'Oct';
                          case 10:
                            return 'Nov';
                          case 11:
                            return 'Dec';
                          default:
                            return '';
                        }
                      }),
                  leftTitles: SideTitles(
                    showTitles: false,
                   getTitles: (value) {
                      return '${formatchiffre.format(value)} ';
                    },

                  ),
                ),
                axisTitleData: FlAxisTitleData(
                  show: true,
                  leftTitle: AxisTitle(showTitle: true, titleText: '    ', margin: 4),
                  topTitle: AxisTitle(
                      showTitle: true,
                      margin:0,
                      titleText: "Chiffre d'affaire ${formatannee.format(annee)}",
                      textStyle: dateTextStyle,
                      textAlign: TextAlign.right),
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 1,
                  verticalInterval: 10000,
                  drawHorizontalLine: true,
                  checkToShowHorizontalLine: (double value) {
                    return value == analyse.affaireJan.toDouble()
                        || value == analyse.affaireJuin.toDouble()
                        || value == analyse.affaireSep.toDouble()
                        || value == analyse.affaireMai.toDouble();
                  },
                ),
              ),
            ),
          ),

        ),
      ),

    );








  }






}