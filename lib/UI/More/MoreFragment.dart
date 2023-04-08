import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:consumer5/UI/More/History.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonBrowser.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../SplashScreen.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'AccountDeletion.dart';
import 'ChangePassword.dart';
import 'Expiryreminder.dart';
import 'Profile.dart';
class MoreFragment extends StatefulWidget {
  const MoreFragment({Key? key}) : super(key: key);

  @override
  State<MoreFragment> createState() => _MoreFragmentState();
}

class _MoreFragmentState extends State<MoreFragment> {
  var BaseUrl = "https://cathaydev.poket.com/cathay/"; //need to change
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset('assets/ic_applogo.png'),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text("More"),
          backgroundColor: Maincolor,),
      body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                  onTap: ()async {
                    bool isconnected = await initTimer();
                    if(isconnected == true){
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) => ProfileFragment("Profile"),));
                    }
                    else{
                      showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                    }

                  },
                  child: MorePageWidet(Assetname: "assets/ic_digitalform.png", Title: profile)),
              InkWell(
                  onTap: () async {
                    bool isconnected = await initTimer();
                    if(isconnected == true){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => History(),));
                    }
                    else{
                      showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                    }

                  },
                  child: MorePageWidet(Assetname: "assets/ic_historylog.png", Title: historylog)),
              InkWell(
                  onTap: () async {
                    bool isconnected = await initTimer();
                    if(isconnected == true){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChangePassword(),));
                    }
                    else{
                      showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                    }

                  },
                  child: MorePageWidet(Assetname: "assets/ic_changepassword.png", Title: change_password)),
              InkWell(
                  onTap: () async {
                    bool isconnected = await initTimer();
                    if(isconnected == true){
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) => Expiryreminder(),));
                    }
                    else{
                      showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                    }

                  },
                  child: MorePageWidet(Assetname: "assets/ic_expiryreminder.png", Title: Expiry_reminder_txt)),

              InkWell(
                onTap: (){
                  _launchEmail();
                },
                child: MorePageWidet(Assetname: "assets/ic_feedback.png", Title: feedback),),
              InkWell(
                  onTap: (){
                    showContactUSPopup(context);
                  },
                  child: MorePageWidet(Assetname: "assets/ic_tellfriend.png", Title: tell_your_friends)),
              InkWell(
                  onTap: () async {
                    bool isconnected = await initTimer();
                    if(isconnected == true){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CommonBrowser(ABOUTUS_URL,"About Us"),));
                    }
                    else{
                      showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                    }

                  },

                  child: MorePageWidet(Assetname: "assets/ic_aboutus.png", Title: about_us)),
              InkWell(
                  onTap: () async {
                    bool isconnected = await initTimer();
                    if(isconnected == true){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CommonBrowser(PRIVACY_URL,"Privacy Policy"),));
                    }
                    else{
                      showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                    }

                  },
                  child: MorePageWidet(Assetname: "assets/ic_privacy.png", Title: privacypolicy)),
              InkWell(
                  onTap: () async {
                    bool isconnected = await initTimer();
                    if(isconnected == true){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CommonBrowser(TERMS_AND_CONDITION_URL,"Terms & Conditions"),));
                    }
                    else{
                      showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                    }

                  },
                  child: MorePageWidet(Assetname: "assets/ic_termncondition.png", Title:termsandconditions)),
              InkWell(
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context) => AccountDeletion()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border:Border(
                            bottom: BorderSide(width: 0.2,color: Colors.grey)
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,

                            child:Image.asset("assets/remove-user.png",width: 20,height: 20,color: Colors.grey, ),
                          ),
                          //Image.asset(Assetname,width: 20,height: 20, ),
                          // SizedBox(width: 15,),
                          Expanded(child: Text(req_acc_dele,style: TextStyle(
                            fontSize: 16,color: lightGrey,
                          ),),),
                          Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_rightarrow.png",width: 10.0,)
                            ,)
                          /*
            Text(Title,style: TextStyle(
              fontSize: 16,color: lightGrey,
            ),),*/

                        ],

                      ),
                    ),
                  )),
                  //MorePageWidet(Assetname: "assets/remove-user.png", Title: req_acc_dele)),

              InkWell(
                  onTap: (){
                    showAlertForSignout();
                  },
                  child: MorePageWidet(Assetname: "assets/ic_signout.png", Title: signout+" (" +CommonUtils.consumerEmail.toString() + ")")),
              SizedBox(height: 15.0,),
              checkDevorLive(),


            ],
          )
      ),
    );
  }
  _launchEmail() async{
    var email_body = CommonUtils.manufacturer.toString()+"\n"+"Model "+CommonUtils.deviceModel.toString()+"\n"+
        "OS "+ CommonUtils.osVersion.toString()+"\n"+"Version "+ CommonUtils.softwareVersion.toString();
    print("check"+ email_body.toString());
    final Email email = Email(
      subject: emailContent,
      recipients: [contactEmail],
      isHTML: false,
      body: email_body,
    );

    await FlutterEmailSender.send(email);
  }
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
  Widget checkDevorLive(){
    if(BaseUrl=="https://mbmdev.poket.com/main/"){
      return Center(
        child: Text(version_text+CommonUtils.softwareVersion.toString()),
      );
    }
    else{
      return Center(
        child: Text(dev_version_text+CommonUtils.softwareVersion.toString()),
      );

    }

  }
  void showAlertForSignout() {
    AlertDialog alert1 = AlertDialog(
      backgroundColor: Colors.white,
      // content: CircularProgressIndicator(),
      content:
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(signout_confirmation,
            textAlign:  TextAlign.left,
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
              onTap: () async{
                Navigator.pop(context, true);
                bool internetcheck = await initTimer();
                print("bharathi"+internetcheck.toString());
                if(internetcheck==true){
                  callSignoutAPi();
                }else{
                  showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
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
                        signout_caps,
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
  Future<void> callSignoutAPi() async {
    print("url:" + LOGOUT_URL);

    final http.Response response = await http.post(
      Uri.parse(LOGOUT_URL),

      body: {
        "consumer_id": CommonUtils.consumerID,

      },
    ).timeout(Duration(seconds: 30));
    print("check2"+response.body.toString());
    print("dhgjk"+CommonUtils.consumerID.toString());
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = json.decode(jsonstring);
    print(data);
    var data2 = data['info'];
    var status = stringSplit(data2['p1']);
    var messg = stringSplitsign(data2['p2']);
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.clear();
    print("hii"+status);
    if (status == "1") {
      print("hii");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('consumerId');
      prefs.remove('consumerName');
      prefs.remove('consumerMobile');
      prefs.remove('consumerDeviceTokenId');
      prefs.remove('consumerprofileimage');
      // prefs.remove('consumerEmail');
      prefs.remove('alreadyLoggedIn');
      print("checkbhar"+ prefs.getString('consumerEmail').toString());
      // await prefs.clear();
      /*final fb = FacebookLogin();
      if(await fb.isLoggedIn){
        fb.logOut();
      }*/

      showAlertDialog_oneBtnsignout(context, alert, messg);

    } else {
      showAlertDialog_oneBtn(context, alert, messg);
    }

  }
  String stringSplitsign(String data) {
    return data.split("*%8%*")[0];
  }
  void showContactUSPopup(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,

      actions: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10,right:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(contactUs_content,style: TextStyle(fontSize: 15),),
                SizedBox(height: 35,),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    shareEmailFunction();
                  },
                  child: Text(email,style: TextStyle(fontSize: 15),),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    // _textMe();
                    if(Platform.isAndroid){
                      _launchSMS();}
                    else{
                      _launchSms();
                    }
                  },
                  child: Text(sms,style: TextStyle(fontSize: 15),),
                ),
                /* SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    shareToFeedFacebookLink(url: "https://www.dragon-i.com.my",quote: 'Hey there,I am using this Dragon-i Restaurants App. I know you will like it. You can search for Dragon-i Restaurants on App Store and Google Play');
                    // share.shareToFeedFacebookLink(url: "https://poket.com/app/");
                    *//*shareNewFb() async{
                      print("fb share");
                      try{
                        var dataa = await SocialSharePlugin.shareToFeedFacebookLink(url: "https://poket.com/app/",quote:  'Poketrewards');
                        print(dataa);
                      }
                      catch(e){
                        print(e);
                      }
                    }*//*

                    // _launchFacebook();
                  },
                  child: Text(facebook,style: TextStyle(fontSize: 15),),
                ),*/
                SizedBox(height: 25,),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:15.0,bottom: 8.0),
          child: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(cancel,style: TextStyle(fontSize: 15),),
            ),
          ),
        )
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  shareEmailFunction() async{
    final Email email = Email(
      subject: email_subject,
      isHTML: false,
      body: email_body,
    );

    await FlutterEmailSender.send(email);
  }
  _textMe() async {
    // Android

    const uri = 'sms:&body=Hey%20there,%20I\'m%20using%20this%20Dragon-i%20Restaurants%20App%20.I%20know%20you%20will%20like%20it.%20You%20can%20search%20for%20\'Dragon-i%20Restaurants\'%20on%20App%20Store%20and%20Google%20Play.';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:&body=Hey%20there,%20I\'m%20using%20this%20Dragon-i%20Restaurants%20App%20.I%20know%20you%20will%20like%20it.%20You%20can%20search%20for%20\'Dragon-i%20Restaurants\'%20on%20App%20Store%20and%20Google%20Play.';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
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
  void showAlertDialog_oneBtnsignout(BuildContext context, String tittle,
      String message) {
    print("check");
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(tittle, textAlign: TextAlign.left,),
      ),
      // content: CircularProgressIndicator(),
      content: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(message,textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black45)),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(ok,style: TextStyle(color: Maincolor)),
          onPressed: () {
            Navigator.pop(context, true);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                    SplashScreen()), (Route<dynamic> route) => false);

          },
        ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void dispose() {
    // TODO: implement dispose
    FocusScope.of(context).requestFocus(FocusNode());
    super.dispose();
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
}

class MorePageWidet extends StatelessWidget {
  final String Assetname;
  final String Title;
  const MorePageWidet({
    Key? key,required this.Assetname,required this.Title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border:Border(
              bottom: BorderSide(width: 0.2,color: Colors.grey)
          )
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,

                child:Image.asset(Assetname,width: 20,height: 20, ),
            ),
            //Image.asset(Assetname,width: 20,height: 20, ),
            // SizedBox(width: 15,),
            Expanded(child: Text(Title,style: TextStyle(
              fontSize: 16,color: lightGrey,
            ),),),
            Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_rightarrow.png",width: 10.0,)
                  ,)
            /*
            Text(Title,style: TextStyle(
              fontSize: 16,color: lightGrey,
            ),),*/

          ],

        ),
      ),
    );

  }
}
