import 'dart:io';

import 'package:africarwebapp/model/billet.dart';
import 'package:africarwebapp/model/my_token.dart';
import 'package:africarwebapp/model/my_token_payement.dart';
import 'package:africarwebapp/view/my_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import'package:http/http.dart' as http;
import 'package:http/browser_client.dart';
import 'dart:convert';
import 'package:universal_io/io.dart';

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
    double prixTotal = widget.billets.prixAller + widget.billets.prixRetour;
    
    String urls = urlafricarpayement;
    var credentials="R0luU1gybEJCR3h5Rnc3Z3MxakFFSVRreFBhTUFpaUc6a2ZWNnhlSGEwbVcxNWV6TA";
    // Récupération du token pour paiement
    Map<String,String>headerToken={
      HttpHeaders.authorizationHeader :'Basic $credentials',
      "Access-Control-Allow-Origin":"http://api.orange.com",
      "Access-Control-Request-Method": "POST",
      "Access-Control-Request-Headers":"Content-Type"





      //HttpHeaders.contentTypeHeader:'application/json',
    };
    Map<String,dynamic> bodyToken ={

      "grant_type":"client_credentials",
      "token_type": "Bearer",
      "expires_in": "777600",
      "access_token": ""

    };
    //BrowserClient httpbroswer=new BrowserClient();
    var response = await http.post('https://api.orange.com/oauth/v2/token',headers: headerToken,body: bodyToken);
    Token body = Token.fromJson(jsonDecode(response.body));


    ///////////////////////////////////
    //activation payment
    Map <String,String> headerpayment={
      HttpHeaders.authorizationHeader :"${body.token_type} ${body.access_token}",
      HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.hostHeader:"api.orange.com",
      HttpHeaders.contentTypeHeader:"application/json"
      //"Postman-Token": "e18f3aac-9bd7-ddc5-a3a4-668e6089a0d5"
    };
    DateTime orderid = DateTime.now();


    Map <String,dynamic> bodypayment ={
      "Content-Type": "application/json",
      "merchant_key": "bd77ff4d",
      "currency": "OUV",
      "order_id": "${orderid.day}${orderid.month}${orderid.year}${orderid.hour}${orderid.minute}${orderid.second}",
      "amount": prixTotal.toString(),
      "return_url": "http://myvirtualshop.webnode.es",
      "cancel_url": "http://myvirtualshop.webnode.es/txncncld/",
      "notif_url": "http://www.merchant-example2.org/notif",
      "lang": "fr",
      "reference":"Africar",

    };

    http.Response paymentResponse = await http.post(
        urlafricarpayement,
        headers: headerpayment,
        body: jsonEncode(bodypayment)

    );
    TokenPayment paymenttoken = TokenPayment.fromJson(jsonDecode(paymentResponse.body));


    //Lancement de la page paiement
    if (await canLaunch(paymenttoken.payment_url)) {
      await launch(paymenttoken.payment_url);
    } else {
      throw 'Could not launch ${paymenttoken.payment_url}';
    }










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