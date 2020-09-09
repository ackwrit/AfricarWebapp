import 'dart:io';

import 'package:africarwebapp/model/billet.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import'package:http/http.dart' as http;
import 'dart:convert';

class billetValidation extends StatefulWidget{
  billet billets;
  billetValidation({this.billets});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homeValidation();
  }

}

class _homeValidation extends State<billetValidation> {
  DateFormat formatjour = DateFormat.yMMMMd('fr_FR');
  DateFormat formatheure = DateFormat.Hm('fr_FR');
  String urlsimulateur= 'https://simulator.webpayment-ow-sb.orange-money.com/simulator';
  String urlafricarpayement ='https://api.orange.com/orange-money-webpay/dev/v1/webpayment';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: imagebar,
        centerTitle: true,
        backgroundColor: backgroundbar,
      ),
      backgroundColor: background,
      body: bodyPage(),

    );
  }


  Widget bodyPage() {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height / 1.4,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Text('Contact client', style: TextStyle(fontSize: 25),),
            Text('Référence billet n° ${widget.billets.id}'),
            Text('Trajet : ${widget.billets.lieuDepart} - ${widget.billets
                .lieuArrivee}'),
            Text('Date: ${formatjour.format(
                widget.billets.depart)} - ${formatheure.format(
                widget.billets.depart)}'),
            Text("${widget.billets.nomPassager}  ${widget.billets
                .prenomPassager}"),
            Text("tel: ${widget.billets.telephobne}"),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              color: backgroundbar,
              onPressed: _httpPost,
              child: Text('Validation', style: TextStyle(color: background),),

            ),

          ],
        ),
      ),
    );
  }




  Future _httpPost() async{
    String urls = urlafricarpayement;
    const url = 'https://example.com/whatsit/create';
    const test ='www.google.com';
    var credentials="R0luU1gybEJCR3h5Rnc3Z3MxakFFSVRreFBhTUFpaUc6a2ZWNnhlSGEwbVcxNWV6TA";
    final strintobas64=utf8.fuse(base64);
    final  encodedCredentials= strintobas64.encode(credentials);

   Map <String,String> entete={
     HttpHeaders.authorizationHeader :"Bearer $credentials",
    HttpHeaders.contentTypeHeader:"application/json",
     HttpHeaders.acceptHeader:"application/json",
     HttpHeaders.hostHeader:"api.orange.com",
     //"Postman-Token": "e18f3aac-9bd7-ddc5-a3a4-668e6089a0d5"
    };
    Map<String,dynamic>  payload = {
    "merchant_key": "bd77ff4d",
    "currency": "OUV",
    "order_id": "MY_ORDER_ID_08082105_0023457",
    "amount": '1200',
    "return_url": "http://myvirtualshop.webnode.es",
    "cancel_url": "http://myvirtualshop.webnode.es/txncncld/",
    "notif_url": "http://www.merchant-example2.org/notif",
    "lang": "fr",
    "reference":"MerchantWP00095",

    };

    Map<String,dynamic> payToken ={
      "pay_token":"R0luU1gybEJCR3h5Rnc3Z3MxakFFSVRreFBhTUFpaUc6a2ZWNnhlSGEwbVcxNWV6TA",
      "payment_url":"https:\/\/webpayment-qualif.orange-money.com\/payment\/pay_token\/R0luU1gybEJCR3h5Rnc3Z3MxakFFSVRreFBhTUFpaUc6a2ZWNnhlSGEwbVcxNWV6TA",
      "notif_token":"dd497bda3b250e536186fc0663f32f40"
    };

    http.Response response = await http.post(
    "orange-money-webpay/dev/v1/webpayment HTTP/1.1",

        headers: entete,
        body: json.encode(payload)
    );









    print(response.statusCode);
    print(response.request);
    print(response.headers);
    //print(response.body);






  }


  _launchURL() async {
    const url = 'https://api.orange.com/orange-money-webpay/dev/v1/webpayment';
    var credentials="R0luU1gybEJCR3h5Rnc3Z3MxakFFSVRreFBhTUFpaUc6a2ZWNnhlSGEwbVcxNWV6TA";
    String urls = urlafricarpayement;
    Map <String,String> entete={HttpHeaders.authorizationHeader :"Bearer $credentials",
      HttpHeaders.contentTypeHeader:"application/json",
      HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.hostHeader:"api.orange.com",
      "merchant_key": "bd77ff4d",
      "currency": "OUV",
      "order_id": "MY_ORDER_ID_08082105_0023457",
      "amount": "1200",
      "return_url": "http://myvirtualshop.webnode.es",
      "cancel_url": "http://myvirtualshop.webnode.es/txncncld/",
      "notif_url": "http://www.merchant-example2.org/notif",
      "lang": "fr",
      "reference":"MerchantWP00095",

    };
    if (await canLaunch(url)) {
      await launch(url,
          headers: entete,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}