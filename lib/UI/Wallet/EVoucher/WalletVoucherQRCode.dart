import 'dart:convert';

import 'package:consumer5/res/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Others/AlertDialogUtil.dart';
import '../../../Others/CRCCheckCalculation2.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Strings.dart';
import '../../ConsumerTab.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../Models/Card/WalletmodelVoucher1New.dart';
class WalletVoucherQRCode extends StatefulWidget {
  final WalletmodelVoucher1New Object1;
   WalletVoucherQRCode({Key? key,required this.Object1}) : super(key: key);

  @override
  State<WalletVoucherQRCode> createState() => _WalletVoucherQRCodeState(Object1,Object1.program_type);
}

class _WalletVoucherQRCodeState extends State<WalletVoucherQRCode> {
  final WalletmodelVoucher1New object1;
  String prgmType;
  var fulrnuno;
  _WalletVoucherQRCodeState(this.object1, this.prgmType);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          /*ClipRRect(
             borderRadius: BorderRadius.circular(20),
              child: Center(child: Image.network(object1.programBackgroundImgURL,fit: BoxFit.fill,height: MediaQuery.of(context).size.height * 0.2,))),
        */  ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                object1.img_url, width: MediaQuery
                  .of(context)
                  .size
                  .width / 2,)),
          SizedBox(height: 10,),
           Wrap(
             alignment: WrapAlignment.center,
            children: [

              Text(expiry+ object1.expire_date,style: TextStyle(fontSize: 12),),
              SizedBox(width: 50,),
              setFullRunNO(no+ object1.program_id.toString()+"- "+object1.full_run_no.toString()),
            ],
          ),
          SizedBox(height: 10,),
          Container(color: lightGrey, height: 1,),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Text(
              "Scan code to redeem this voucher",
              style: TextStyle(color: corporateColor, fontSize: 14),),
          ),
          SizedBox(height: 10,),
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
          SizedBox(height: 10,),
          Center(child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: poketblue2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            child: InkWell(
              onTap: (){
                clickredeem();
              },
              child: Center(
                  child: Text(
                    "Use Manual Redemption",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget generateQRCode(String FullRunno, String ProgramType, String qty1,
      String GiftCardOrderId, String prgmId) {
    print(ProgramType.toString()+prgmId.toString()+prgmType.toString());
    return FutureBuilder(
      future: getdata1(FullRunno, ProgramType, qty1, GiftCardOrderId, prgmId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final String post = snapshot.data.toString();
          return QrImage(

            data: post,
            version: QrVersions.auto,
            size: 200,
            gapless: false,
            foregroundColor: Colors.black54,

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

  Widget setFullRunNO(String data){
    fulrnuno=data;
    return Text(data,
      style:  TextStyle(fontSize: 12),
    );
  }
  Future<void> clickredeem() {
    TextEditingController mTxtRedeemCodeController=TextEditingController();
    TextEditingController mTxtRemarksController=TextEditingController();
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(5.0)),
            child: Container(

              height: 200,
              child: Padding(

                padding: const EdgeInsets.only(left:15.0,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
                    SizedBox(height: 10,),
                    TextField(
                      controller: mTxtRedeemCodeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[

                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly

                      ],
                      decoration: InputDecoration(

                        hintText: "Enter Redemption Code",
                        hintStyle: TextStyle(fontSize: 17,color: Colors.grey),

                        enabledBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey,),
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey,),
                        ),

                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        controller: mTxtRemarksController,

                        decoration: InputDecoration(
                          hintText: "Remarks",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        )
                    ),

                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 35,
                              width: 100,
                              color: Colors.white,
                              child: Center(
                                  child: Text(
                                    cancel_caps,
                                    style: TextStyle(color: Maincolor),
                                  )),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async{
                            if(mTxtRedeemCodeController.text.toString()!=""){
                              showLoadingView(context);
                              var connectivityresult = await(Connectivity().checkConnectivity());
                              if(connectivityresult == ConnectivityResult.mobile || connectivityresult == ConnectivityResult.wifi ) {
                                print("connecr");
                                Navigator.pop(context, true);
                                callRedeemAPIForVoucher(mTxtRedeemCodeController.text,mTxtRemarksController.text);
                              }
                              else{
                                showAlertDialog_oneBtnWitDismiss(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
                                print("notttt");

                              }
                            }
                            else{
                              showAlertDialog_oneBtn(context, alert, "Please fill in all the fields");
                            }
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 35,
                              width: 100,
                              color: Colors.white,
                              child: Center(
                                  child: Text(
                                    ok,
                                    style: TextStyle(color: Maincolor),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],

                ),
              ),
            ),
          );
        }
    );
  }
  Future<void> callRedeemAPIForVoucher(var redeemCode,var remarks) async {
    // showLoadingView(context);
    print(object1.full_run_no);
    print(object1.merchant_id);
    print(object1.program_id);
    print(redeemCode.toString());
    print(REDEEMVOUCHER_URL.toString());
    final http.Response response = await http.post(
      Uri.parse(REDEEMVOUCHER_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": object1.program_id.toString(),
        "redemption_code":redeemCode.toString(),
        "remarks":remarks.toString(),
        "device_token_id":CommonUtils.deviceTokenID.toString(),
       // "member_id":object1.member_id.toString(),
        "merchant_id":object1.merchant_id.toString(),
        'merchant_country_index':"191",
        'country_index':"191",
        "serial_no":object1.member_id.toString()

      },
    ).timeout(Duration(seconds: 30));



    print(response.statusCode.toString());


    // Navigator.pop(context);
    print("Mres:${response.body.toString()}");
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      var status = Utils().stringSplit(newData['p1']);

      var message = Utils().stringSplit(newData['p2']);

      var p3 = Utils().stringSplit(newData['p3']);

      if ( status=="True") {
        showAlertDialog_oneBtnWitDismissrdeem(context, alert, message);
      }
      else { showAlertDialog_oneBtnWitDismiss(context, alert, "Invalid Redemption Code");}
    }

    else {showAlertDialog_oneBtn(context, alert1, something_went_wrong1);}
  }
  void showAlertDialog_oneBtnWitDismissrdeem(BuildContext context,String tittle,String message)
  {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message,style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            print("refreshcheck");
            CommonUtils.NAVIGATE_PATH=CommonUtils.walletPage;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ConsumerTab()));
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child:Center(child: Text(ok,style: TextStyle(color: Maincolor),)),
            ),
          ),
        ),
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((exit){
      if (exit == null) return;

      if (exit) {
        // back to previous screen

        Navigator.pop(context);
      } else {
        // user pressed No button
      }
    });

  }
}

