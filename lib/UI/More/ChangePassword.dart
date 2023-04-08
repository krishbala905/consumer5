import 'dart:async';
import 'dart:convert';

import 'package:consumer5/Others/AlertDialogUtil.dart';
import 'package:consumer5/Others/CommonUtils.dart';
import 'package:consumer5/Others/Urls.dart';
import 'package:consumer5/Others/Utils.dart';
import 'package:consumer5/res/Colors.dart';
import 'package:consumer5/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  void initState() {
    // TODO: implement initState
    super.initState();
    hideKeyboard();
  }

  bool _obscured = false;
  bool _obscured1 = false;
  bool _obscured2 = false;
  final textFieldFocusNode = FocusNode();
  TextEditingController oldpwd_cntrl = TextEditingController();
  TextEditingController newpwd_cntrl = TextEditingController();
  TextEditingController confirmpwd_cntrl = TextEditingController();
  var oldPwd, newPwd, confirmPwd;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          change_password,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Maincolor,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(changepasswordcontent,textAlign: TextAlign.center,style:TextStyle(fontSize: 12,)),

            ),
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              height: 1,
            ),
            Container(
              height: 55,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Container(
                      width: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Image.asset(
                          "assets/ic_form_password.png",
                          height: 100,
                          width: 40,
                        ),
                      )),
                  SizedBox(width: 10),
                  Container(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: TextField(
                          // obscureText: true,
                          controller: oldpwd_cntrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Old Password",
                            hintStyle: TextStyle(color: lightGrey),
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              height: 1,
            ),
            Container(
              height: 55,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Container(
                      width: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Image.asset(
                          "assets/ic_form_password.png",
                          height: 100,
                          width: 40,
                        ),
                      )),
                  SizedBox(width: 10),
                  Container(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: TextField(
                          controller: newpwd_cntrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "New Password",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: lightGrey),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              height: 1,
            ),
            Container(
              height: 55,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Container(
                      width: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Image.asset(
                          "assets/ic_form_password.png",
                          height: 100,
                          width: 40,
                        ),
                      )),
                  SizedBox(width: 10),
                  Container(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: TextField(
                          controller: confirmpwd_cntrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: lightGrey),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              height: 1,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28),
              child: InkWell(
                onTap: () {
                  callApi();
                },
                child: Center(
                  child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: poketblue,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                          child: Text(
                        change_password,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ))),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> callApi() async {
    oldPwd = oldpwd_cntrl.text;
    newPwd = newpwd_cntrl.text;
    confirmPwd = confirmpwd_cntrl.text;

    if (oldPwd.isEmpty) {
      showAlertDialog_oneBtn(
          context, alert, please_enter_old_pwd);
    } else if (newPwd.isEmpty) {
      showAlertDialog_oneBtn(
          context, alert, please_enter_new_pwd);
    } else if (confirmPwd.isEmpty) {
      showAlertDialog_oneBtn(context, alert,
          please_enter_confrim_pwd);
    } else if (newPwd != confirmPwd) {
      showAlertDialog_oneBtn(context, alert,
          new_confirm_pwd_mismatch);
    } else {
      showLoadingView(context);
      initTimer();
    }
  }

  void showAlertDialog_oneBtnWitDismiss(
      BuildContext context, String tittle, String message) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      // content: CircularProgressIndicator(),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message, style: TextStyle(color: Colors.black45)),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
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
                style: TextStyle(color: corporateColor),
              )),
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
    ).then((exit) {
      if (exit == null) return;

      if (exit) {
        // back to previous screen

        Navigator.pop(context);
      } else {
        // user pressed No button
      }
    });
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleObscured1() {
    setState(() {
      _obscured1 = !_obscured1;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }

  void initTimer() async {
    if (await checkinternet()) {
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");
        callupdate(oldPwd, newPwd, confirmPwd);
      });
    } else {
      showAlertDialog_oneBtnWitDismiss(this.context, "Network",
          "Internet Connection. Please turn on Internet Connection");
    }
  }

  Future<bool> checkinternet() async {
    var connectivityresult = await (Connectivity().checkConnectivity());
    if (connectivityresult == ConnectivityResult.none) {
      print("not connected");
      return false;
    } else {
      return true;
    }
  }

  Future<void> callupdate(
      String oldPwd, String newPwd, String confirmPwd) async {
    var data = null;
    print("url:" + CHANGEPASSWORD_URL);

    final http.Response response = await http.post(
      Uri.parse(CHANGEPASSWORD_URL),
      body: {
        "consumer_old_password": oldPwd,
        "consumer_new_password": newPwd,
        "consumer_id": CommonUtils.consumerID,
        "cma_timestamps": Utils().getTimeStamp(),
        "time_zone": Utils().getTimeZone(),
        "software_version": CommonUtils.softwareVersion,
        "os_version": CommonUtils.osVersion,
        "phone_model": CommonUtils.deviceModel,
        "device_type": CommonUtils.deviceType,
        'consumer_application_type': CommonUtils.consumerApplicationType,
        'consumer_language_id': CommonUtils.consumerLanguageId,
      },
    ).timeout(Duration(seconds: 30));
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var data2 = data['info'];
      var status = stringSplit(data2['p1']);
      var message = stringSplit(data2['p2']);
      if (status.toLowerCase() == "true") {
        showAlertDialog_oneBtnWitDismiss(
            context, alert, message);
      } else {
        showAlertDialog_oneBtnWitDismiss(context, alert, message);
      }
    } else {
      showAlertDialog_oneBtnWitDismiss(
          context,alert, something_went_wrong1);
    }
  }
}
