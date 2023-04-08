import 'dart:convert';

import 'package:consumer5/UI/Login/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../ConsumerTab.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailId_cntrl = TextEditingController();
  TextEditingController pwdId_cntrl = TextEditingController();
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();
  var email;
  var paswd;
  var emailalreadylog;
  var vehicleNo;
  void initState(){
    checkemail();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      //top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: backgroundlight,
          appBar: AppBar(backgroundColor: Maincolor,
            automaticallyImplyLeading: true,
            elevation: 0,
            title: Text(login_small_letter,style: TextStyle(color: Colors.white),),
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              color: Colors.white,
              icon:Icon(Icons.arrow_back),
              //replace with our own icon data.
            ),),
          body: Column(

            children: [
              SizedBox(
                height: 20,
              ),
              Container(

                height: 50,
                width: double.infinity,

                //color: Colors.amber,
                decoration: BoxDecoration(

                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.3,
                      )
                  ),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset("assets/icon_email.png",height: 25, width: 25,),


                    Expanded(

                      child: Padding(
                        padding: const EdgeInsets.only(left: 25,bottom: 7),
                        child: TextField(
                          cursorColor: Colors.grey,
                          controller: emailId_cntrl,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.grey, fontSize: 15

                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_!#$%&*+-/=?^\`{|}~]')),
                          ],
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: lightGrey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                  ],

                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                //color: Colors.amber,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.3,
                      )
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset("assets/icon_password.png",height: 25, width: 25,),
                    Expanded(

                      child: Padding(
                        padding: const EdgeInsets.only(left: 25,bottom: 7),
                        child: TextField(
                          obscureText: true,
                          cursorColor: Colors.grey,
                          controller: pwdId_cntrl,
                          keyboardType: TextInputType.emailAddress,

                          style: TextStyle(color: Colors.grey, fontSize: 15

                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_]')),
                          ],
                          decoration: InputDecoration(

                            hintText: "Enter Password",
                            hintStyle: TextStyle(color: lightGrey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                  ],

                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (_) => ConsumerTab()));
                  //  Validation
                  email = emailId_cntrl.text.toString().trim();
                  paswd = pwdId_cntrl.text.toString();

                  loginTask(email, paswd);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: Container(
                    //color: Colors.cyan,
                    height: 45,
                    decoration: BoxDecoration(
                      color:  poketblue2,

                      borderRadius: BorderRadius.circular(22.5),

                    ),
                    child: Center(
                        child: Text(
                          loginwith,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // Validation
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
                  child: Center(
                      child: Text(
                        "Forget password?",
                        style: TextStyle(color: lightGrey, fontSize: 15,decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,

                      )),
                ),
              ),
        /*SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5,),
              Expanded(flex:1,child: Container(height: 1,color: grey1,)),
              SizedBox(width: 5,),
              Text("Or"),
              SizedBox(width: 5,),
              Expanded(flex:1,child: Container(height: 1,color: grey1,)),
              SizedBox(width: 5,),
            ],
          ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                // Facebook Signin

                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: Container(
                    //color: Colors.cyan,
                    height: 45,
                    decoration: BoxDecoration(
                      color:  blueFB,

                      borderRadius: BorderRadius.circular(22.5),

                    ),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/ic_facebook.png",height: 20),
                        SizedBox(width: 25,),
                        Text(
                          connect_with_facebook,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        )
    );
  }
  Future<void> loginTask(var email, var paswd) async {
    if (email.length == 0) {
      showAlertDialog_oneBtn(context, "Alert", "Please enter email address");

    } else if (validateEmail(email) != "1") {
      showAlertDialog_oneBtn(context, "Alert", "Please enter valid email address");

    } else if (paswd.length == 0) {
      showAlertDialog_oneBtn(context, "Alert", "Please enter password");

    }
    // else if (validatePassword(paswd) != "1") {
    //   showAlertDialog_oneBtn(context, "Alert", "Please enter valid password");
    //  // showAlertDialog_oneBtn(context, S.of(context).alert1, S.of(context).enter_valid_pwd);
    // }
    else {
      var connectivityresult = await(Connectivity().checkConnectivity());
      if(connectivityresult == ConnectivityResult.mobile || connectivityresult == ConnectivityResult.wifi ){
        print("connecr");
        showLoadingView(context);
        callApi(email, paswd);
      }

      else{
        showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
        print("notttt");

      }
      // callApi(email, paswd);
    }
  }
  String validatePassword(String value) {
    if (value.length < 6) {
      return "0";
    } else {
      return "1";
    }
  }
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return '0';
    } else {
      return "1";
    }
  }
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
  String stringSplitmob(String data) {
    return data.split(":")[0];
  }
  Future<void> callApi(var email, var pwd) async {
    print(CommonUtils.deviceToken);
    print(email+pwd);
    print(LOGIN_URL);
    print(CommonUtils.deviceType.toString()+";"+CommonUtils.deviceToken.toString()+";"+
        Utils().getTimeStamp().toString()+":;"+Utils().getTimeZone().toString()+";j"+ CommonUtils.softwareVersion.toString()+";'"
    +CommonUtils.osVersion.toString()+"jhd"+CommonUtils.deviceModel.toString());

    var data = null;

    final http.Response response = await http.post(
      Uri.parse(LOGIN_URL),
      body: {
        "consumer_email": email,
        "consumer_password": pwd,
        "login_mode": "1",
        "device_type": CommonUtils.deviceType.toString(),
        "device_token": CommonUtils.deviceToken.toString(),
        "cma_timestamps": Utils().getTimeStamp(),
        "time_zone": Utils().getTimeZone(),
        "software_version": CommonUtils.softwareVersion,
        "os_version": CommonUtils.osVersion,
        "phone_model": CommonUtils.deviceModel,
        // "new_huwavei_device":CommonUtils.new_huwavei_device,
        //"device_huwaei_aaid":CommonUtils.DEVICE_HUWAEI_AAID,
        //"device_huwaei_appid":CommonUtils.DEVICE_HUWAEI_APPID,
       // 'consumer_application_type': "1",
        //'consumer_language_id': "1",
      },
    ).timeout(Duration(seconds: 30));
    Navigator.pop(context);
    print("check"+response.body.toString());
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var data2 = data['info'];
      var status = stringSplit(data2['p1']);
      var messg = stringSplit(data2['p5']);
      if (status == "1") {
        print(data2['p1']);
        var consId = stringSplit(data2['p2']);
        var name = stringSplit(data2['p3']);
        if(name.contains("--")){
          List splitName = name.split("--");
          print(splitName.toString());
          name = splitName[0]; //Name
          vehicleNo = splitName[1];
        }
        var devTokenId = stringSplit(data2['p4']);
        var p6 = stringSplit(data2['p6']);
        var pnsforcetologut = stringSplit(data2['p7']);
        var gender = stringSplit(data2['p8']);
        var profileImg = stringSplit(data2['p9']);
        var mobNmbr = stringSplitmob(data2['p10']);
        //var address = stringSplit(data2['p11']);
        //var postalcode = stringSplit(data2['p12']);
        //  CommonUtils.consumerID = "219732";
        CommonUtils.consumerID = consId;
        CommonUtils.consumerName = name;
        CommonUtils.consumerGender = gender;
        CommonUtils.consumerProfileImageUrl = profileImg;
        CommonUtils.consumermobileNumber = mobNmbr;
        CommonUtils.consumerforcelogout = pnsforcetologut;
        CommonUtils.consumerEmail = email;
        CommonUtils.deviceTokenID =devTokenId;
        /*CommonUtils.consumeraddress = address;
        CommonUtils.consumerpostalcode = postalcode;*/
        print("DevTokenId:"+CommonUtils.deviceTokenID.toString());
       // print("DevTokenId:"+CommonUtils.consumeraddress.toString());
        //print("DevTokenId:"+CommonUtils.consumerpostalcode.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('alreadyLoggedIn', "1");
        prefs.setString('consumerId', CommonUtils.consumerID.toString());
        prefs.setString('consumerName', CommonUtils.consumerName.toString());
        prefs.setString('consumerEmail', CommonUtils.consumerEmail.toString());
        prefs.setString('consumerMobile', CommonUtils.consumermobileNumber.toString());
        prefs.setString('consumerDeviceTokenId', CommonUtils.deviceTokenID.toString());
       // prefs.setString('consumerprofileimage',CommonUtils.consumerProfileImageUrl.toString());
        print("4"+prefs.getString("consumerId").toString());

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ConsumerTab(),
            ));
      } else {

        showAlertDialog_oneBtn(context, "Alert", messg);
        // showAlertDialog_oneBtnlog(context, S.of(context).alert1, messg);
      }
    } else {
      showAlertDialog_oneBtn(context, "Alert", "Something went wromg");
      // showAlertDialog_oneBtn(context, S.of(context).alert1, S.of(context).something_went_wrong1);
    }
  }
  void checkemail() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var email =  prefs.getString('consumerEmail');
    if (email != null) {
      emailId_cntrl.text = email.toString();
    }
    else {
      emailId_cntrl.text = "";
    }
  }
}
