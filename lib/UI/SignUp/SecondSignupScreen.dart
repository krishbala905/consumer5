import 'dart:convert';
import 'dart:ui';

import 'package:consumer5/Others/NativeAlertDialog.dart';

import 'package:consumer5/UI/SignUp/Signupfragment.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import '../ConsumerTab.dart';
import '../Login/Login.dart';
import 'Carlist.dart';
class SecondSigupScreen extends StatefulWidget {
  final  Data;
  const SecondSigupScreen({Key? key,required this.Data}) : super(key: key);

  @override
  State<SecondSigupScreen> createState() => _SecondSigupScreenState(Data);
}

class _SecondSigupScreenState extends State<SecondSigupScreen> {
  var Data = [];
  _SecondSigupScreenState(this.Data);
  TextEditingController NameTxt = TextEditingController();
  TextEditingController AddressTxt = TextEditingController();
  TextEditingController Car1details = TextEditingController();
  TextEditingController Car2details = TextEditingController();
  TextEditingController Car3details = TextEditingController();
  TextEditingController Car4details = TextEditingController();
  TextEditingController Car5details = TextEditingController();
  TextEditingController DobTxt = TextEditingController();
  TextEditingController EmailTxt = TextEditingController();
  TextEditingController PasswordTxt = TextEditingController();
  TextEditingController MobilenumberTxt = TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController zipCodeController=TextEditingController();
  var GednerId = 1;
  String SelectGender =  'Male';
  var countrycode="+65";
  double Contantheight = 50;
  List brandname =[];
  List brandid =[];
  List modelname =[];
  List modelid =[];

  List posts2=[];

  @override
  void initState() {
    // TODO: implement initState
    checkeligibilty();
    print(Data.length);
    print(Data[2]);
    NameTxt.text=Data[0].toString();
    EmailTxt.text=Data[1].toString();
    PasswordTxt.text=Data[2].toString();


  }

  Future<bool> _willPopCallback() async {
    CommonUtils.SignupData=[];
    CommonUtils.carPlateNumber1="";
    CommonUtils.carBrandNameApi1="";
    CommonUtils.carBrandId1="";
    CommonUtils.carModelNameApi1="";
    CommonUtils.carModelId1="";

    CommonUtils.carPlateNumber2="";
    CommonUtils.carBrandNameApi2="";
    CommonUtils.carBrandId2="";
    CommonUtils.carModelNameApi2="";
    CommonUtils.carModelId2="";

    CommonUtils.carPlateNumber3="";
    CommonUtils.carBrandNameApi3="";
    CommonUtils.carBrandId3="";
    CommonUtils.carModelNameApi3="";
    CommonUtils.carModelId3="";

    CommonUtils.carPlateNumber4="";
    CommonUtils.carBrandNameApi4="";
    CommonUtils.carBrandId4="";
    CommonUtils.carModelNameApi4="";
    CommonUtils.carModelId4="";

    CommonUtils.carPlateNumber5="";
    CommonUtils.carBrandNameApi5="";
    CommonUtils.carBrandId5="";
    CommonUtils.carModelNameApi5="";
    CommonUtils.carModelId5="";


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupFragment(),));
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(title: Text("Membership Form",style: TextStyle(color: Colors.white),),
              centerTitle: true,backgroundColor: Maincolor,elevation: 0.0,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                color: Colors.white,
                icon:Icon(Icons.arrow_back),
                //replace with our own icon data.
              ),),
            body: SingleChildScrollView(

              child: Column(

                children: [
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/ic_form_fullname.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: NameTxt,
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Full name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          InfoIconMessage(Infomessage: "We'd love to customize how we address you on your card.",),




                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,

                    child: Row(
                      children: [
                        Expanded(
                          flex:8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(value: 1, groupValue: GednerId, onChanged: (value){
                                setState(() {
                                  GednerId = 1;
                                  SelectGender = "Male";

                                });

                              },


                                fillColor: MaterialStateColor.resolveWith(
                                        (states) => Maincolor),


                              ),
                              SizedBox(width: 5,),
                              Text("Male",style: TextStyle(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.grey

                              ),),
                              Radio(value: 2, groupValue:GednerId, onChanged: (values){
                                setState(() {
                                  GednerId = 2;
                                  SelectGender = "Female";
                                });

                              },


                                fillColor: MaterialStateColor.resolveWith(
                                        (states) => Maincolor),

                              ),
                              Text("Female",style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.grey,
                              ),),



                            ],
                          ),),

                        Expanded(
                          flex: 1,
                          child: InfoIconMessage(Infomessage: "This will help us determine the perfect promotions for you.",),)
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/icon_birthday.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: DobTxt,
                                //keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_!#$%&*+-/=?^\`{|}~]')),
                                ],

                                decoration: InputDecoration(
                                  hintText: "Date of Birth",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().subtract(Duration(days:1)),
                                    firstDate: DateTime(
                                        1860 ), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Maincolor, // <-- SEE HERE
                                            onPrimary: Colors.white, // <-- SEE HERE
                                            onSurface: Colors.black, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Maincolor, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement


                                    DobTxt.text =
                                        formattedDate; //set output date to TextField value.

                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),
                          ),

                          InfoIconMessage(Infomessage: "Sharing your birthday will allow us to celebrate your day by rewarding you with special treats.")




                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,

                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/icon_mobile.png",width: 25,height: 25,),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(

                                decoration:BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                          color: Colors.grey,
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

                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                )
                            ),
                          ),
                          /* Text("+65",style: TextStyle(
                            color: Colors.grey
                          ),),*/
                          Container(
                            height: Contantheight,
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller:MobilenumberTxt,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          InfoIconMessage(Infomessage: "Storing your number will make it easier and faster for you to share a promotion with a friend!",),



                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/ic_form_email.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: EmailTxt,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_!#\$%&*+-/=?^`{|}~]')),

                                ],

                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          InfoIconMessage(Infomessage: "Your email will be used as your Login ID",),




                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),

                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/ic_form_password.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                obscureText: true,
                                cursorColor: Colors.grey,
                                controller: PasswordTxt,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Create New Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          InfoIconMessage(Infomessage: "You will use this password for Login")




                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/home.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(


                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Stack(
                                children: [
                                  TextField(
                                    readOnly: true,
                                    cursorColor: Colors.grey,
                                    controller: AddressTxt,
                                    keyboardType: TextInputType.name,
                                    style: TextStyle(color: backgroundcolor2, fontSize: 15

                                    ),

                                    decoration: InputDecoration(
                                      hintText: "Address",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  InkWell(
                                      onTap:(){
                                        clickaddress();
                                      },
                                      child: Container()),
                                ],
                              ),
                            ),
                            //  ),
                          ),
                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/car.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(


                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Stack(
                                children: [
                                  TextField(
                                    readOnly: true,
                                    cursorColor: Colors.grey,
                                    controller: Car1details,
                                    keyboardType: TextInputType.name,
                                    style: TextStyle(color: backgroundcolor2, fontSize: 15

                                    ),

                                    decoration: InputDecoration(
                                      hintText: "Car1 Details",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  InkWell(
                                      onTap:(){

                                        SignupCarSelectionFragment("Car1 Details");
                                      },
                                      child: Container()),
                                ],
                              ),
                            ),
                            //  ),
                          ),
                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/car.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(


                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Stack(
                                children: [
                                  TextField(
                                    readOnly: true,
                                    cursorColor: Colors.grey,
                                    controller: Car2details,
                                    keyboardType: TextInputType.name,
                                    style: TextStyle(color: backgroundcolor2, fontSize: 15

                                    ),

                                    decoration: InputDecoration(
                                      hintText: "Car2 Details",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  InkWell(
                                      onTap:(){
                              SignupCarSelectionFragment("Car2 Details");
                                      },
                                      child: Container()),
                                ],
                              ),
                            ),
                            //  ),
                          ),
                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/car.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(


                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Stack(
                                children: [
                                  TextField(
                                    readOnly: true,
                                    cursorColor: Colors.grey,
                                    controller: Car3details,
                                    keyboardType: TextInputType.name,
                                    style: TextStyle(color: backgroundcolor2, fontSize: 15

                                    ),

                                    decoration: InputDecoration(
                                      hintText: "Car3 Details",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  InkWell(
                                      onTap:(){

                                     SignupCarSelectionFragment("Car3 Details");
                                      },
                                      child: Container()),
                                ],
                              ),
                            ),
                            //  ),
                          ),
                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/car.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(


                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Stack(
                                children: [
                                  TextField(
                                    readOnly: true,
                                    cursorColor: Colors.grey,
                                    controller: Car4details,
                                    keyboardType: TextInputType.name,
                                    style: TextStyle(color: backgroundcolor2, fontSize: 15

                                    ),

                                    decoration: InputDecoration(
                                      hintText: "Car4 Details",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  InkWell(
                                      onTap:(){

                                       SignupCarSelectionFragment("Car4 Details");
                                      },
                                      child: Container()),
                                ],
                              ),
                            ),
                            //  ),
                          ),
                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/car.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(


                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Stack(
                                children: [
                                  TextField(
                                    readOnly: true,
                                    cursorColor: Colors.grey,
                                    controller: Car5details,
                                    keyboardType: TextInputType.name,
                                    style: TextStyle(color: backgroundcolor2, fontSize: 15

                                    ),

                                    decoration: InputDecoration(
                                      hintText: "Car5 Details",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  InkWell(
                                      onTap:(){
                                        SignupCarSelectionFragment("Car5 Details");
                                      },
                                      child: Container()),
                                ],
                              ),
                            ),
                            //  ),
                          ),
                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () async {
                      if(NameTxt.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "Please Enter Full Name");
                      }
                      else if(MobilenumberTxt.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "Please Enter Mobile Number");
                      }
                      else if(EmailTxt.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "Please Enter Email Address");

                      }
                      else if(!validateEmail(EmailTxt.text)){
                        showAlertDialog_oneBtn(this.context, alert, "Please Enter Valid Email ID");
                      }
                      else if(PasswordTxt.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "Please Enter Password");
                      }
                      else if(Car1details.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "To service your car(s), we will need your car details. Kindly fill up the car details. This app is exclusive to serve MBM Wheelpower customer");
                      }
                      else {
                        var connectivityresult = await(Connectivity().checkConnectivity());
                        if(connectivityresult == ConnectivityResult.mobile || connectivityresult == ConnectivityResult.wifi ){
                          print("connecr");
                          showLoadingView(context);
                          CallSingupApi();
                        }

                        else{
                          showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
                          print("notttt");

                        }

                      }


                    },
                    child: Container(
                      height: 40,

                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(child: Text("Submit",style: TextStyle(
                          color: Colors.white
                      ),)),
                      decoration: BoxDecoration(
                          color: poketblue2,
                          borderRadius:BorderRadius.circular(20)
                      ),
                    ),
                  ),

                ],

              ),
            ),

          )),
    );
  }
  Future CallSingupApi() async {
    var data=null;
    print("url:"+SIGNUP_URL);
    print("dob:"+DobTxt.text.toString());

    final http.Response response = await http.post(
      Uri.parse(SIGNUP_URL),

      body: {

        "action_event": "55",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,

        "full_name": NameTxt.text.toString(),
        "gender":SelectGender.toString(),
        "phone_no" :MobilenumberTxt.text.toString(),
        "email":EmailTxt.text.toString(),
        "date_of_birth":DobTxt.text.toString(),
        "password":PasswordTxt.text.toString(),
        "user_address":  CommonUtils.address,
        "user_zipcode":  CommonUtils.zipcode,

        'user_car1plate':CommonUtils.carPlateNumber1,
        'user_car2plate':CommonUtils.carPlateNumber2,
        'user_car3plate':CommonUtils.carPlateNumber3,
        'user_car4plate':CommonUtils.carPlateNumber4,
        'user_car5plate':CommonUtils.carPlateNumber5,

        'user_car1brandid':CommonUtils.carBrandId1,
        'user_car2brandid':CommonUtils.carBrandId2,
        'user_car3brandid':CommonUtils.carBrandId3,
        'user_car4brandid':CommonUtils.carBrandId4,
        'user_car5brandid':CommonUtils.carBrandId5,

        'user_car1modelid':CommonUtils.carModelId1,
        'user_car2modelid':CommonUtils.carModelId2,
        'user_car3modelid':CommonUtils.carModelId3,
        'user_car4modelid':CommonUtils.carModelId4,
        'user_car5modelid':CommonUtils.carModelId5,
      },
    ).timeout(Duration(seconds: 30));

    print(response.statusCode.toString());
    print(response.body);
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var dataa = jsonDecode(jsonstring);
    var data2 = dataa['info'];
    print("checkresponse"+ data2.toString());
    var status = Utils().stringSplit(data2['p1']);
    var Message = Utils().stringSplit(data2['p5']);
// print(lstname);

    if(status=="1") {
      print("check2");
      CommonUtils.consumerID = Utils().stringSplit(data2['p2']).toString();
      var name = Utils().stringSplit(data2['p3']).toString();
      CommonUtils.consumerName = name.toString();
      CommonUtils.consumerGender = Utils().stringSplit(data2['p8']).toString();
      CommonUtils.consumerProfileImageUrl=Utils().stringSplit(data2['p9']).toString();
      CommonUtils.consumermobileNumber =Utils().stringSplit1(data2['p10']).toString();
      CommonUtils.consumerIntialScreen=Utils().stringSplit(data2['p6']).toString();
      CommonUtils.consumerEmail = EmailTxt.text.toString();
      CommonUtils.KEY_FORCE_LOG_OUT =Utils().stringSplit(data2['p7']).toString();
      CommonUtils.deviceTokenID = Utils().stringSplit(data2['p4']).toString();

      print("DevToken:" + CommonUtils.deviceTokenID.toString());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('NewSignup', "1");
      prefs.setString('consumerId', CommonUtils.consumerID.toString());
      prefs.setString('consumerName', CommonUtils.consumerName.toString());
      prefs.setString('consumerEmail', CommonUtils.consumerEmail.toString());
      prefs.setString(
          'consumerMobile', CommonUtils.consumermobileNumber.toString());
      prefs.setString(
          'consumerDeviceTokenId', CommonUtils.deviceTokenID.toString());
      print(CommonUtils.consumerID.toString());

      prefs.setString('alreadyLoggedIn', "1");

      CommonUtils.SignupData=[];
      CommonUtils.carPlateNumber1="";
      CommonUtils.carBrandNameApi1="";
      CommonUtils.carBrandId1="";
      CommonUtils.carModelNameApi1="";
      CommonUtils.carModelId1="";

      CommonUtils.carPlateNumber2="";
      CommonUtils.carBrandNameApi2="";
      CommonUtils.carBrandId2="";
      CommonUtils.carModelNameApi2="";
      CommonUtils.carModelId2="";

      CommonUtils.carPlateNumber3="";
      CommonUtils.carBrandNameApi3="";
      CommonUtils.carBrandId3="";
      CommonUtils.carModelNameApi3="";
      CommonUtils.carModelId3="";

      CommonUtils.carPlateNumber4="";
      CommonUtils.carBrandNameApi4="";
      CommonUtils.carBrandId4="";
      CommonUtils.carModelNameApi4="";
      CommonUtils.carModelId4="";

      CommonUtils.carPlateNumber5="";
      CommonUtils.carBrandNameApi5="";
      CommonUtils.carBrandId5="";
      CommonUtils.carModelNameApi5="";
      CommonUtils.carModelId5="";

      Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => ConsumerTab()));
    }
    else{
      //ShowNativeDialogue(context, 'Alert', Message);
      showAlertDialog_oneBtnsign(this.context, 'Alert', Message);
    }


  }
  void showAlertDialog_oneBtnsign(BuildContext context,String tittle,String message)
  {
    AlertDialog alert = AlertDialog(

      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message,style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context,true);
            Navigator.pop(context,true);
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child:Center(child: Text(ok,style: TextStyle(color:Maincolor),)),
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
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    countrycode = countryCode.toString();
  }
  Future<void> clickaddress() {

    if(CommonUtils.address!=""){
      addressController.text = CommonUtils.address.toString();
    }
    if(CommonUtils.zipcode!=""){
      zipCodeController.text = CommonUtils.zipcode.toString();
    }
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(5.0)),
            child: Container(

              height: 220,
              child: Padding(

                padding: const EdgeInsets.only(left:15.0,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
                    SizedBox(height: 10,),
                    Center(
                      child: Text("Address",style: TextStyle(color: Colors.black),),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(

                        hintText: "Address",
                        hintStyle: TextStyle(fontSize: 14,color: Colors.grey),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5, color: Colors.grey), //<-- SEE HERE
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextField(
                        controller: zipCodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Zip Codes",
                          hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5, color: Colors.grey), //<-- SEE HERE
                          ),
                        )
                    ),

                    SizedBox(height: 7,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async{
                            Navigator.pop(context,true);
                            var address = addressController.text.toString();
                            var zipcode = zipCodeController.text.toString();
                            CommonUtils.address = address.toString();
                            CommonUtils.zipcode = zipcode.toString();

                            if((address.toString()!=""&& zipcode.toString()!="")||(address.toString()==""&& zipcode.toString()!="")||(address.toString()!=""&& zipcode.toString()=="")) {

                              AddressTxt.text = address.toString() + "," +
                                  zipcode.toString();
                              print(AddressTxt.text.toString());

                            }else{

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
                                    ok,
                                    style: TextStyle(color: Maincolor),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                ),
              ),
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    NameTxt.dispose();
    AddressTxt.dispose();
    Car1details.dispose();
    Car2details.dispose();
    Car3details.dispose();
    Car4details.dispose();
    Car5details.dispose();
    DobTxt.dispose();
    EmailTxt.dispose();
    PasswordTxt.dispose();
    MobilenumberTxt.dispose();
    addressController.dispose();
    zipCodeController.dispose();
  }
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return false;
    } else {
      return true;
    }
  }


  checkeligibilty() async {
    final http.Response response = await http.post(
      Uri.parse(BASEURL1+"newapi/MbmDownloadCarDetailsCmdJson"),
      body: {
        "consumer_id": "0",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        "action_event":"1",
        "device_token_id":"0",

      },
    ).timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      var data=jsonDecode(response.body);
      List<dynamic> body = data["data"];

      setState(() {
        posts2=body.toList();
      });

    }

  }

  SignupCarSelectionFragment(var tittle){
    TextEditingController carplatenumber = TextEditingController();

    String carBrand_temp_hint="Car Brand";
    String carModel_temp_hint="Car Model";

    List carModelList=[];
    //Model
    var carModelName;
    var carModelNameApi;
    var carModelId;
    // Brand
    var carBrandName;
    var carBrandNameApi;
    var carBrandId;



    AlertDialog alertDialog=AlertDialog(
      alignment: Alignment.topCenter,

      backgroundColor: Colors.white,
      content:  StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return Padding(
            padding: EdgeInsetsDirectional.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children:[
                // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
                SizedBox(height: 5,),
                Center(child:Text(tittle,style: TextStyle(color: poketblue2),),),

                SizedBox(height: 15,),
                TextField(
                  controller: carplatenumber,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                    hintText: "Car Plate Number",
                    hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
                    ),
                  ),
                ),


                SizedBox(height: 5,),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: lightGrey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  height: 50,
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text(carBrand_temp_hint,style:const TextStyle(fontSize: 14,color: lightGrey )),
                        style:const TextStyle(color: lightGrey),
                        items: posts2.map((data)  {

                          return DropdownMenuItem(
                            value:data,


                            child: Text(data['brand_names'],
                              style:const TextStyle(fontSize: 14,color: lightGrey),),
                          );



                        }).toList(),

                        onChanged: (value) {
                          carBrandName=value;
                          var d=jsonEncode(value);

                          var m=jsonDecode(d);

                          carBrandId=m['brand_ids'];
                          carBrandNameApi=m['brand_names'];
                          setState(() {

                            carModelList=[];
                            List<dynamic> body = m["model"];
                            carModelList=body.toList();

                          });
                          print(carBrandNameApi);
                          print(carBrandId);
                          print(carModelList.length.toString());
                          print(carModelList.isEmpty.toString());

                        },
                        value: carBrandName==null ? null : carBrandName,
                      ),
                    ),
                  ),

                ),

                SizedBox(height: 5,),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: lightGrey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  height: 50,
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text(carModel_temp_hint,style:const TextStyle(fontSize: 14,color: lightGrey )),
                        style:const TextStyle(color: lightGrey),
                        items: carModelList.map((data)  {

                          return DropdownMenuItem(
                            value:data,


                            child: Text(data['model_name'].toString(),
                              style:const TextStyle(fontSize: 14,color: lightGrey),),
                          );



                        }).toList(),

                        onChanged: (value) {

                          var d=jsonEncode(value);
                          var m=jsonDecode(d);
                          carModelId=m['model_id'];
                          carModelNameApi=m['model_name'];
                          setState(() {
                            carModelName=value;
                          });
                        },
                        value: carModelName==null ? null : carModelName,
                      ),
                    ),
                  ),

                ),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: poketblue2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 35,
                          width: 100,child: Center(child: Text("Cancel",style: TextStyle(color: poketblue2),))),
                    ),
                    InkWell(
                      onTap: () async{

                        if(carplatenumber.text.isEmpty){
                          showAlertDialog_oneBtn(context, alert, "Please Enter Car Plate Number");
                        }
                        else if(carBrandNameApi==null){
                          showAlertDialog_oneBtn(context, alert, "Please Select Car Brand");
                        }
                        else if(carModelNameApi==null){
                          showAlertDialog_oneBtn(context, alert, "Please Select Car Model");
                        }
                        else{
                          if(tittle=="Car1 Details"){


                            CommonUtils.carPlateNumber1=carplatenumber.text;

                            CommonUtils.carBrandNameApi1=carBrandNameApi;
                            CommonUtils.carBrandId1=carBrandId;
                            CommonUtils.carModelNameApi1=carModelNameApi;
                            CommonUtils.carModelId1=carModelId;

                            print("1:"+CommonUtils.carPlateNumber1.toString());
                            print("2:"+CommonUtils.carBrandNameApi1.toString());
                            print("3:"+CommonUtils.carBrandId1.toString());
                            print("4:"+CommonUtils.carModelNameApi1.toString());
                            print("5:"+CommonUtils.carModelId1.toString());
                            Car1details.text=CommonUtils.carPlateNumber1.toString()+","+ CommonUtils.carBrandNameApi1.toString()+","+ CommonUtils.carModelNameApi1.toString();
                          }
                          else if(tittle=="Car2 Details"){
                            CommonUtils.carPlateNumber2=carplatenumber.text;
                            CommonUtils.carBrandNameApi2=carBrandNameApi;
                            CommonUtils.carBrandId2=carBrandId;
                            CommonUtils.carModelNameApi2=carModelNameApi;
                            CommonUtils.carModelId2=carModelId;
                            Car2details.text=CommonUtils.carPlateNumber2.toString()+","+ CommonUtils.carBrandNameApi2.toString()+","+ CommonUtils.carModelNameApi2.toString();
                          }
                          else if(tittle=="Car3 Details"){
                            CommonUtils.carPlateNumber3=carplatenumber.text;
                            CommonUtils.carBrandNameApi3=carBrandNameApi;
                            CommonUtils.carBrandId3=carBrandId;
                            CommonUtils.carModelNameApi3=carModelNameApi;
                            CommonUtils.carModelId3=carModelId;

                            Car3details.text=CommonUtils.carPlateNumber3.toString()+","+ CommonUtils.carBrandNameApi3.toString()+","+ CommonUtils.carModelNameApi3.toString();
                          }
                          else if(tittle=="Car4 Details"){
                            CommonUtils.carPlateNumber4=carplatenumber.text;
                            CommonUtils.carBrandNameApi4=carBrandNameApi;
                            CommonUtils.carBrandId4=carBrandId;
                            CommonUtils.carModelNameApi4=carModelNameApi;
                            CommonUtils.carModelId4=carModelId;
                            Car4details.text=CommonUtils.carPlateNumber4.toString()+","+ CommonUtils.carBrandNameApi4.toString()+","+ CommonUtils.carModelNameApi4.toString();
                          }
                          else if(tittle=="Car5 Details"){
                            CommonUtils.carPlateNumber5=carplatenumber.text;
                            CommonUtils.carBrandNameApi5=carBrandNameApi;
                            CommonUtils.carBrandId5=carBrandId;
                            CommonUtils.carModelNameApi5=carModelNameApi;
                            CommonUtils.carModelId5=carModelId;
                            Car5details.text=CommonUtils.carPlateNumber5.toString()+","+ CommonUtils.carBrandNameApi5.toString()+","+ CommonUtils.carModelNameApi5.toString();
                          }
                          carplatenumber.dispose();
                          Navigator.pop(context,true);

                        }



                      },
                      child: Align(

                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: poketblue2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 35,
                          width: 100,

                          child: Center(
                              child: Text(
                                ok,
                                style: TextStyle(color: poketblue2),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

            ),
          );
        },
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
