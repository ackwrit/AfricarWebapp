
import 'dart:math';

import 'package:africarwebapp/fonction/firestoreHelper.dart';
import 'package:africarwebapp/model/Indicator.dart';
import 'package:africarwebapp/model/chiffres.dart';
import 'package:africarwebapp/view/my_widgets/loading_center.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';


class financePartenaire extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return financepartenaireState();
  }

}

class financepartenaireState extends State<financePartenaire> {

  //Variable
  DateTime now = DateTime.now();
  int denominateur = 100000;
  int touchedIndex;


  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = true;
  int ancienjan = 0;
  int ancienfev = 0;
  int ancienmar = 0;
  int ancienavril = 0;
  int ancienmai = 0;
  int ancienjuin = 0;
  int ancienjuil = 0;
  int ancienaout = 0;
  int anciensep = 0;
  int ancienoct = 0;
  int anciennov = 0;
  int anciendec = 0;


  //


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return _buildBody(context);
  }


  Widget _buildBody(BuildContext context) {
    String uidChiffre = '${now.year}${globalUser.uid}';
    return StreamBuilder <QuerySnapshot>(
        stream: firestoreHelper().fire_chiffre.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingCenter();
          }
          else {
            List<DocumentSnapshot> documents = snapshot.data.documents;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (BuildContext ctx, int index) {
                  chiffres chiffreAffaire = chiffres(documents[index]);
                  if (chiffreAffaire.uidChiffre == uidChiffre) {
                    return Column(
                      children: [
                        Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 1.5,
                            padding: EdgeInsets.all(20),
                            child: Center(
                                child: Stack(
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 1.70,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                            color: Color(0xff232d37)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18.0,
                                              left: 12.0,
                                              top: 24,
                                              bottom: 12),
                                          child: LineChart(
                                            mainData(chiffreAffaire),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      height: 34,
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            showAvg = !showAvg;
                                          });
                                        },
                                        child: Text(
                                          "Chiffre d'affaire",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: showAvg ? Colors.white
                                                  .withOpacity(0.5) : Colors
                                                  .white),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            )
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/1.5,
                          padding: EdgeInsets.all(20),
                          child: graphfromage(chiffreAffaire),
                        )
                        

                      ],
                    );
                  }
                  else {
                    return Container();
                  }
                }
            );
          }
        }

    );
  }


  LineChartData mainData(chiffres business) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),


          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'JAN';
              case 1:
                return 'FEV';
              case 2:
                return 'MAR';
              case 3:
                return 'AVR';
              case 4:
                return 'MAI';
              case 5:
                return 'JUIN';
              case 6:
                return 'JUIL';
              case 7:
                return 'AOU';
              case 8:
                return 'SEP';
              case 9:
                return 'OCT';
              case 10:
                return 'NOV';
              case 11:
                return 'DEC';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          /*getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),*/
          textStyle: TextStyle(
              color: Color(0xff67727d),
              fontWeight: FontWeight.bold,
              fontSize: 15),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10M CFA';
              case 3:
                return '30M CFA';
              case 5:
                return '50M CFA';
              case 2:
                return '20M CFA';
              case 4:
                return '40M CFA';
              case 6:
                return '60M CFA';
              case 7:
                return '70M CFA';
              case 8:
                return '80M CFA';
              case 9:
                return '90M CFA';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, (business.janvier / denominateur)),
            FlSpot(1, (business.fevrier / denominateur)),
            FlSpot(2, (business.mars / denominateur)),
            FlSpot(3, (business.avril / denominateur)),
            FlSpot(4, (business.mai / denominateur)),
            FlSpot(5, (business.juin / denominateur)),
            FlSpot(6, (business.juillet / denominateur)),
            FlSpot(7, (business.aout / denominateur)),
            FlSpot(8, (business.septembre / denominateur)),
            FlSpot(9, (business.octobre / denominateur)),
            FlSpot(10, (business.novembre / denominateur)),
            FlSpot(11, (business.decembre / denominateur)),


          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,

          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,

          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '100M CFA';
              case 3:
                return '30M CFA';
              case 5:
                return '50M CFA';
              case 2:
                return '20M CFA';
              case 4:
                return '40M CFA';
              case 6:
                return '60M CFA';
              case 7:
                return '70M CFA';
              case 8:
                return '80M CFA';
              case 9:
                return '90M CFA';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(
                0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(
                0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(
                0.2).withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(
                0.2).withOpacity(0.1),
          ]),
        ),
      ],
    );
  }


  Widget graphfromage(chiffres business){
    int total=business.janvier+business.fevrier+business.mars+business.avril+business.mai+business.juin+business.juillet+business.aout+business.septembre+business.octobre+business.novembre+business.decembre;
    return AspectRatio(
      aspectRatio: 1.6,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(
                          touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse
                                  .touchInput is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex =
                                    pieTouchResponse.touchedSectionIndex;
                              }
                            });
                          }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(business,total)),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'Janvier',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Février',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'Mars',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff13d38e),
                  text: 'Avril',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.amber,
                  text: 'Mai',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.purpleAccent,
                  text: 'Juin',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.limeAccent,
                  text: 'Juillet',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.redAccent,
                  text: 'Aout',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.black12,
                  text: 'Septembre',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.teal,
                  text: 'Octobre',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.yellowAccent,
                  text: 'Novembre',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.blueAccent,
                  text: 'Decembre',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }


  List<PieChartSectionData> showingSections(chiffres business,int total) {
    int decimals=1;
    int fac=pow(10,decimals);
    double jan=(business.janvier)/total*100;
    jan=(jan*fac).round()/fac;
    double fev=(business.fevrier)/total*100;
    fev=(fev*fac).round()/fac;
    double mar=(business.mars)/total*100;
    mar=(mar*fac).round()/fac;
    double avr=(business.avril)/total*100;
    avr=(avr*fac).round()/fac;
    double mai=(business.mai)/total*100;
    mai=(mai*fac).round()/fac;
    double juin=(business.juin)/total*100;
    juin=(juin*fac).round()/fac;
    double juil=(business.juillet)/total*100;
    juil=(juil*fac).round()/fac;
    double aout=(business.aout)/total*100;
    aout=(aout*fac).round()/fac;
    double sep=(business.septembre)/total*100;
    sep=(sep*fac).round()/fac;
    double oct=(business.octobre)/total*100;
    oct=(oct*fac).round()/fac;
    double nov=(business.novembre)/total*100;
    nov=(nov*fac).round()/fac;
    double dec=(business.decembre)/total*100;
    dec=(dec*fac).round()/fac;

    return List.generate(11, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: (jan==0)?0:jan,
            title: (jan==0)?'':'$jan%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: (fev==0)?0:fev,
            title: (fev==0)?'':'$fev%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: (mar==0)?0:mar,
            title: (mar==0)?'':'$mar%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Color(0xff13d38e),
            value: (avr==0)?0:avr,
            title: (avr==0)?'':'$avr%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.amber,
            value: (mai==0)?0:mai,
            title: (mai==0)?'':'$mai%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 5:
          return PieChartSectionData(
            color: Colors.purpleAccent,
            value: (juin==0)?0:juin,
            title: (juin==0)?'':'$juin%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 6:
          return PieChartSectionData(
            color: Colors.limeAccent,
            value: (juil==0)?0:juil,
            title: (juil==0)?'':'$juil%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 7:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: (aout==0)?0:aout,
            title: (aout==0)?'':'$aout%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 8:
          return PieChartSectionData(
            color: Colors.black12,
            value: (sep==0)?0:sep,
            title: (sep==0)?'':'$sep%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 9:
          return PieChartSectionData(
            color: Colors.teal,
            value: (oct==0)?0:oct,
            title: (oct==0)?'':'$oct%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 10:
          return PieChartSectionData(
            color: Colors.yellowAccent,
            value: (nov==0)?0:nov,
            title: (nov==0)?'':'$nov%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 11:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: (dec==0)?0:dec,
            title: (dec==0)?'':'$dec%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}


