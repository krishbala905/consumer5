import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:consumer5/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:consumer5/res/Colors.dart';

import 'package:http/http.dart' as http;
import '../../../Others/AlertDialogUtil.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../ConsumerTab.dart';
import '../CardFragments/WalletCardQRCode.dart';
import '../CardFragments/WalletCardRewards.dart';
import 'package:xml2json/xml2json.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:path_provider/path_provider.dart';

import '../Models/Card/WalletmodelNew.dart';
import 'WalletCardDetailFragment.dart';

class WalletThirdScreen extends StatefulWidget {
  // final WalletViewmodel object1;
  final WalletmodelNew object1;
   WalletThirdScreen({Key? key,required this.object1}) : super(key: key);

  @override
  State<WalletThirdScreen> createState() => _WalletThirdScreenState(this.object1);
}

class _WalletThirdScreenState extends State<WalletThirdScreen> with SingleTickerProviderStateMixin  {
  static const MethodChannel _channel = const MethodChannel(
      'social_share_plugin');
  late WalletmodelNew object1;
  _WalletThirdScreenState(this.object1);
  late TabController _tabController;
  var emailpic;
  List<String> attachments = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
   // imageshare();
  }
  imageshare()async{
    http.Response response = await http.get(object1.img_url);
    final directory = await getTemporaryDirectory();
    final path = directory.path;
    final file = File('$path/image.png');
    file.writeAsBytes(response.bodyBytes);
    emailpic = ['$path/image.png'];
  }

  void dispose(){
    super.dispose();
    _tabController.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset('assets/ic_action_bar.png'),
        ),*/
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title:  Text(appName1),
        backgroundColor: Maincolor,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WalletCardQRCode(Object1: object1,),
          WalletCardRewards(Object1: object1,),
          // WalletDetailFragment(Object1: object1,),
          WalletCardDetailFragment(object1,),
          /*WalletCardShareAlert(object1,),
          WalletCardDeleteAlert(object1,),*/
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                indicatorColor: poketPurple,
                labelColor: poketPurple,
                tabs: [

                  Tab(child: Container(
                    width: 50,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/ic_walletqrcode_normal.png",width: 40,height: 30,),
                        SizedBox(height: 1,),
                        Text("QR Code",style: TextStyle(fontSize: 9.0),),
                      ],
                    ),
                  ),),

                  Tab(child: Container(
                    width: 50,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/ic_walletrewards_normal.png",width: 40,height: 30,),
                        SizedBox(height: 1,),
                        Text("Rewards",style: TextStyle(fontSize: 9.0),),
                      ],
                    ),
                  ),),

                  Tab(child: Container(
                    width: 50,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/ic_walletdetails_normal.png",width: 40,height: 30,),
                        SizedBox(height: 1,),
                        Text("Details",style: TextStyle(fontSize: 9.0),),
                      ],
                    ),
                  ),),
                  /*Tab(child: Container(
                    width: 50,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/ic_walletshare_normal.png",width: 40,height: 30,),
                        SizedBox(height: 1,),
                        Text("Share",style: TextStyle(fontSize: 10.0),),
                      ],
                    ),
                  ),),
                  Tab(child: Container(
                    width: 50,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/ic_walletdelete_normal.png",width: 40,height: 30,),
                        SizedBox(height: 1,),
                        Text("Delete",style: TextStyle(fontSize: 10.0),),
                      ],
                    ),
                  ),),*/


                ],
              ),
            ),
            Expanded(flex:1,child: InkWell(
              onTap: (){
                print("check");
                showAlertDialog_share(context);
              },
              child: Container(
                width: 50,
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/ic_walletshare_normal.png",width: 40,height: 30,),
                    SizedBox(height: 1,),
                    Text("Share",style: TextStyle(fontSize: 9.0),),
                  ],
                ),
              ),
            ),),
            Expanded(flex:1,child: InkWell(
              onTap: (){
                showAlertDialog_delete(context,object1);
              },
              child: Container(
                width: 50,
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/ic_walletdelete_normal.png",width: 40,height: 30,),
                    SizedBox(height: 1,),
                    Text("Delete",style: TextStyle(fontSize: 9.0),),
                  ],
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
  /*Widget WalletCardDeleteAlert(WalletViewmodel Object1){
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.end,
      content: Text("Are you sure want to delete this?"),
      actions: [
        InkWell(onTap:(){Navigator.pop(context);},child: Text("NO",style: TextStyle(color: corporateColor),),),
        SizedBox(width: 20,),
        InkWell(onTap:(){

        },child: Text("YES",style: TextStyle(color: corporateColor),),),
        SizedBox(width: 20,),
      ],
    );
  }*/
  void showAlertDialog_share(BuildContext context)
  {
    AlertDialog alert = AlertDialog(
      alignment: AlignmentDirectional.bottomCenter,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10.0,bottom: 10.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white
                ),
                child:Column(
                  children: [
                    Center(child: Text("How would you like to share ?")),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap:(){
                              Navigator.pop(context, true);
                              // _textMe();
                              if(Platform.isAndroid){
                                _launchSMS();}
                              else{
                                _launchSms();
                              }
                            },
                            child: Image.asset("assets/ic_share_messages.png",width: 65,)),
                        SizedBox(width: 10,),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context, true);
                              shareEmailFunction();
                            },
                            child: Image.asset("assets/ic_share_email.png",width: 65,)),
                        SizedBox(width: 10,),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                              shareToFeedFacebookLink(url: "https://www.consumer5.com.sg/",quote: "Hey there, I have the below mobile card/voucher from MBM Wheelpower Rewards. You can find MBM Wheelpower Rewards on App Store and Google Play. You can also visit their store.  Check them out today!");
                              shareToFeedFacebookLink(url: "https://poket.com/app/");
                            },
                            child: Image.asset("assets/ic_share_facebook.png",width: 65,)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Messages",),
                        SizedBox(width: 10,),
                        Text("Email"),
                        SizedBox(width: 10,),
                        Text("Facebook"),
                      ],),
                  ],
                )
            ),
          ),
          Container(height: 25,color: Colors.transparent,),
          Padding(
            padding: const EdgeInsets.only(left:15.0,right: 15.0,bottom: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white
              ),
              child: InkWell(
                onTap: (){Navigator.pop(context);},
                child: Center(
                  child: Text("Cancel",style: TextStyle(color: corporateColor),),
                ),
              ),
            ),
          )
        ],
      ),
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
  void showAlertDialog_delete(BuildContext context,WalletmodelNew Object1)
  {
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.end,
      content: Text("Are you sure want to delete this?"),
      actions: [
        InkWell(onTap:(){Navigator.pop(context);},child: Text("NO",style: TextStyle(color: corporateColor),),),
        SizedBox(width: 20,),
        InkWell(onTap:() async{
          Navigator.pop(context, true);
          bool internetcheck = await initTimer();
          print("bharathi"+internetcheck.toString());
          if(internetcheck==true){
            calldeleteapi(object1);
          }else{
            showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
          }
        },child: Text("YES",style: TextStyle(color: corporateColor),),),
        SizedBox(width: 30,),
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
  Future<bool> initTimer() async{
    bool check = true;
    if(await checkinternet()){
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");
        check = true;
        //callSignoutAPi();

      });
    }else{
      check = false;
    }
    print("bharathi1"+check.toString());
    return check;
  }

  Future<bool> checkinternet()async{
    var connectivityresult = await(Connectivity().checkConnectivity());
    if(connectivityresult == ConnectivityResult.none){
      print("not connected");
      return false;
    }
    else{
      return true;
    }
  }
  Future<void> calldeleteapi(WalletmodelNew object1) async {


    final http.Response response = await http.post(
      Uri.parse(DELETEPROGRAM_URL),

      body: {
        "consumer_id": CommonUtils.consumerID,
        "program_id":object1.program_id.toString(),
        "member_idorserial_no":object1.member_id.toString(),
        "expire_date":object1.expire_date.toString(),
        "purge_mode":"1",
        "country_index":"191"

      },
    ).timeout(Duration(seconds: 30));
    print("check2"+response.body.toString());
    print("dhgjk"+CommonUtils.consumerID.toString());
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = json.decode(jsonstring);
    print(data);
    var data2 = data['info']['info'];
    var status = Utils().stringSplit(data2['p1']);
    if(status=="True"){


      CommonUtils.NAVIGATE_PATH = CommonUtils.walletPage;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ConsumerTab()));
    }

  }
  _launchSMS() async{
    //const uri = 'sms:?body= Hey there,I am using this Dragon-i Restaurants App. I know you will like it. You can search for Dragon-i Restaurants on App Store and Google Play''
    var smsUri = Uri.parse('sms:?body= Hey there, I have the below mobile card/voucher from MBM Wheelpower Rewards. You can find MBM Wheelpower Rewards on App Store and Google Play. You can also visit their store.  Check them out today!');
    try {
      print(smsUri.toString());
      if (await canLaunchUrl(
        smsUri,
      )) {
        await launchUrl(smsUri);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text(some_err_occured),
        ),
      );
    }
  }
  _launchSms() async {
    try {
      if (Platform.isAndroid) {
        String uri = 'sms:body=${Uri.encodeComponent("Hey there, I redeemed an e- voucher via the Cathay Lifestyle App. You’ll like it, download it now!")}';
        await launchUrl(Uri.parse(uri));
      } else if (Platform.isIOS) {
        String uri = 'sms:&body=${Uri.encodeComponent("Hey there, I have the below mobile card/voucher from MBM Wheelpower Rewards. You can find MBM Wheelpower Rewards on App Store and Google Play. You can also visit their store.  Check them out today!")}';
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some error occurred. Please try again!'),
        ),
      );
    }
  }
  shareEmailFunction() async{
    final Email email = Email(
      subject: email_subject,
      isHTML: false,
      body: email_body,
      attachmentPaths: emailpic,
    );

    await FlutterEmailSender.send(email);
  }
  Future<dynamic> shareToFeedFacebookLink({String? quote, required String url, OnSuccessHandler? onSuccess, OnCancelHandler? onCancel, OnErrorHandler? onError,}) async {
    print("hii");
    _channel.setMethodCallHandler((call) {
      switch (call.method) {
        case "onSuccess":
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(thank_you_sharing,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,));
          return onSuccess != null ? onSuccess(call.arguments) : Future.value();
        case "onCancel":
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cancelled,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,));
          return onCancel != null ? onCancel() : Future.value();
        case "onError":
          return onError != null ? onError(call.arguments) : Future.value();
        default:
          throw UnsupportedError("Unknown method called");
      }
    });
    return _channel.invokeMethod('shareToFeedFacebookLink', <String, dynamic>{
      'quote': quote,
      'url': url,
    });
  }
}
