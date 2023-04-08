import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:consumer5/UI/Browse/Detail%20Page/BrowseVoucherDetailFragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xml2json/xml2json.dart';

import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/NativeAlertDialog.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import '../ConsumerTab.dart';
import '../More/Profile.dart';
import 'Detail Page/CardsDetailFragment.dart';
import 'Model/ECardModel.dart';
import 'package:http/http.dart' as http;

class VoucherFragment extends StatefulWidget {
  const VoucherFragment({Key? key}) : super(key: key);

  @override
  State<VoucherFragment> createState() => _VoucherFragmentState();
}

class _VoucherFragmentState extends State<VoucherFragment> {
  @override
  void initState() {
    //getEcardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _ECard(context),
          ),
        ));
  }

  Future<List<ECardModel>> getEcardData() async {
    print(BROWSEPROGRAMURL.toString());

    final http.Response response = await http.post(
      Uri.parse(BROWSEPROGRAMURL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        //  "order_data": "newest",
        "cma_timestamps": Utils().getTimeStamp(),
        "time_zone": Utils().getTimeZone(),
        "software_version": CommonUtils.softwareVersion,
        "os_version": CommonUtils.osVersion,
        "phone_model": CommonUtils.deviceModel,
        "device_type": CommonUtils.deviceType,
        'consumer_application_type': "18",
        'consumer_language_id': CommonUtils.APPLICATIONLANGUAGEID,
        "program_type": "2",
        "country_index": "191",
       //  "consumer_id": "191",
        "sort_type": "1",
        "page_number": "1",
        "search_mode":"1",
        "keyword":CommonUtils.Serachkey.toString(),
        "latitude": "0.0",
        "longitude": "0.0"
      },
    ).timeout(Duration(seconds: 30));


    debugPrint("Check13" + response.body.toString());
    if (response.statusCode == 200) {
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
      var p19 = Utils().stringSplit(newData['p19']);
      var p20 = Utils().stringSplit(newData['p20']);
      List<String> programIDlist = p1.split("*");
      List<String> programTypelist = p2.split("*");
      List<String> programNamelist = p3.split("*");
      List<String> bannerImagelist = p4.split("*");

      List<String> programRewardslist = p5.split("*");
      List<String> outletIDlist = p6.split("*");
      List<String> outletNamelist = p7.split("*");
      List<String> distancelist = p8.split("*");
      List<String> originalPricelist = p9.split("*");
      List<String> currentPricelist = p10.split("*");
      List<String> likeCountlist = p11.split("*");
      List<String> likeStatuslist = p12.split("*");
      List<String> rewardsIDlist = p13.split("*");
      List<String> merchantIDlist = p14.split("*");
      List<String> merchantNamelist = p15.split("*");
      List<String> currencylist = p16.split("*");
      List<String> programImagerURLS = p17.split("*");
      List<String> emailIds = p18.split("*");
      List<String> phoneNumbers = p19.split("*");
List<String> downloadflag = p20.split(",");
      List<ECardModel> object1 = [];

      for (int i = 0; i < programIDlist.length; i++) {
        object1.add(new ECardModel(
          programIDlist: programIDlist,
          programTypelist: programTypelist,
          programNamelist: programNamelist,
          bannerImagelist: bannerImagelist,
          programRewardslist: programRewardslist,
          outletIDlist: outletIDlist,
          outletNamelist: outletNamelist,
          distancelist: distancelist,
          originalPricelist: originalPricelist,
          currentPricelist: currentPricelist,
          likeCountlist: likeCountlist,
          likeStatuslist: likeStatuslist,
          rewardsIDlist: rewardsIDlist,
          merchantIDlist: merchantIDlist,
          merchantNamelist: merchantNamelist,
          currencylist: currencylist,
          programImagerURLS: programImagerURLS,
          emailIds: emailIds,
          phoneNumbers: phoneNumbers,
downloadflag: downloadflag
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
          if (posts != null && posts.isNotEmpty) {
            //  if(snapshot.data!.length!=0){
            return _buildPostsHome(context, posts);
          }

          else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(child: Text(no_vchr_found,
                  style: TextStyle(color: corporateColor, fontSize: 15),)),
                SizedBox(height: 10,),
                //  Center(child: Text(merchant_instruc_for_card,style: TextStyle(color: Colors.black54,fontSize: 12),)),
              ],
            );
          }
        }

        else {
          return Center(
            child: SpinKitCircle(
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
            print("bhar"+posts.first.bannerImagelist[index].toString());
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                BrowseVoucherDetailFragment(
                    Programid: posts.first.programIDlist[index],
                    MerchantId: posts.first.merchantIDlist[index],
                    CurrentPrice: posts.first.currentPricelist[index],
                    OriginalPrice: posts.first.originalPricelist[index],
                    Voucherimage: posts.first.bannerImagelist[index],
                programtype: posts.first.programTypelist[index],outletid: posts.first.outletIDlist[index],
                emailid: posts.first.emailIds[index],phoneno:posts.first.phoneNumbers[index],
                voucherimage: posts.first.programImagerURLS[index],
                programname: posts.first.programNamelist[index])));
            /* if(posts[index].program_type=="customcard"){
              bool isconnected = await initTimer();
              if(isconnected == true){
                Navigator.push(context, MaterialPageRoute(builder:(context) => CustomCardEditFragment(posts[index]),));
              }
              else{
                Fluttertoast.showToast(
                    msg: "No Internet Connection. Please turn on Internet Connection",
                    toastLength: Toast.LENGTH_LONG);
                // showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
              }
            }
            else{
              bool isconnected = await initTimer();
              if(isconnected == true){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ECardPrimaryFragment(

                  posts[index].program_title,
                  posts[index].program_id, posts[index].program_type,
                  posts[index].program_title, posts[index].img_url,posts[index].expire_date,
                  posts[index].balance,posts[index].sub_type,posts[index].member_id,
                  posts[index].merchant_id,posts[index].merchant_name,
                ),

                ));
                //Navigator.push(context, MaterialPageRoute(builder:(context) => CustomCardEditFragment(posts[index]),));
              }
              else{
                Fluttertoast.showToast(
                    msg: "No Internet Connection. Please turn on Internet Connection",
                    toastLength: Toast.LENGTH_LONG);
                // showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
              }

            }*/

          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12)
              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(posts[index].programImagerURLS[index]),
                  Padding(padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      posts[index].programNamelist[index].toString(),),
                  ),
                  SizedBox(height: 5.0,),
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
                  setAmountWidget(posts[index].originalPricelist[index],
                      posts[index].currencylist[index],
                      posts[index].currentPricelist[index],posts[index].programIDlist[index],posts[index].programTypelist[index],posts[index].outletIDlist[index]),
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

  Widget setAmountWidget(priceList, currencyList, upgradeButton,programId,programtype,outletid) {
    if (priceList == "Free") {
      return Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              priceList, style: TextStyle(color: poketpurple, fontSize: 15),),
            SizedBox(width: 20,),
            if(upgradeButton == "Free" )InkWell(
                onTap: () {
                  //need to call api
                  showAlertForGetit(programId,programtype,outletid);
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
    else {
      return Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              priceList, style: TextStyle(color: poketpurple, fontSize: 15),),
            SizedBox(width: 20,),
           /* if(upgradeButton == "UPGRADE" )InkWell(
                onTap: () {},
                child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: poketblue
                    )
                    ,
                    child: Center(child: Text("UPGRADE",
                      style: TextStyle(color: Colors.white, fontSize: 12),)))),*/
            if (upgradeButton == "Lock") InkWell(
                onTap: () {
                 //  showAlertForGetit(programId,programtype,outletid);
                },
                child: Icon(CupertinoIcons.lock, color: Colors.grey,)),


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
      //   if (Platform.isAndroid) {
        //  showAlertDialog_oneBtnWitDismissw(context, "Alert", success);
       // }
        /*if (Platform.isIOS) {
          var alert = ShowNativeDialogue(context, "Alert", success);

          *//*CommonUtils.NAVIGATE_PATH = "walletPage";
          alert.whenComplete(() =>


              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ConsumerTab(),)));*//*
        }*/
      }
      else {
        if (Platform.isAndroid) {
          showAlertDialog_oneBtnWitDismissback(context, "Alert", Message);
        }
        if (Platform.isIOS) {
          var alert = ShowNativeDialogue(context, "Alert", Message);

          alert.whenComplete(() => Navigator.pop(context));
        }
      }
    }
  }
  void showAlertDialog_oneBtnWitDismissback(BuildContext context,String tittle,String message)
  {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message,style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: (){Navigator.pop(context,true);


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

       // Navigator.pop(context);
      } else {
        // user pressed No button
      }
    });

  }
}
