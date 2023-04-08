import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../res/Colors.dart';
import '../ConsumerTab.dart';

class Purchase_web extends StatefulWidget {

  String prgmId="",prgmQTY="",prgmType="",program_price="",outlet_id="";


  Purchase_web(
  this.prgmId, this.prgmQTY, this.prgmType,this.program_price, this.outlet_id);

  @override
  State<Purchase_web> createState() => _Purchase_webState(
      prgmId, prgmQTY, prgmType,program_price, outlet_id);
}

class _Purchase_webState extends State<Purchase_web> {
  String url_encode="";
  String prgmId="",prgmQTY="",prgmType="",program_price="",outlet_id="";


  _Purchase_webState(
      this.prgmId, this.prgmQTY, this.prgmType,this.program_price, this.outlet_id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(prgmType.toString());
    url_encode="consumer_id="+CommonUtils.consumerID.toString()+
        "&program_id="+prgmId+"&program_type="+prgmType+"&quantity="+prgmQTY+"&program_price="+program_price+"&outlet_id="+outlet_id;
    print("PayURL"+url_encode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          //automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text("Confirm Payment"),
          backgroundColor: Maincolor

      ),
      body: Container(
        width: double.infinity,
        height:500 ,
        child: InAppWebView(

          initialUrlRequest: URLRequest(
            url: Uri.parse(
                PAYMENT_URL),
            method: 'POST',
            body: Uint8List.fromList(utf8.encode(url_encode)),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            },

          ),
          onWebViewCreated: (controller) {
          },
          onProgressChanged: (InAppWebViewController controller,int progres){
          },

          onTitleChanged: (controller, title) {

            if(title.toString()=="returntocma"){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumerTab(),));
              CommonUtils.NAVIGATE_PATH="walletPage";
            }

          },
        ),
      ),

    );
  }
}
