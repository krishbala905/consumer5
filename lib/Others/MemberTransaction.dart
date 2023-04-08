import 'dart:convert';


import 'package:xml2json/xml2json.dart';
import 'package:flutter/material.dart';

import '../UI/ConsumerTab.dart';
import '../res/Colors.dart';
import '../res/Strings.dart';
import 'CommonUtils.dart';
import 'TransactionFeedback.dart';


class MemberTransaction extends StatefulWidget {
  var prgmId;
  var programName;
  var rewardPoints;
  var extraPoints;
  var merchantId;
  var merchantName;
  var memberId;
  var queue;
  var transactionId;
  var feedbackPoints;
  var countryIndex;
  var outletId;
  var cardType;
  var imageUrl;
  var pnsId;

  MemberTransaction(
  this.prgmId,
  this.programName,
  this.rewardPoints,
  this.extraPoints,
  this.merchantId,
  this.merchantName,
  this.memberId,
  this.queue,
  this.transactionId,
  this.feedbackPoints,
  this.countryIndex,
  this.outletId,
  this.cardType,
  this.imageUrl,
  this.pnsId,
  {Key? key}) : super(key: key);

  @override
  State<MemberTransaction> createState() => _MemberTransactionState(
    prgmId, programName, rewardPoints, extraPoints, merchantId, merchantName, memberId, queue, transactionId, feedbackPoints, countryIndex, outletId, cardType, imageUrl,pnsId
  );
}

class _MemberTransactionState extends State<MemberTransaction> {
  var prgmId;var programName;var rewardPoints;var extraPoints;var merchantId;var merchantName;var memberId;var queue;var transactionId;var feedbackPoints;var countryIndex;var outletId;var cardType;var imageUrl;
  var pnsId;


  _MemberTransactionState(
      this.prgmId,
      this.programName,
      this.rewardPoints,
      this.extraPoints,
      this.merchantId,
      this.merchantName,
      this.memberId,
      this.queue,
      this.transactionId,
      this.feedbackPoints,
      this.countryIndex,
      this.outletId,
      this.cardType,
      this.imageUrl,
      this.pnsId
      );

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    if(rewardPoints.toString().contains(".")) {
      rewardPoints = rewardPoints;
    }
    if(!rewardPoints.toString().contains(".")){
      rewardPoints = rewardPoints + ".00";}

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: corporateColor,
        centerTitle: true,
        leading: InkWell(
            onTap:(){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,)),
        title: Text("MBM Wheelpower",style: TextStyle(color: Colors.white,fontSize: 17),),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text(thank_you,style: TextStyle(color: lightGrey1,fontSize: 18),),
            Text(you_have_received_points+rewardPoints+points+from_carsearch,style: TextStyle(color: lightGrey1,fontSize: 18),),
            SizedBox(height: 10,),
            Container(
              width: 350,
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Container(
                        width: 300,
                        height: 300,

                        decoration: const BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/img_points.png'),
                            )
                        ),
                        child:


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              Text(rewardPoints,style: TextStyle(color: corporateColor,fontSize: 24),),
                              Text(points_earned,style: TextStyle(color: corporateColor,fontSize: 20),)
                          ],
                        )
                    ),

                    const SizedBox(height: 20,),
                    Visibility(
                      visible: true,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: backgroundcolor3
                          ),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.facebook,color: Colors.white,),
                              SizedBox(width: 5,),
                              Text(share_fb,style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TransactionFeedback(
                    rewardPoints,transactionId,prgmId,pnsId
                ),));
                /*print("1:"+pnsId);
                CommonUtils.pid=pnsId;
                print("12:"+CommonUtils.pid);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConsumerTab(),));
              */},
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: poketblue,
                ),
                child: Center(child: Text(got_it_txt,style: TextStyle(color: Colors.white),),),
              ),
            ),
            SizedBox(height: 20,),
            /*InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TransactionFeedback(
                    rewardPoints,transactionId,prgmId,pnsId
                ),));
              },
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: corporateColor,width: 1),
                  borderRadius: BorderRadius.circular(20),

                ),
                child: Center(
                  child:
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(please_rate_our_service,style: TextStyle(color: corporateColor),),
                      SizedBox(width: 20,),
                      Image.asset("assets/ic_white_smiley.png",width: 20,height: 20,),
                    ],
                  ),

                ),
              ),
            ),
            SizedBox(height: 20,),*/

          ],
        ),
      ),

    );
  }
}
