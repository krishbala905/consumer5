import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:consumer5/Others/Urls.dart';
import 'package:consumer5/UI/Browse/CardPurchaseFragment.dart';
import 'package:consumer5/UI/Browse/Detail%20Page/CardsDetailFragment.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/NativeAlertDialog.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import '../ConsumerTab.dart';
import '../More/Profile.dart';
import 'Model/ECardModel.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
class CardFragment extends StatefulWidget {
  const CardFragment({Key? key}) : super(key: key);

  @override
  State<CardFragment> createState() => _CardFragmentState();
}

class _CardFragmentState extends State<CardFragment> {
  late Future<List<ECardModel>> myfuture;
  bool showData=false;

  void initState() {
    // TODO: implement initState
    myfuture = getEcardData();
    // ConsumerTab().getInboxUnreadMessageCount();

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: _ECard(context),
          ),
        ));
  }
  Future<List<ECardModel>> getEcardData() async {
    print(BROWSEPROGRAMURL.toString());
    print("bhar"+CommonUtils.Serachkey.toString());
    final http.Response response = await http.post(
      Uri.parse(BROWSEPROGRAMURL),

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
    "program_type":"1",
    "country_index":"191",
    "sort_type":"1",
    "page_number":"1",
    "search_mode":"1",
    "keyword":CommonUtils.Serachkey.toString(),
    "latitude":"0.0",
    "longitude":"0.0"
        /*"consumer_id": CommonUtils.consumerID.toString(),
       //  "order_data": "newest",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':"18",
        'consumer_language_id':CommonUtils.APPLICATIONLANGUAGEID,
         "program_type":"1",
        "country_index":"191",
        // "consumer_id":"191",
        "sort_type":"1",
        "page_number":"1",
        "search_mode":"1",
        "keyword":CommonUtils.Serachkey.toString(),
        "latitude":"0.0",
        "longitude":"0.0"*/
      },
    ).timeout(Duration(seconds: 30));


    debugPrint("Check13"+ response.body.toString());
    if(response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      //  print("hii");
      var newData = data['info'];
      var p1 = Utils().stringSplit(newData['p1']);
      print("hii" + p1.toString());
      var p2 = Utils().stringSplit(newData['p2']);

      var p3 = Utils().stringSplit(newData['p3']);
      var p4 = Utils().stringSplit(newData['p4']);
      var p5 = Utils().stringSplit(newData['p5']);
      var p6 = Utils().stringSplit(newData['p6']);
      var p7 = Utils().stringSplit(newData['p7']);
      var p8 = Utils().stringSplit(newData['p8']);
      var p9 = Utils().stringSplit(newData['p9']);
      var p10 = Utils().stringSplit(newData['p10']);
      var p11 = Utils().stringSplit(newData['p11']);
      var p12 = Utils().stringSplit(newData['p12']);
      var p13 = Utils().stringSplit(newData['p13']);
      var p14 = Utils().stringSplit(newData['p14']);
      var p15 = Utils().stringSplit(newData['p15']);
      var p16 = Utils().stringSplit(newData['p16']);
      var p17 = Utils().stringSplit(newData['p17']);
      var p18 = Utils().stringSplit(newData['p18']);
      // var p19 = Utils().stringSplit(newData['p19']);
       var p20 = Utils().stringSplit(newData['p20']);
      List<String> programIDlist = p1.split("*") ;
      List<String> programTypelist = p2.split("*") ;
      List<String> programNamelist = p3.split("*") ;
      List<String> bannerImagelist = p4.split("*") ;

      List<String> programRewardslist = p5.split("*") ;
      List<String> outletIDlist = p6.split("*") ;
      List<String> outletNamelist = p7.split("*") ;
      List<String> distancelist = p8.split("*") ;
      List<String> originalPricelist = p9.split("*") ;
      List<String> currentPricelist = p10.split("*") ;
      List<String> likeCountlist = p11.split("*") ;
      List<String> likeStatuslist = p12.split("*") ;
      List<String> rewardsIDlist = p13.split("*") ;
      List<String> merchantIDlist = p14.split("*") ;
      List<String> merchantNamelist = p15.split("*") ;
      List<String> currencylist = p16.split("*") ;
      List<String> programImagerURLS = p17.split("*") ;
      List<String> emailIds = p18.split("*") ;
      // List<String> phoneNumbers = p19.split("*") ;
       List<String> downloadflag = p20.split(",") ;
     // var downloadflag = p20.split(",").last;
      print("hei"+downloadflag.toString());
      print("hei"+downloadflag.toString());

      List<ECardModel> object1 = [];

      for (int i = 0; i < programIDlist.length; i++) {
        object1.add(new ECardModel(
          programIDlist : programIDlist,
          programTypelist  : programTypelist,
          programNamelist  : programNamelist,
          bannerImagelist  : bannerImagelist,
          programRewardslist : programRewardslist,
          outletIDlist : outletIDlist,
          outletNamelist : outletNamelist,
          distancelist  : distancelist,
          originalPricelist  : originalPricelist,
          currentPricelist  : currentPricelist,
          likeCountlist  : likeCountlist,
          likeStatuslist  : likeStatuslist,
          rewardsIDlist  : rewardsIDlist,
          merchantIDlist : merchantIDlist,
          merchantNamelist : merchantNamelist ,
          currencylist : currencylist,
          programImagerURLS  : programImagerURLS,
          emailIds  : emailIds ,
          phoneNumbers :"",
            downloadflag: downloadflag,
        ));
      }
      return object1;
    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<ECardModel>> _ECard(BuildContext context) {

    return FutureBuilder<List<ECardModel>>(

      future: getEcardData(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          final List<ECardModel>? posts = snapshot.data;
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
  Widget _buildPostsHome(BuildContext context, List<ECardModel> posts) {


    return ListView.builder(

      reverse: true,
      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {

        return InkWell(
          onTap: () async {
            print("check"+posts[index].downloadflag[index]);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CardsDetailFragment(Programid: posts.first.programIDlist[index],
              MerchantId:posts.first.merchantIDlist[index],
              CurrentPrice:posts.first.currentPricelist[index],OriginalPrice: posts.first.originalPricelist[index],
                downloadflag: posts.first.downloadflag[index],programtype: posts.first.programTypelist[index],outletid: posts.first.outletIDlist[index],
                currencylist: posts.first.currencylist[index],
               programimage: posts.first.programImagerURLS[index], programname:posts.first.programNamelist[index]
            ,emailid: posts.first.emailIds[index], phoneno: "1212121212")));


          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.black12)
              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(posts[index].bannerImagelist[index]),
                  Padding(padding: EdgeInsets.only(top: 10,left: 10),
                    child: Text(posts[index].programNamelist[index].toString(),),
                  ),

                  Padding(padding: EdgeInsets.only(top: 10,left: 10),
                    child: Text(posts[index].programRewardslist[index].toString(),style: TextStyle(
                      color: Colors.grey
                    ),),
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10),
                        child: Image.asset("assets/ic_mappin.png",width: 8.0,)
                      ),
                      Text(posts[index].distancelist[index].toString(),style: TextStyle(
                          color: Colors.grey
                      ),),
                      Text(posts[index].merchantNamelist[index].toString(),style: TextStyle(
                          color: Colors.grey
                      ),),
                    ],
                  ),
                  GrayLine(),
                  setAmountWidget(posts[index].originalPricelist[index], posts[index].currencylist[index], posts[index].currentPricelist[index],posts[index].programImagerURLS[index], posts[index].programNamelist[index],  posts[index].programIDlist[index],
                    posts[index].programTypelist[index],
                    posts[index].outletIDlist[index],posts[index].downloadflag[index]),
                  SizedBox(
                    height: 10,
                  )
                ],

              ),
            ),
          ),
        );
      },
    );
  }

  Widget setAmountWidget(priceList,currencyList,upgradeButton,cardImgurl,programName,
      programID,programType,outletID,downloadflag){
    print("check"+downloadflag);
      if(priceList=="Free"){
      return Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text(priceList,style: TextStyle(color: poketpurple,fontSize: 15),),
            SizedBox(width: 20,),
            upgradeButton=="Free"&&downloadflag=="1" ?InkWell(
                onTap: (){},
                child: Container(
                    height: 30,
                    width: 100,
               decoration: BoxDecoration(
               border: Border.all(color: lightGrey),
              borderRadius: BorderRadius.circular(25),
            )
              ,child: Center(child: Text("Got",style: TextStyle(color: lightGrey ,fontSize: 13),)))):
           //  if(upgradeButton=="Free"&& downloadflag=="0")
              InkWell(
                  onTap: () {
                    //need to call api
                    showAlertForGetit(programID,programType,outletID);
                  },
                  child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: poketblue2,
                        border: Border.all(color: poketblue2),
                        borderRadius: BorderRadius.circular(25),
                      )
                      ,
                      child: Center(child: Text("Get",
                        style: TextStyle(color: Colors.white, fontSize: 13),)))),
            SizedBox(width: 20,),
          ],
        ),
      );
    }
    else{
      return Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text(currencyList+"  "+priceList,style: TextStyle(color: poketpurple,fontSize: 15),),
            SizedBox(width: 20,),
            upgradeButton=="UPGRADE" && downloadflag=="0"?InkWell(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardPurchaseFragment(
                      cardImgurl,programName,programID,programType,outletID,currencyList+"  "+priceList ),));
                },
                child: Container(
                  height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: poketblue2
                    )
                    ,child: Center(child: Text("Upgrade",style: TextStyle(color: Colors.white,fontSize: 12),)))):
            InkWell(
                onTap: (){},
                child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: lightGrey),
                      borderRadius: BorderRadius.circular(25),
                    )
                    ,child: Center(child: Text("Upgraded",style: TextStyle(color: lightGrey ,fontSize: 13),)))),
            SizedBox(width: 20,),


          ],
        ),
      );
    }
  }
  void showAlertForGetit(var programId,var programtype,var outletid) {
    AlertDialog alert1 = AlertDialog(
      backgroundColor: Colors.white,
      // content: CircularProgressIndicator(),
      content:
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
            "By accepting this card, you agree to join MBM Wheelpower loyalty program and share your profile information to them.",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black45)),
      ),

      actions: [
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
              onTap: () async {
                Navigator.pop(context, true);
                bool internetcheck = await initTimer();
                print("bharathi" + internetcheck.toString());
                if (internetcheck == true) {
                  _DownloadVoucher(programId,programtype,outletid);
                } else {
                  showAlertDialog_oneBtn(this.context, "Network",
                      "No Internet Connection. Please turn on Internet Connection");
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
                        "ACCEPT",
                        style: TextStyle(color: Maincolor),
                      )),
                ),
              ),
            ),
          ],
        )
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert1;
      },
    );
  }

  Future<bool> initTimer() async {
    bool check = true;
    if (await checkinternet()) {
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");
        check = true;
        //callSignoutAPi();

      });
    } else {
      check = false;
    }
    print("bharathi1" + check.toString());
    return check;
  }

  Future<bool> checkinternet() async {
    var connectivityresult = await(Connectivity().checkConnectivity());
    if (connectivityresult == ConnectivityResult.none) {
      print("not connected");
      return false;
    }
    else {
      return true;
    }
  }

  _DownloadVoucher(var programId,var programtype,var outletid) async {
    print(programId.toString()+programtype.toString()+outletid.toString());
    print(POKETIT_URL);
    final http.Response response =
    await http.post(Uri.parse(POKETIT_URL), body: {
      "consumer_id": CommonUtils.consumerID.toString(),
      "country_index": "191",
      "program_id": programId.toString(),
      "action_event": programtype.toString(),
      "software_version": CommonUtils.softwareVersion,
      "os_version": CommonUtils.osVersion,
      "phone_model": CommonUtils.deviceModel,
      'consumer_application_type': CommonUtils.consumerApplicationType,
      'consumer_language_id': CommonUtils.consumerLanguageId,
      "device_type": CommonUtils.deviceType,
      "device_token_id": CommonUtils.deviceTokenID,
      "upgrade_card": "1",
      "join_method": "16",
      "download_id":"0",
      "outlet_id":outletid.toString(),
      "pns_id":"0"
      // "member_id":memberid,
    }).timeout(Duration(seconds: 30));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      debugPrint(response.body);

      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      var status = Utils().stringSplit(newData['p1']);
      /* var success = Utils().stringSplit2(newData['p9']) +
          "voucher redeemption is successful";*/
      var Message = Utils().stringSplit(newData['p14']);
      if (status != "False") {
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

// children: [
//
// SizedBox(height: 10,),
// Padding(
// padding: const EdgeInsets.only(left:15.0,right: 15),
// child:  ClipRRect(
//
// borderRadius: BorderRadius.circular(10.0),
//
// child:Stack(children:[
// //Image.network(posts[index].programImagerURLS[index],width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
// Image.network(posts[index].bannerImagelist[index],
// //width: MediaQuery.of(context).size.width,fit: BoxFit.fill,
// ),
// Positioned(
// bottom: 0,
//
// child: Container(
// width: MediaQuery.of(context).size.width,
// height: 140,
// color: Colors.white,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SizedBox(height: 15,),
// Padding(
// padding: const EdgeInsets.only(left:15.0,right: 15),
// child: Text(posts[index].programNamelist[index].toString(),style: TextStyle(fontSize: 15),),
// ),
// SizedBox(height: 15,),
// Padding(
// padding: const EdgeInsets.only(left:15.0,right: 15),
// child: Text(posts[index].programRewardslist[index].toString(),style: TextStyle(fontSize: 15),),
// ),
// SizedBox(height: 15,),
// Padding(
// padding: const EdgeInsets.only(left:10.0,right: 10),
// child: Container(height: 1,color: Colors.black12,),
// ),
// SizedBox(height: 15,),
//
// setAmountWidget(
// posts[index].originalPricelist[index],
// posts[index].currencylist[index],
// posts[index].currentPricelist[index]
// ),
// ],
// ),
// ),
// ),
// ]
//
//
// ),
//
// ),
// ),
//
// SizedBox(height: 10,),
// Padding(
// padding: const EdgeInsets.only(left:15,right: 15),
// child: Container(height: 1,color: Colors.black12,),
// ),
// ],
