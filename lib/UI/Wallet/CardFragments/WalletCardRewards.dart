import 'dart:convert';
import 'package:toast/toast.dart';
import 'dart:io';
import 'dart:ui';
import 'package:consumer5/UI/Wallet/Models/ERewardsListModel1.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Others/AlertDialogUtil.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/NativeAlertDialog.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import '../../ConsumerTab.dart';
import '../Models/ERewardsModel.dart';
import 'package:xml2json/xml2json.dart';

import '../Models/Card/WalletmodelNew.dart';

class WalletCardRewards extends StatefulWidget {
  final WalletmodelNew Object1;
   WalletCardRewards({Key? key,required this.Object1}) : super(key: key);

  @override
  State<WalletCardRewards> createState() => _WalletCardRewardsState(Object1);
}

class _WalletCardRewardsState extends State<WalletCardRewards> {
  final WalletmodelNew Object1;
  TextEditingController expiryController=new TextEditingController();
  TextEditingController autoUpgradeController=new TextEditingController();
var expriybuttoncheck;
  _WalletCardRewardsState(this.Object1);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: _REWARDS(context),
    );
  }
  Future<List<ERewardsModel>> getRewardData() async {
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
        "program_id":Object1.program_id,
        "merchant_id":Object1.merchant_id,
        "member_id":Object1.member_id,


      },
    ).timeout(Duration(seconds: 30));



    if(response.statusCode == 200) {
      debugPrint("Check13"+ response.body.toString());
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);

      var newData1 = data['info'];
      var newData = newData1['info'];
      var p1 = Utils().stringSplit(newData['p1']);
      print("hii" + p1.toString());
      var p2 = Utils().stringSplit(newData['p2']);

      var p3 = Utils().stringSplit(newData['p3']);
      var p4 = Utils().stringSplit(newData['p4']);
      var p5 = Utils().stringSplit(newData['p5']);
      var p6 = Utils().stringSplit(newData['p6']);
      var p7 = Utils().stringSplit(newData['p7']);
      var p8 = Utils().stringSplit(newData['p8']);
      expriybuttoncheck = p7;


      List<String> currencySymbol = p2.split("*") ;
      List<String> yourPoints = p3.split("*") ;
      // List<String> oneYearSpending = p4.split("*") ;
      List<String> oneYearSpending = p5.split("*") ;
      List<String> accumulatedSpending = p6.split("*") ;



      List<ERewardsModel> object1 = [];
      //
      for (int i = 0; i < currencySymbol.length; i++) {
        object1.add(new ERewardsModel(
            lastUpdated: new DateTime.now().day.toString()+"-"
                +new DateTime.now().month.toString()+"-"
                +new DateTime.now().year.toString()+" "
                +DateFormat('hh:mm a').format(DateTime.now()).toString(),

          cardExpiry:Object1.expire_date ,
          yourPoints: yourPoints ,
          oneYearSpending:oneYearSpending ,
          accumulatedSpending:accumulatedSpending,
          autoUpgradeCriteria:Object1.clickinformation,
          showButton: p8

        ));
      }
      return object1;
    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<ERewardsModel>> _REWARDS(BuildContext context) {

    return FutureBuilder<List<ERewardsModel>>(

      future: getRewardData(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          final List<ERewardsModel>? posts = snapshot.data;
          if(posts!=null && posts.isNotEmpty){
            //  if(snapshot.data!.length!=0){
            return _buildPostsHome(context, posts);
          }

          else{

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(child: Text(no_card_found,style: TextStyle(color: corporateColor,fontSize: 15),)),
                SizedBox(height: 10,),
                //  Center(child: Text(merchant_instruc_for_card,style: TextStyle(color: Colors.black54,fontSize: 12),)),
              ],
            );
          }
        }

        else {
          return Center(
            child:SpinKitCircle(
              color: corporateColor,
              size: 30.0,
            ),
          );
        }
      },
    );
  }
  Widget _buildPostsHome(BuildContext context, List<ERewardsModel> posts) {


   return Column(

       children: [
       Padding(
         padding: const EdgeInsets.all(15.0),
         child: Container(
           decoration: BoxDecoration(
               border: Border.all(
                   color: lightGrey1,
                   width: 1
               )
           ),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [


                 Row(
                   children: [
                     Expanded(child: Text("Card Expiry:")),
                     Expanded(child: TextField(controller: expiryController,  decoration: InputDecoration(

                       border: InputBorder.none,
                     ),)),
                   ],
                 ),
                 SizedBox(height: 10,),
                 Row(
                   children: [
                     Expanded(child: Text("YourPoints:")),
                     expriybuttoncheck=="1"?
                     Expanded(child: Column(
                       children: [
                         Text(posts[0].yourPoints[0].toString()+" Points Earned"),
                         Text("Points expiry: end of calendar month"),
                       ],
                     )):
                     Expanded(child: Text(posts[0].yourPoints[0].toString()+" Points Earned")),

                   ],
                 ),
                 SizedBox(height: 5,),
                 Row(
                   children: [
                     Expanded(child: Text("\$ "+posts[0].oneYearSpending[0].toString()),),
                     Expanded(child: Text("\$ "+posts[0].accumulatedSpending[0].toString()),)


                   ],
                 ),
                 Row(
                   children: [
                     expriybuttoncheck!="1"?
                     Expanded(child:
                     Text("1 Year Spending")):
                     Expanded(child:
                     Text("1 Month Spending")),
                     Expanded(child: Text("Accumulated Spending")),
                   ],
                 ),

                 SizedBox(height: 10,),

                 // getRewards(),

                 SizedBox(height: 10,),
                 showPointsExpiryButton(posts[0].showButton),
                 SizedBox(height: 10,),
                 REWARDSLISTVIEW(context,posts[0].yourPoints.toString()),
                 SizedBox(height: 10,),
                 Row(
                   children: [
                     Expanded(child: Text("Auto Upgrade Criteria")),
                     Expanded(child: TextField(keyboardType: TextInputType.multiline,maxLines:null,controller: autoUpgradeController,
                       style: TextStyle(fontSize: 14),
                       decoration: InputDecoration(

                       border: InputBorder.none,
                     ),)),

                   ],
                 ),


               ],
             ),
           ),
         ),
       )
     ],
   );
  }


  Widget showPointsExpiryButton(var showButton ){
    print("show:"+showButton.toString());
    var buttonName=showButton ;
    buttonName=buttonName.toString().split(":")[1];
    if(buttonName=="yes"){
      return InkWell(onTap:(){

        showBottomDialogforExpiry();

      },child: Container(
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
            color: poketblue),
        child: Center(child:Text("POINT EXPIRY",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      ));
    }
    else{
      return Container();
    }
  }

  Future<void> showBottomDialogforExpiry()async{
    print(CARD_REWARDS_URL.toString());

    final http.Response response = await http.post(
      Uri.parse(CARD_POINTS_EXPIRY),

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
        "program_id":Object1.program_id,
        "merchant_id":Object1.merchant_id,
        "member_id":Object1.member_id,


      },
    ).timeout(Duration(seconds: 30));



    if(response.statusCode == 200) {
      debugPrint("Check145"+ response.body.toString());
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);

      var newData = data['info'];
      var p1 = Utils().stringSplit(newData['p1']);
      var p2 = Utils().stringSplit(newData['p2']);


      if(p1=="True"){
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Padding(
                    padding: EdgeInsets.only(left:20,right:20,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Point Expiry",style: TextStyle(fontWeight: FontWeight.bold),),

                        InkWell(onTap: (){Navigator.pop(context);},child: Icon(Icons.close,color: Colors.black,size: 30,),)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left:20,right:20,top: 20),
                    child: Text(p2),
                  ),
                  SizedBox(height: 10,),
                  Container(width: double.infinity,height: 1,color: grey,),
                  SizedBox(height: 10,),
                ],
              );
            }
        );
      }

      else {
        throw "Unable to retrieve posts.";
      }

    }
    else {
      throw "Unable to retrieve posts.";
    }

  }

  FutureBuilder<List<ERewardsListModel1>> REWARDSLISTVIEW(BuildContext context,var myPoint) {

    return FutureBuilder<List<ERewardsListModel1>>(

      future: getRewardListData(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          final List<ERewardsListModel1>? posts = snapshot.data;
          if(posts!=null && posts.isNotEmpty){
            //  if(snapshot.data!.length!=0){
            return _buildPostsRewards(myPoint,context,posts);
          }

          else{

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(child: Text(no_reward_vchr_found,style: TextStyle(color: corporateColor,fontSize: 15),)),
                SizedBox(height: 10,),
                //  Center(child: Text(merchant_instruc_for_card,style: TextStyle(color: Colors.black54,fontSize: 12),)),
              ],
            );
          }
        }

        else {
          return Center(
            child:SpinKitCircle(
              color: corporateColor,
              size: 30.0,
            ),
          );
        }
      },
    );
  }
  Future<List<ERewardsListModel1>> getRewardListData() async {
    print(CARD_REWARDS_URL.toString());

    final http.Response response = await http.post(
      Uri.parse(CARD_REWARDS_LIST_URL),

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
        "program_id":Object1.program_id,
        "program_type":"membercard",
        "member_id":"7973",


      },
    ).timeout(Duration(seconds: 30));




    debugPrint("RewardsListData:"+jsonDecode(response.body)['data'].toString(),wrapWidth: 1024);
    if(response.statusCode==200 && jsonDecode(response.body)["Status"]=="True")
    {
      expiryController.text=jsonDecode(response.body)['data']['Additional_Data']['cardexpiry'];
      autoUpgradeController.text=jsonDecode(response.body)['data']['Additional_Data']['upgrade_criteria'];
      debugPrint("RewardsListData2:"+jsonDecode(response.body)['data']['Rewards'].toString(),wrapWidth: 1024);
      List<dynamic> body = jsonDecode(response.body)['data']['Rewards'];
      List<ERewardsListModel1> posts1 = body.map((dynamic item) => ERewardsListModel1.fromJson(item),).toList();

      return posts1;

    }
    else {
      throw "";
    }
    //
  }

  Widget _buildPostsRewards(var myPoint,BuildContext context , List<ERewardsListModel1> posts){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {


        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            checkButtonorLock(posts[index].amt_to_purchase,myPoint,posts[index].program_id,Object1.member_id,posts[index].tier_id),
            SizedBox(width: 10,),
            Container(

              color: lightGrey2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5,),
                    Text(posts[index].amt_to_purchase,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    SizedBox(height: 2,),
                    Text("POINTS",style: TextStyle(fontSize: 13),),
                    SizedBox(height: 5,),

                  ],
                ),
              ),
            ),
            SizedBox(width: 10,),
            Container(
                color: lightGrey2,
                height: 60,
                width: 200,
                child: Center(child: Padding(
                  padding: const EdgeInsets.only(left:4,right: 4),
                  child: Text(posts[index].program_title+" - "+posts[index].amt_to_purchase,style: TextStyle(fontSize: 13),),
                ))),
          ],
        );
      },
    );
  }

  Widget checkButtonorLock(var rewardPoint ,var myPoint,var prgmId,var merchantId, var tierId){
    print("rewr:"+rewardPoint);
    print("myPo:"+myPoint);

    var myPoint1=myPoint.toString().replaceAll("[", "");
    var myPoint2=myPoint1.toString().replaceAll("]", "");

    print("myPo2:"+myPoint2);
    var mP=double.parse(myPoint2);
    var rP=double.parse(rewardPoint.toString());
    print("mp,rp"+mP.toString()+","+rP.toString());
    if(rP>=mP){
      return Container(width: 80,child: Center(child: Image.asset("assets/ic_lock.png",width: 30,height: 30,)));
    }
    else{
      return InkWell(
        onTap: (){
          AlertDialog alert = AlertDialog(

            backgroundColor: Colors.white,
            title: Text("Are you sure to redeem "+rP.toString()+" points ?",style: TextStyle(fontSize: 16),),
            // content: CircularProgressIndicator(),
            actionsAlignment: MainAxisAlignment.end,

            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context,true);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Center(child: Text("CANCEL",style: TextStyle(color:Maincolor,fontWeight: FontWeight.bold,fontSize: 14),)),
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context,true);
                      callRewardRedeemApi(prgmId,merchantId,tierId);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Center(child: Text("CONFIRM",style: TextStyle(color:Maincolor,fontWeight: FontWeight.bold,fontSize: 14),)),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              SizedBox(height: 10,)
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
        },
        child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: poketblue2
          ),
          child: Center(child: Text("Redeem",style: TextStyle(color: Colors.white),),),
        ),
      );
    }
  }

  Future<void> callRewardRedeemApi(prgmId,memberId,tierId)async{
    showLoadingView(context);
    final http.Response response = await http.post(
      Uri.parse(POKETIT_URL),

      body: {
    "consumer_id": CommonUtils.consumerID.toString(),
    "country_index": "191",
    "program_id": prgmId,

    "software_version": CommonUtils.softwareVersion,
    "os_version": CommonUtils.osVersion,
    "phone_model": CommonUtils.deviceModel,
    'consumer_application_type': CommonUtils.consumerApplicationType,
    'consumer_language_id': CommonUtils.consumerLanguageId,
    "device_type": CommonUtils.deviceType,
    "device_token_id": CommonUtils.deviceTokenID,
    "upgrade_card": "1",
    "tier_id": tierId,
    "action_event": "3",
    "join_method": "13",
    "download_id":"0",
    "pns_id":"0",
    "member_id":memberId,


      },
    ).timeout(Duration(seconds: 30));
    Navigator.pop(context);
    if (response.statusCode == 200) {
      debugPrint("RewardRedeemResponse:"+response.body.toString());

      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);

      var newData = data['info'];
      var status = Utils().stringSplit(newData['p1']);
      /* var success = Utils().stringSplit2(newData['p9']) +
          "voucher redeemption is successful";*/
      var Message = Utils().stringSplit(newData['p14']);
      // var Message="";
      if (status != "False") {
        Toast.show("Successfully Redeemed", duration: Toast.lengthLong, gravity: Toast.bottom);

        CommonUtils.NAVIGATE_PATH = "walletPage";
        //  Navigator.pop(context,true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConsumerTab(),
          ),
        );

      }
      else {
        if (Platform.isAndroid) {
          showAlertDialog_oneBtnWitDismiss(context, "Alert", Message);
        }
        if (Platform.isIOS) {
          var alert = ShowNativeDialogue(context, "Alert", Message);

          alert.whenComplete(() => Navigator.pop(context));
        }
      }
    }

  }


}
