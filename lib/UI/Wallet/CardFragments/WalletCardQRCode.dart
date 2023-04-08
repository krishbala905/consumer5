import 'dart:convert';

import 'package:consumer5/res/Colors.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';

import '../../../Others/CRCCheckCalculation2.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

import '../Models/Card/WalletmodelNew.dart';
class WalletCardQRCode extends StatefulWidget {
  // final WalletViewmodel Object1;
  final WalletmodelNew Object1;
   WalletCardQRCode({Key? key,required this.Object1}) : super(key: key);

  @override
  State<WalletCardQRCode> createState() => _WalletCardQRCodeState(Object1,Object1.program_type);
}

class _WalletCardQRCodeState extends State<WalletCardQRCode> {
  final WalletmodelNew object1;
  String prgmType;
  var programPoints = "";
var expriybuttoncheck;
  _WalletCardQRCodeState(this.object1, this.prgmType);

  void initState() {
  super.initState();
    getRewardData().then((results){
      setState((){
        programPoints = results[0];
      });

  });
        }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
        setCardUIImage(object1.img_url,object1.program_title,object1.LogoURL,"0",object1.ProgramTitleSettings,object1.FontColor,object1.expire_date),

          SizedBox(height: 20,),
          if(programPoints.toString().contains("."))Text(
            programPoints + " POINTS",
            style: TextStyle(fontSize: 16, color: GrayColor),),
          if(!programPoints.toString().contains("."))Text(
            programPoints + ".00 POINTS",
            style: TextStyle(fontSize: 16, color: GrayColor),),
          SizedBox(height: 20,),
          Container(color: lightGrey, height: 1,),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Text(
              "Scan your code on merchant's device to receive your rewards for your purchase",
              style: TextStyle(color: corporateColor, fontSize: 14),),
          ),
          SizedBox(height: 20,),
          Container(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/img_brackettopleft.png", width: 30, height: 30,),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "assets/img_brackettopright.png", width: 30, height: 30,),
                  ),
                ),

              ],
            ),
          ),
          Center(child:

          // generateQRCode(fullRunNo,prgmType,qty,giftcardOrderId,prgMId),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: generateQRCode( "", object1.program_type, "1", "0", object1.program_id),
          ),

            // generateQRCodeForPOS(),

          ),
          Container(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      "assets/img_bracketbtmleft.png", width: 30, height: 30,),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      "assets/img_bracketbtmright.png", width: 30, height: 30,),
                  ),
                )

              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget generateQRCode(String FullRunno, String ProgramType, String qty1,
      String GiftCardOrderId, String prgmId) {
    return FutureBuilder(
      future: getdata1("", ProgramType, qty1, GiftCardOrderId, prgmId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final String post = snapshot.data.toString();
          return QrImage(
            data: post,
            foregroundColor: Colors.black54,
            version: QrVersions.auto,
            size: 200,
            gapless: false,

            errorStateBuilder: (cxt, err) {
              return Container(
                child: Center(
                  child: Text(
                    err.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<String> getdata1(String FullRunno,String ProgramType,String qty1,String GiftCardOrderId,String prgmId) async {
    int programId ;

    if(ProgramType.toLowerCase()=="events"){
      programId = int.parse(GiftCardOrderId) ;
    }
    else{
      programId = int.parse(prgmId);
    }

    int countryIndex= int.parse(CommonUtils.COUNTRY_INDEX.toString());

    int programCategoryType;

    if(ProgramType=="events"){
      programCategoryType=18;
    }
    else{
      programCategoryType= int.parse(object1.sub_type );
    }

    int programType=1;
    if(prgmType=="vouchercard")
    {
      programType=3;
    }
    else if(prgmType=="storecard")
    {
      programType=2;
    }

    else
    {
      programType=1;
    }

    String actionType;
    var consumerName ;
    if (programType == 1) {
      actionType = "ms";
      int memberId =int.parse(object1.member_id);


      CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType, countryIndex,0,0);
      consumerName = await crc2.checkNewCRC(programCategoryType);
      print(consumerName);
    }

    else if (programType == 2) {
      actionType = "sc";
      int memberId = int.parse(object1.member_id) ;

      CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType, countryIndex,0,0);
      consumerName = await crc2.checkNewCRC(programCategoryType);
    } else if (programType == 3) {
      actionType = "rv";
      //String vouche         rNo = program.getSerialNumber();
      int memberId = int.parse(object1.member_id);

      CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId,memberId, actionType, countryIndex,0,0);
      consumerName =await crc2.checkNewCRC(programCategoryType);

    }
    else if (programType == 17) {
      actionType = "rv";
      //String voucherNo = program.getSerialNumber();
      int memberId = int.parse(object1.member_id);
      CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(programId, memberId, actionType,
          countryIndex,int.parse(qty1),int.parse(GiftCardOrderId ));
      consumerName =await crc2.checkNewCRC(programCategoryType);

    }

    else if (programType == 18) {
      actionType = "events";



      // CRCCheckCalculation2 crc2 = new CRCCheckCalculation2(
      //     programId, ParseAsInteger(FullRunno),
      //     actionType, countryIndex,0,0);
      // consumerName = crc2.checkNewCRC(programCategoryType);

    }
    return consumerName;
  }



  Future<List<dynamic>> getRewardData() async {
    print(CARD_REWARDS_URL.toString());

    final http.Response response = await http.post(
      Uri.parse(CARD_REWARDS_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        //  "order_data": "newest",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':"18",
        'consumer_language_id':CommonUtils.APPLICATIONLANGUAGEID,
        "program_id":object1.program_id,
        "merchant_id":object1.merchant_id,
        "member_id":object1.member_id,


      },
    ).timeout(Duration(seconds: 30));



    if(response.statusCode == 200) {

      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);

      var newData1 = data['info'];
      var newData = newData1['info'];
      var p1 = Utils().stringSplit(newData['p1']);

      var p2 = Utils().stringSplit(newData['p2']);

      var p3 = Utils().stringSplit(newData['p3']);
      var p4 = Utils().stringSplit(newData['p4']);
      var p5 = Utils().stringSplit(newData['p5']);
      var p6 = Utils().stringSplit(newData['p6']);
      var p7 = Utils().stringSplit(newData['p7']);
      expriybuttoncheck = p7;


      List<String> currencySymbol = p2.split("*") ;
      List<String> yourPoints = p3.split("*") ;
      // List<String> oneYearSpending = p4.split("*") ;
      List<String> oneYearSpending = p5.split("*") ;
      List<String> accumulatedSpending = p6.split("*") ;
      print(yourPoints.toString());
      print(yourPoints[0].toString());
      var programPointss = yourPoints[0].toString();
     // setState(() {
        //CommonUtils.programPoints = yourPoints[0].toString();
     // });
return [programPointss];
    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }

  Widget setCardUIImage(var imgUrl,var tittle,var logoUrl,var showLogo,var showTittle,var fontColor,var expireDate){

    print("121:"+showLogo);
    print("12:"+showTittle);

    if(showLogo=="0" && showTittle=="0"){
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(

            children: [
              Image.network(imgUrl,width: MediaQuery.of(context).size .width / 2,),
              Positioned(child: Text(CommonUtils.consumerName.toString(),style: TextStyle(color: Colors.black),),left:10,bottom: 25),
              Positioned(child: Text("Expiry: "+expireDate,style: TextStyle(color: Colors.black)),left: 10,bottom: 5),




            ],

          ),
        ),
      );
    }
    else if(showLogo=="0" && showTittle=="1"){
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.network(imgUrl,width: MediaQuery.of(context).size .width / 2,),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Center(
                child: Text(tittle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize:10,color: hexStringToColor(fontColor)),maxLines: 3,),
              ),
            ),
          ],

        ),
      );
    }
    else if(showLogo=="1" && showTittle=="0"){
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.network(imgUrl,width: MediaQuery.of(context).size .width / 2,),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  Image.network(logoUrl??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                    width: 20,height: 20,),
                  SizedBox(width: 10,),


                ],
              ),
            ),
          ],

        ),
      );
    }
    else{
      return ClipRRect(  borderRadius: BorderRadius.circular(20),child: Image.network(imgUrl,width: MediaQuery.of(context).size .width / 2,));
    }
  }
}
