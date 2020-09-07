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
    String url = urlafricarpayement;
    var requestbody ={
      "merchant_key": "bd77ff4d",
    "currency": "OUV",
    "order_id": "MY_ORDER_ID_08082105_ksdjsfjjsk",
    "amount": 1200,
    "return_url": "http://myvirtualshop.webnode.es",
    "cancel_url": "http://myvirtualshop.webnode.es/txncncld/",
    "notif_url": "http://www.merchant-example2.org/notif",
    "lang": "fr",
    "reference": "Africar",


    "status":201,
    "message":"OK",
    "pay_token":"f5720dd906203c62033ffe64ed75614785878b0ab2231d9c582b2908fca0ab9a",
    "payment_url":"https:\/\/webpayment-qualif.orange-money.com\/payment\/pay_token\/f5720dd906203c62033ffe64ed75614785878b0ab2231d9c582b2908fca0ab9a",
    "notif_token":"dd497bda3b250e536186fc0663f32f40"
    };
    http.Response response=await http.post(
        url,
        headers: {"Accept": "application/json","Content-Type": "application/json","Authorization": "Bearer R0luU1gybEJCR3h5Rnc3Z3MxakFFSVRreFBhTUFpaUc6a2ZWNnhlSGEwbVcxNWV6TA"},
        body: json.encode(requestbody),
        encoding: Encoding.getByName("utf-8"),
    );
    print(response.statusCode);





  }


  _launchURL() async {
    String url = urlafricarpayement;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}