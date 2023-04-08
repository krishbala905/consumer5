import 'dart:convert';
import 'dart:ui';

import 'package:consumer5/res/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:xml2json/xml2json.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import 'package:http/http.dart' as http;

import '../Others/AlertDialogUtil.dart';
import '../Others/CommonUtils.dart';
import '../UI/ConsumerTab.dart';
import '../res/Strings.dart';
//import '../res/Strings.dart';
class TransactionFeedback extends StatefulWidget {
  var rewardPoints, transID, prgmId ,pnsId;
  TransactionFeedback(this.rewardPoints,this.transID,this.prgmId,this.pnsId,{Key? key}) : super(key: key);

  @override
  State<TransactionFeedback> createState() => _TransactionFeedbackState(rewardPoints,transID,prgmId,pnsId);
}

class _TransactionFeedbackState extends State<TransactionFeedback> {
  var rewardPoints, transID, prgmId,pnsId;


  _TransactionFeedbackState(this.rewardPoints, this.transID, this.prgmId,this.pnsId);

  var ratingValue="-1";
  TextEditingController commentCntrller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title:  Text(appName),
            backgroundColor: Maincolor
        ),
        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.only(left:20,right: 20,top: 30),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: GrayColor
                  )
              ),
              width: double.infinity,
              child:Column(
                children: [
                  SizedBox(height: 30,),
                  Text(please_rate_our_service,style: TextStyle(fontSize: 18,color: GrayColor),),
                  SizedBox(height: 5,),
                  Text(get_points,style: TextStyle(fontSize: 18,color: GrayColor),),
                  SizedBox(height: 5,),
                  Text(tap_smile_button_msg,style: TextStyle(color: GrayColor),),
                  SizedBox(height: 30,),
                  Container(

                    height: 100,
                    color: lightGrey2,
                    child: Center(
                      child: RatingBar.builder(
                        itemSize: 50,
                        initialRating: 0,
                        itemCount: 4,
                        unratedColor: GrayColor,
                        updateOnDrag: false,
                        tapOnlyMode: true,
                        wrapAlignment: WrapAlignment.center,
                        itemPadding: EdgeInsets.only(left:10,right: 10),
                        onRatingUpdate: (rating){
                          ratingValue=rating.toString();
                          print(rating.toString());
                        },
                        itemBuilder: (context,index){
                          switch(index){

                            case 0:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Maincolor,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(poor,style: TextStyle(fontSize: 10),),
                                ],
                              );

                            case 1:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:  [
                                  Icon(
                                    Icons.sentiment_neutral,
                                    color: Maincolor,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(average,style: TextStyle(fontSize: 10),),
                                ],
                              );
                            case 2:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:  [
                                  Icon(
                                    Icons.sentiment_satisfied,
                                    color: Maincolor,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(good,style: TextStyle(fontSize: 10),),
                                ],
                              );
                            case 3:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:  [
                                  Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: Maincolor,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(excellent,style: TextStyle(fontSize: 10),),
                                ],
                              );

                            default:
                              return Container();

                          }
                        },

                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(feedback,style: TextStyle(color: Maincolor,),),
                        SizedBox(height:10,),
                        TextField(
                          controller: commentCntrller,
                          maxLines: 8, //or null
                          style: TextStyle(fontSize: 15),

                          decoration: InputDecoration(

                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: GrayColor, width: 1.0),
                                borderRadius: BorderRadius. circular(5.0),
                              ),
                              enabledBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: GrayColor, width: 1.0),
                                borderRadius: BorderRadius. circular(5.0),
                              ),
                              disabledBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: GrayColor, width: 1.0),
                                borderRadius: BorderRadius. circular(5.0),
                              ),

                              hintText: key_in_your_message

                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: (){
                           // CommonUtils.NAVIGATE_PATH = CommonUtils.walletPage;
                            print("1:"+pnsId);
                            CommonUtils.pid=pnsId;
                            print("12:"+CommonUtils.pid);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConsumerTab(),));

                            // Navigator.pop(context,true);
                           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConsumerTab(),));
                            },
                          child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFAEAEAE)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: Text(skip,style: TextStyle(color: Colors.black),)),
                          )),
                      SizedBox(width: 40,),
                      InkWell(
                          onTap: (){
                            // Call API
                            if(ratingValue!="-1"){

                              updateFeedbackData(rewardPoints, transID,
                                  prgmId,ratingValue, commentCntrller.text);
                            }
                            else{
                              showAlertDialog_oneBtn(context, alert1,please_choose_rating );
                            }

                          },
                          child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              color: poketblue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: Text(submit,style: TextStyle(color: Colors.white,),)),
                          ))
                    ],
                  ),
                  SizedBox(height: 15,),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateFeedbackData(var rewardPoints, var transID,
      var prgmId,var rating, var comments) async {
    showLoadingView(context);
    final http.Response response = await http.post(
      Uri.parse(FEEDBACK_URL),

      body: {
        "consumer_id": CommonUtils.consumerID,
        "program_id": prgmId,
        "comments": comments,
        "device_token_id": CommonUtils.deviceTokenID,
        "rating": rating,
        "reward_points": rewardPoints,
        "transaction_id": transID,
        "cma_timestamps": Utils().getTimeStamp(),
        "time_zone": Utils().getTimeZone(),
        "software_version": CommonUtils.softwareVersion,
        "os_version": CommonUtils.osVersion,
        "phone_model": CommonUtils.deviceModel,
        "device_type": CommonUtils.deviceType,
        'consumer_application_type': CommonUtils.consumerApplicationTypee,
        'consumer_language_id': CommonUtils.APPLICATIONLANGUAGEID,
      },
    ).timeout(Duration(seconds: 30));

    Navigator.pop(context, true);
    print("check1" + response.body.toString());
    if (response.statusCode == 200) {
      print(response.body);
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      var status = Utils().stringSplit(newData['p1']);
      var message = Utils().stringSplit(newData['p2']);
      if (status == 'True' || status == '1') {
        print("1:" + pnsId);
        CommonUtils.pid = pnsId;
        print("12:" + CommonUtils.pid);
        showAlertDialog_oneBtn_msgg(context, alert1, message);
      }
      else {
        showAlertDialog_oneBtn(context, alert1, message);
      }
    }
  }
  void showAlertDialog_oneBtn_msgg(BuildContext context,String title, String message)
  {
    AlertDialog alert = AlertDialog(

      backgroundColor: Colors.white,
      title: Text(title),
      // content: CircularProgressIndicator(),
      content: Text(message,style: TextStyle(color: Colors.black45)),

      actions: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context,true);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConsumerTab(),));
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
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6),
          child: alert,
        );
      },
    );
  }
}
