import 'dart:convert';
import 'dart:io';
import 'package:consumer5/Others/Urls.dart';
import 'package:xml2json/xml2json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:consumer5/Others/AlertDialogUtil.dart';
import 'package:consumer5/Others/CommonUtils.dart';
import 'package:consumer5/Others/Utils.dart';
import 'package:consumer5/res/Colors.dart';
import 'package:consumer5/res/Strings.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

// import 'package:contact_picker/contact_picker.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:country_code_picker/country_code_picker.dart';
//import 'package:sms_advanced/sms_advanced.dart';

import '../Models/Card/WalletmodelVoucher1New.dart';
import 'WalletSendReceiveGift.dart';
class GiftFragment extends StatefulWidget {
  final WalletmodelVoucher1New Object1;
   GiftFragment({Key? key,required this.Object1}) : super(key: key);

  @override
  State<GiftFragment> createState() => _GiftFragmentState(this.Object1);
}

class _GiftFragmentState extends State<GiftFragment> {
  WalletmodelVoucher1New Object1;
  _GiftFragmentState(this.Object1);
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController feedbackcontroller = TextEditingController();
 // final Telephony telephony = Telephony.instance;
  PhoneContact? _phoneContact;
  var countrycode = "+65";
  bool sendDirect = false;
  List<String> people = ["7904551795","9962550515"];
  String? _message, body;
  // final ContactPicker _contactPicker = new ContactPicker();
  /*Contact? _contact;*/
  void initState() {
     checkeligibilty();
  }
  Future<void> showSmsSource(BuildContext context ) async {
    if ( Platform.isIOS){
      return showCupertinoModalPopup<void>(context: context, builder: (context) =>
          CupertinoActionSheet(
            actions: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Tell your friend how to receive your voucher?",style: TextStyle(fontSize: 18.0),),
                  )),
              CupertinoActionSheetAction(
                child: Text("SMS your friend"),
                onPressed: (){
                  // OpenCamera();
                  Navigator.of(context).pop();
                 // shareSMSFunction(); // two
                  sendGift();
                 // Navigator.of(context).pop();

                },
              ),
              CupertinoActionSheetAction(
                child: Text("Without SMS your friend"),
                onPressed: (){
                  // OpenGalley();
                  //shareSMSFunction();
                  Navigator.of(context).pop();
                  sendGift();
                //  Navigator.of(context).pop();
                },
              ),




            ],
          ),
      );

    }
    else {
      showModalBottomSheet(context: context, builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tell your friend how to receive your voucher?",style: TextStyle(fontSize: 18.0),),
                )),
            ListTile(
             // leading: Icon(Icons.camera_alt,color: Colors.grey,size: 35,),
              onTap: (){
              //  OpenCamera();
                Navigator.of(context).pop();
                //_send();
               // shareSMSFunction(); //one
                sendGift();

              },
              title:  Text("SMS your friend"),
            ),
            Container(width: double.infinity,height: 1,color: Colors.grey,),
            ListTile(
            //  leading: Icon(Icons.image_outlined,color: Colors.grey,size: 35,),
              onTap: (){
              //  OpenGalley();
                Navigator.of(context).pop();
                sendGift();

              },
              title: Text("Without SMS your friend"),
            ),

          ],
        );

      },);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10),

              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Key in a mobile number or add from your contacts to send the gift voucher",
                  softWrap: true,
                  style: TextStyle(fontSize: 15,color: lightGrey),
                ),
              ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Send To:",
              style: TextStyle(fontSize: 14,color: Maincolor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            color: lightGrey,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/ic_form_mobile.png",width: 20,),
                          SizedBox(width: 2,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration:BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                        color: Colors.black54,
                                        width: 0.5,
                                      )
                                  )
                              ) ,
                              child: CountryCodePicker(
                                initialSelection: 'SG',
                                favorite: ['+65','SG'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: true,
                                onChanged: _onCountryChange,
                                showFlag: false,
                                enabled: true,
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          /*Text(
                            "+65",
                            style: TextStyle(fontSize: 14,color: Colors.black38),
                          )*/
                        ],
                      )),
                  Expanded(
                      flex: 4,
                    child: Container(
                        decoration:BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                  color: Colors.black54,
                                  width: 0.5,
                                )
                            )
                        ) ,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                             LengthLimitingTextInputFormatter(10),
                          ],
                          controller: mobileNumberTextController,
                          // enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // counterText: ' ',
                            hintText: "Mobile Number",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      )),),
                  SizedBox(width: 8,),
                  Expanded(
                      flex:2,
                      child: InkWell(
                    onTap: () async{
                      final PhoneContact contact =
                      await FlutterContactPicker.pickPhoneContact();
                      print("check"+contact.toString());

                      // Contact contact = await _contactPicker.selectContact();
                      setState(() {
                        _phoneContact = contact;
                        var contacts = _phoneContact?.phoneNumber?.number;
                        print(_phoneContact?.phoneNumber?.number);
                        mobileNumberTextController.text = contacts!;
                      });
                    },
                    child: Container(
                      height: 40,

                      child: Row(
                        children: [
                          Image.asset("assets/ic_addressbook.png",height: 20,width: 20,),
                          SizedBox(width: 7,),
                          Text("Address Book",style: TextStyle(
                              color:poketblue,fontSize: 12.0
                          ),
                            maxLines: 2,
                          )
                        ],
                      ),
                    ),
                  )),
                 /* Expanded(child: Image.asset("assets/ic_addressbook.png",height: 20,width: 20,),
                 ),*/
                  /*Expanded(child: InkWell(
                    onTap: () async{
                      final PhoneContact contact =
                      await FlutterContactPicker.pickPhoneContact();
                      print("check"+contact.toString());

                     // Contact contact = await _contactPicker.selectContact();
                      setState(() {
                        _phoneContact = contact;
                        var contacts = _phoneContact?.phoneNumber?.number;
                        print(_phoneContact?.phoneNumber?.number);
                        mobileNumberTextController.text = contacts!;
                      });
                    },
                    child: Text("Address Book",style: TextStyle(
                      color:poketblue,fontSize: 12.0
                    ),

                    ),
                  ),
                  flex: 1,)*/
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: lightGrey,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/ic_gift.png",height: 25,width: 25,) ,
                SizedBox(height:10,),
                TextField(
                  // autofocus: true,
                  controller: feedbackcontroller,
                  textInputAction: TextInputAction.done,
                  maxLines: 8,
                  // enabled: false,//or null
                  style: TextStyle(fontSize: 15),

                  decoration: InputDecoration(

                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Maincolor, width: 1.0),
                        borderRadius: BorderRadius. circular(5.0),
                      ),
                      enabledBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Maincolor, width: 1.0),
                        borderRadius: BorderRadius. circular(5.0),
                      ),
                      disabledBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Maincolor, width: 1.0),
                        borderRadius: BorderRadius. circular(5.0),
                      ),
                    hintText: walletconten_giftcontent,

                  ),
                )
              ],
            ),
          ),
           Container(
            padding: EdgeInsets.only(top: 30),
            //color: Colors.red,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 140,
                  child: TextButton(onPressed: (){

                   Navigator.pop(context,true );
                  }, child: Text(cancel_caps ,style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),),
                    style: ButtonStyle(

                        backgroundColor: MaterialStateProperty.all(Colors.white,),
                        side: MaterialStateProperty.all(BorderSide(
                          color: Colors.grey
                        )),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),


                        ))


                    ),
                  ),


                ),
                SizedBox(
                  width: 140,
                  child: TextButton(onPressed: () async{
                    var phoenumber = countrycode.toString()+","+ mobileNumberTextController.text.toString();
                    print("hiii"+ phoenumber.toString());
                    print(CommonUtils.consumermobileNumber.toString());
                    if(countrycode.toString() =="null" ||countrycode.length<=0 ){
                      showAlertDialog_oneBtn(
                          context, alert, "Phone Code must not be empty");
                    }
                    else if(mobileNumberTextController.text.toString() ==" " ||mobileNumberTextController.text.length<=0 ){
                      showAlertDialog_oneBtn(
                          context, alert, "Mobile Number must not be empty");
                    }else if(feedbackcontroller.text.isEmpty||feedbackcontroller.text.length<=0){
                      showAlertDialog_oneBtn(
                          context, alert, "Message must not be empty");
                    }
                    else if(phoenumber == "+65,"+ CommonUtils.consumermobileNumber.toString()){
                      print("check");
                      showAlertDialog_oneBtn(
                          context, alert, "Please do not enter your own number");
                    }else{
                      var connectivityresult = await(Connectivity().checkConnectivity());
                      if(connectivityresult == ConnectivityResult.mobile || connectivityresult == ConnectivityResult.wifi ) {
                        print("connecr");
                        showSmsSource(context);
                      }
                      else{
                        showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
                        print("notttt");

                      }

                      // initTimer();
                    }


                  }, child: Text("SEND" ,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),),
                    style: ButtonStyle(

                        backgroundColor:MaterialStateProperty.all(Color(0xFF007AFF),),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),


                        ))


                    ),
                  ),
                ),

              ],

            ),


          ),
        ],
      ),
    );
  }
  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    countrycode = countryCode.toString();
  }

  Future<void> sendGift() async {
    var countryIndex = Object1.country_index.toString();
    var prgmimgurl = Object1.img_url.toString();

    var senderMessage = feedbackcontroller.text.toString();

    var phoneCode = countrycode.toString().split("+")[1];
   var receiverPhoneNo = phoneCode + "," + mobileNumberTextController.text.toString();
var prgm = Object1.program_id.toString();
var srlnm = Object1.full_run_no.toString();
//var prgmtype = Object1.programType.toString();
var expirydate = Object1.expire_date.toString();
print("test"+prgm.toString()+srlnm.toString()+expirydate.toString()+prgmimgurl.toString());


      final http.Response response = await http.post(
        Uri.parse(GIFTPROGRAM_URL),

        body: {
          "consumer_id": CommonUtils.consumerID.toString(),
          "cma_timestamps":Utils().getTimeStamp(),
          "time_zone":Utils().getTimeZone(),
          "software_version":CommonUtils.softwareVersion,
          "os_version":CommonUtils.osVersion,
          "phone_model":CommonUtils.deviceModel,
          "device_type":CommonUtils.deviceType,
          'consumer_application_type':CommonUtils.consumerApplicationType,
          'consumer_language_id':CommonUtils.consumerLanguageId,
          "action_event":"66",
          "program_id":prgm,
          "voucher_no": srlnm,
          "country_index":countryIndex,
          "sender_mobile_no":CommonUtils.consumermobileNumber,
          "receiver_mobile_no":receiverPhoneNo,
          // "program_type":prgmtype,
          "expiry_date":expirydate,
          "sender_message":senderMessage,
          "sender_first_name":CommonUtils.consumerName,

        },
      ).timeout(Duration(seconds: 30));


      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final Xml2Json xml2json = new Xml2Json();
        xml2json.parse(response.body);
        var jsonstring = xml2json.toParker();
        var data = jsonDecode(jsonstring);
        var data2 = data['info'];
        var status = Utils().stringSplit(data2['p1']);
        var messg = Utils().stringSplit(data2['p2']);
        if (status == "True") {
          print(data2['p1']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => WalletSendReceiveGift(receiverPhoneNo,prgmimgurl)));
        }
        else{
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => WalletSendReceiveGift(receiverPhoneNo,prgmimgurl)));
        }
      }
      else {
        throw "";
      }
  }

  checkeligibilty() async {
    final http.Response response = await http.post(
      Uri.parse(GIFTPROGRAM_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        "action_event":"53",
        "program_id":Object1.program_id,
        "voucher_no": Object1.full_run_no,
        "country_index":"191",
        "phone_no":CommonUtils.consumermobileNumber,

      },
    ).timeout(Duration(seconds: 30));


    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var data2 = data['info'];
      var status = Utils().stringSplit(data2['p1']);
      var messg = Utils().stringSplit(data2['p2']);
      if (status == "1") {

         }
      else{
      showAlertDialog_oneBtnWitDismiss(context, alert, messg);
       }
    }

  }

  // void shareSMSFunction() {
  //   SmsSender sender = new SmsSender();
  //   String address = mobileNumberTextController.text;
  //   String feedbackmsg = feedbackcontroller.text;
  //   SmsMessage message = new SmsMessage(address, feedbackmsg);
  //   message.onStateChanged.listen((state) {
  //   if (state == SmsMessageState.Sent) {
  //   print("SMS is sent!");
  //   } else if (state == SmsMessageState.Delivered) {
  //   print("SMS is delivered!");
  //   }
  //   });
  //   sender.sendSms(message);
  //
  // }

 /* void shareSMSFunction(List<String> recipients) async{

      try {
        String _result = await sendSMS(
          message: feedbackcontroller.text.toString(),
          recipients: recipients,
          sendDirect: sendDirect,
        ).catchError((onError) {
          print(onError);
        });
        print("bhar"+_result.toString());
        setState(() => _message = _result);
      } catch (error) {
        setState(() => _message = error.toString());
      }

    *//*telephony.sendSms(
        to: mobileNumberTextController.text.toString(),
        message: "May the force be with you!",
        statusListener: listener
    );*//*
  }
  void _send() {
    if (people.isEmpty) {
      setState(() => _message = 'At Least 1 Person or Message Required');
    } else {
      shareSMSFunction(people);
    }
  }*/
  /*final SmsSendStatusListener listener = (SendStatus status) {
    // Handle the status
  };*/
}
