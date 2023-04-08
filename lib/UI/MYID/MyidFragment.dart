import 'package:xml2json/xml2json.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http_parser/http_parser.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import '../ConsumerTab.dart';
import '../More/Profile.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class MyidFragment extends StatefulWidget {
  const MyidFragment({Key? key}) : super(key: key);

  @override
  State<MyidFragment> createState() => _MyidFragmentState();
}

class _MyidFragmentState extends State<MyidFragment> {
  var uploadmode;
  File?image1;
  void initState() {
    super.initState();

    print("test:" + CommonUtils.consumerProfileImageUrl.toString());
  }
  Future OpenGalley() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 15);
      if (image == null)  return;
      final imageTemporary = File(image.path);
      setState(() {
        _cropImage(imageTemporary,this.context);
        print(imageTemporary.path);
        uploadmode = "2";
        // image = imageTemporary;
      });
    } catch(error) {
      print("error: $error");
    }


  }
  Future OpenCamera() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 15);
      if (image == null)  return;
      final imageTemporary = File(image.path);
      setState(() {
        _cropImage(imageTemporary,this.context);
        uploadmode = 1;
        print(imageTemporary.path);
        // image = imageTemporary;
      });
    } catch(error) {
      print("error: $error");
    }

  }
  Future<ImageSource?> showImgSource(BuildContext context ) async {
    if ( Platform.isIOS){
      return showCupertinoModalPopup<ImageSource>(context: context, builder: (context) =>
          CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text(camera),
                onPressed: (){
                  OpenCamera();
                  Navigator.of(context).pop();

                },
              ),
              CupertinoActionSheetAction(
                child: Text(gallery),
                onPressed: (){
                  OpenGalley();
                  Navigator.of(context).pop();
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
            ListTile(
              leading: Icon(Icons.camera_alt,color: Colors.grey,size: 35,),
              onTap: (){
                OpenCamera();
                Navigator.of(context).pop();
              },
              title:  Text(camera),
            ),
            ListTile(
              leading: Icon(Icons.image_outlined,color: Colors.grey,size: 35,),
              onTap: (){
                OpenGalley();
                Navigator.of(context).pop();
              },
              title:  Text(gallery),
            ),

          ],
        );

      },);
    }
  }
  Future<void> _cropImage(var image,BuildContext context) async {
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: corporateColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio3x2,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',

          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,

          ),
        ],
      );
      if (croppedFile != null) {
        final imagetemp=File(croppedFile.path);
        setState(() {
          this.image1 = imagetemp;

        });
        if(image1!=null){
callAPI(image1,"${new Utils().getTimeStamp()}.png");
        }
      }
    }
  }
  void callAPI(var image,String name) async {
    print("checking3$image");
    var stream1 = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length1 = await image.length();
    //  var uri = Uri.parse(UPLOADPROFILEPHOTO_URL);
    var uri = Uri.parse(UPLOADPROFILEPHOTO_URL);
    var request = new http.MultipartRequest("POST", uri);
    request.fields["action_event"] = "2";
    request.fields["software_version"] = CommonUtils.softwareVersion.toString();
    request.fields["consumer_id"] = CommonUtils.consumerID.toString();
    request.fields["upload_mode"] = uploadmode.toString();
    request.fields["device_token_id"] = CommonUtils.deviceToken.toString();
    request.fields["device_type"] ="2";
    request.fields["consumer_language_id"] =CommonUtils.APPLICATIONLANGUAGEID.toString();
    request.fields["consumer_application_type"] =CommonUtils.consumerApplicationType.toString();



    var multipartFile = new http.MultipartFile('scanning_photo', stream1, length1,
        filename: basename(image.path),
        contentType: new MediaType('image', 'jpg'));
    request.files.add(multipartFile);


    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      response.stream.transform(utf8.decoder).listen((value) async {
        xml2json.parse(value);
        var jsonstring = xml2json.toParker();
        var data = jsonDecode(jsonstring);
        var data2 = data['info'];
        print("checking4"+ data2.toString());
        var status = Utils().stringSplit(data2['p1']);
        print(status);
        var messg = Utils().stringSplit(data2['p3']);
        print(messg);
        // showAlertDialog_oneBtnWitDismiss(this.context, "Alert", messg);
        if(status=="true"){

          var newprofilepic = Utils().stringSplit(data2['p2']) ;
          CommonUtils.consumerProfileImageUrl=newprofilepic;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('consumerprofileimage', CommonUtils.consumerProfileImageUrl.toString());
          print("checking "+CommonUtils.consumerProfileImageUrl.toString());
          showAlertDialog_oneBtnn(this.context, 'Alert', "Your Profile has been updated");
        }
        else{
          print("check1");
          showAlertDialog_oneBtn(this.context, 'Alert', messg);
        }
      });

    }
  }
  void showAlertDialog_oneBtnn(BuildContext context,String tittle,String message)
  {
    AlertDialog alert = AlertDialog(

      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message,style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: (){
            CommonUtils.NAVIGATE_PATH=CommonUtils.MyidPage;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ConsumerTab()));

          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,

              child:Center(child: Text(ok,style: TextStyle(color: corporateColor),)),
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
  String converttoHex(int n) {
    return n.toRadixString(16);
  }

  String checkData(List test) {
    bool valid = true;
    int crc = 0xFFFF; // initial value
    int polynomial = 0x1021; // 0001 0000 0010 0001 (0, 5, 12)
    for (var b in test) {
      for (int i = 0; i < 8; i++) {
        bool bit = ((b >> (7 - i) & 1) == 1);
        bool c15 = ((crc >> 15 & 1) == 1);
        crc <<= 1;
        if (c15 ^ bit) crc ^= polynomial;
      }
    }
    crc &= 0xffff;
    return crc.toRadixString(16).toString();
  }

  int getRandomNumberBetweenAndToCharacter() {
    int min = 71;
    int max = 90;
    Random foo = new Random();
    int randomNumber = foo.nextInt(max - min) + min;
    if (randomNumber == min) {
      return (min + 1);
    } else {
      return randomNumber;
    }
  }

  String checkLengthForChecksum(String crcstring) {
    String valuetoreturn = crcstring;
    int definedcrclength = 4;
    int length = crcstring.length;
    if (length != definedcrclength) {
      switch (length) {
        case 0:
          valuetoreturn = "0000" + crcstring;
          break;
        case 1:
          valuetoreturn = "000" + crcstring;
          break;
        case 2:
          valuetoreturn = "00" + crcstring;
          break;
        case 3:
          valuetoreturn = "0" + crcstring;
          break;
        case 4:
          valuetoreturn = crcstring;
          break;
      }
    } else {
      valuetoreturn = crcstring;
    }
    return valuetoreturn;
  }

  String CheckLengthIsEven(String checkLengthOFString) {
    String valuetoreturn = checkLengthOFString;
    if (CheckEvenNumberOrNot(checkLengthOFString.length)) {
      valuetoreturn = checkLengthOFString.toString();
    } else {
      valuetoreturn = "0" + checkLengthOFString.toString();
    }
    return valuetoreturn;
  }

  bool CheckEvenNumberOrNot(int checkthisnumber) {
    return (checkthisnumber % 2) == 0;
  }

  Future<String> getdata1() async {
    String qrimageformat = "";

    List test = List.filled(6, null, growable: false);

    int temp = 0;
    int num1 = 0;
    int num2 = 0;
    int num3 = 0;
    int num4 = 0;
    int num5 = 0;
    int num6 = 0;

    temp = int.parse(CommonUtils.consumerID.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num1 = temp;

    temp = int.parse(CommonUtils.consumerID.toString());
    temp = temp & 0x000000ff;
    num2 = temp;

    temp = int.parse(CommonUtils.deviceType.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num3 = temp;
    temp = int.parse(CommonUtils.deviceType.toString());
    temp = temp & 0x000000ff;
    num4 = temp;

    temp = int.parse(CommonUtils.deviceTokenID.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num5 = temp;

    temp = int.parse(CommonUtils.deviceTokenID.toString());
    temp = temp & 0x000000ff;
    num6 = temp;

    test[0] = num1;
    test[1] = num2;
    test[2] = num3;
    test[3] = num4;
    test[4] = num5;
    test[5] = num6;

    var crc_msg = checkData(test);

    String consumerid =
        converttoHex(int.parse(CommonUtils.consumerID.toString()));

    String devicetype =
        converttoHex(int.parse(CommonUtils.deviceType.toString()));

    String devicetokenid =
        converttoHex(int.parse(CommonUtils.deviceTokenID.toString()));

    var a = getRandomNumberBetweenAndToCharacter();
    var b = getRandomNumberBetweenAndToCharacter();
    var c = getRandomNumberBetweenAndToCharacter();

    String random_alphabet1 = a.toString().toUpperCase();
    String random_alphabet2 = b.toString().toUpperCase();
    String random_alphabet3 = c.toString().toUpperCase();
    random_alphabet1 = "Q";
    random_alphabet2 = "X";
    random_alphabet3 = "K";

    crc_msg = checkLengthForChecksum(crc_msg);

    qrimageformat = "Poket" +
        consumerid +
        random_alphabet1 +
        devicetype +
        random_alphabet2 +
        devicetokenid +
        random_alphabet3 +
        crc_msg +
        appendQRImagewithOtherDetails();

    print("QRImageFormat:" + qrimageformat);
    return qrimageformat;
  }

  String appendQRImagewithOtherDetails() {
    List test = List.filled(8, null, growable: false);
    int temp = 0;
    int num1 = 0;
    int num2 = 0;
    int num3 = 0;
    int num4 = 0;
    int num5 = 0;
    int num6 = 0;
    int num7 = 0;
    int num8 = 0;

    temp = int.parse(CommonUtils.consumerID.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num1 = temp;
    temp = int.parse(CommonUtils.consumerID.toString());
    temp = temp & 0x000000ff;
    num2 = temp;
    temp = int.parse(CommonUtils.QRVERSION.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num3 = temp;
    temp = int.parse(CommonUtils.QRVERSION.toString());
    temp = temp & 0x000000ff;
    num4 = temp;
    temp = int.parse(CommonUtils.SELECTEDLANGUAGEPACKAGEID.toString());
    //temp = CommonUtil.APPLICATION_LANGUAGE_ID;
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num5 = temp;
    temp = int.parse(CommonUtils.SELECTEDLANGUAGEPACKAGEID.toString());
    //temp = CommonUtil.APPLICATION_LANGUAGE_ID;
    temp = temp & 0x000000ff;
    num6 = temp;
    // /////////////////////////
    temp = int.parse(CommonUtils.APPLICATIONID.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num7 = temp;
    temp = int.parse(CommonUtils.APPLICATIONID.toString());
    temp = temp & 0x000000ff;
    num8 = temp;

    test[0] = num1;
    test[1] = num2;
    test[2] = num3;
    test[3] = num4;
    test[4] = num5;
    test[5] = num6;
    test[6] = num7;
    test[7] = num8;

    String crc_msgforappend = checkData(test);
    String qrversion = converttoHex(CommonUtils.QRVERSION);
    String languagepackid = converttoHex(CommonUtils.SELECTEDLANGUAGEPACKAGEID);
    //String languagepackid = converttoHex(CommonUtil.APPLICATION_LANGUAGE_ID);
    String appid = converttoHex(CommonUtils.APPLICATIONID);
    appid = CheckLengthIsEven(appid);

    var a = getRandomNumberBetweenAndToCharacter();
    var b = getRandomNumberBetweenAndToCharacter();
    var c = getRandomNumberBetweenAndToCharacter();
    String random_alphabet1 = a.toString().toUpperCase();
    String random_alphabet2 = b.toString().toUpperCase();
    String random_alphabet3 = c.toString().toUpperCase();
    String random_alphabet4 = c.toString().toUpperCase();

    random_alphabet1 = "T";
    random_alphabet2 = "R";
    random_alphabet3 = "V";
    random_alphabet4 = "Y";

    crc_msgforappend = checkLengthForChecksum(crc_msgforappend);
    return random_alphabet1 +
        qrversion +
        random_alphabet2 +
        languagepackid +
        random_alphabet3 +
        appid +
        random_alphabet4 +
        crc_msgforappend;
  }

  Widget generateQRCode() {
    return FutureBuilder(
      future: getdata1(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final String post = snapshot.data.toString();
          debugPrint("QRData:" + post);
          return QrImage(
            data: post,
            version: QrVersions.auto,
            size: 300,
            gapless: false,
            foregroundColor: corporateColor,
            errorStateBuilder: (cxt, err) {
              return Container(
                child: Center(
                  child: Text(
                    err.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("check" + CommonUtils.consumermobileNumber.toString());
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset('assets/ic_applogo.png'),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Text("My ID"),
        backgroundColor: Maincolor,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    if (CommonUtils.consumerProfileImageUrl.toString() ==
                        "none"|| CommonUtils.consumerProfileImageUrl.toString() == "")
                      InkWell(
                        onTap: ()async{
                          showImgSource(context);
                        },
                        child: Center(
                          child: Container(
                            child: Stack(
                              children: [
                                Image.asset('assets/img_profileplaceholder.png',
                                    width: 70, height: 70),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //SizedBox(width: 20,),
                                Padding(padding: EdgeInsets.only(),
                                    child: Image.asset("assets/ic_photo.png",
                                      width: 25,)
                                ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    /*if (CommonUtils.consumerProfileImageUrl.toString() == "")
                      Center(
                        child: Container(
                          child: Image.asset(
                              'assets/img_profileplaceholder.png',
                              width: 70,
                              height: 70),
                        ),
                      ),*/
                    if (CommonUtils.consumerProfileImageUrl.toString() !=
                            "none" &&
                        CommonUtils.consumerProfileImageUrl.toString() != "")
                      InkWell(
                        onTap: ()async{
                          showImgSource(context);
                        },
                        child: Center(
                          child: Container(
                            child: Image.network(
                              CommonUtils.consumerProfileImageUrl.toString(),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CommonUtils.consumerName.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: lightGrey,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            CommonUtils.consumerEmail.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: lightGrey,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          processMobileNumber(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileFragment("MYID"),
                              ));
                        },
                        child: Column(
                          children: [
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: corporateColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Image.asset('assets/ic_editprofile.png',
                                width: 30, height: 30),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                Letmerchantscan,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Maincolor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: generateQRCode(),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget processMobileNumber() {
    print("testMobile" + CommonUtils.consumermobileNumber.toString());
    var mobile = CommonUtils.consumermobileNumber.toString();

    if (mobile.contains(" ")) {
      var data = mobile.split(" ");
      print("Gokul:" + data.length.toString());
      print("Gokul:" + data[0].toString());
      if (data[0].contains("+")) {
        mobile = "(" + data[0] + ") " + data[1];
      } else {
        mobile = "(+" + data[0] + ") " + data[1];
      }
    }else{
      mobile = "("+ mobile+")";
    }
    return Text(
      mobile,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: lightGrey,
      ),
    );
  }
}
