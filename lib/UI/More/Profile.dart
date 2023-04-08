import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:consumer5/Others/AlertDialogUtil.dart';
import 'package:consumer5/Others/CommonUtils.dart';
import 'package:consumer5/Others/NativeAlertDialog.dart';
import 'package:consumer5/Others/Urls.dart';
import 'package:consumer5/res/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:xml2json/xml2json.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../Others/Utils.dart';
import '../../res/Strings.dart';
import '../ConsumerTab.dart';

class ProfileFragment extends StatefulWidget {
  String from="";
   ProfileFragment(this.from,{Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState(from);
}

class _ProfileFragmentState extends State<ProfileFragment> {
  String from = "";
  List posts2=[];
  TextEditingController addressController=TextEditingController();
  TextEditingController zipCodeController=TextEditingController();
  TextEditingController FristName = TextEditingController();
  TextEditingController DoBTxt = TextEditingController();
  TextEditingController EmailAddress = TextEditingController();
  TextEditingController Mobilenum = TextEditingController();
  TextEditingController Phonecode = TextEditingController();
  TextEditingController addressTxt = TextEditingController();
  TextEditingController OwnerIdTxt1 = TextEditingController();
  TextEditingController OwnerIdTxt2 = TextEditingController();
  TextEditingController OwnerIdTxt3 = TextEditingController();
  TextEditingController OwnerIdTxt4 = TextEditingController();
  TextEditingController OwnerIdTxt5 = TextEditingController();

  _ProfileFragmentState(this.from);

  String countrycode="";
  var Buyer_seller = 0;
  String SelectBuyer_seller = '';
  bool val = false;
  var brokettype;
  var GednerId = 0;
  String SelectGender = '';

  double Contantheight = 50;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkeligibilty();
    _GetProfile();

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

                              addressTxt.text = address.toString() + "," +
                                  zipcode.toString();
                              print(addressTxt.text.toString());

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
                          width: 100,
                          child: Center(child: Text("Cancel",style: TextStyle(color: poketblue2),))),
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
                            OwnerIdTxt1.text=CommonUtils.carPlateNumber1.toString()+","+ CommonUtils.carBrandNameApi1.toString()+","+ CommonUtils.carModelNameApi1.toString();
                          }
                          else if(tittle=="Car2 Details"){
                            CommonUtils.carPlateNumber2=carplatenumber.text;
                            CommonUtils.carBrandNameApi2=carBrandNameApi;
                            CommonUtils.carBrandId2=carBrandId;
                            CommonUtils.carModelNameApi2=carModelNameApi;
                            CommonUtils.carModelId2=carModelId;
                            OwnerIdTxt2.text=CommonUtils.carPlateNumber2.toString()+","+ CommonUtils.carBrandNameApi2.toString()+","+ CommonUtils.carModelNameApi2.toString();
                          }
                          else if(tittle=="Car3 Details"){
                            CommonUtils.carPlateNumber3=carplatenumber.text;
                            CommonUtils.carBrandNameApi3=carBrandNameApi;
                            CommonUtils.carBrandId3=carBrandId;
                            CommonUtils.carModelNameApi3=carModelNameApi;
                            CommonUtils.carModelId3=carModelId;

                            OwnerIdTxt3.text=CommonUtils.carPlateNumber3.toString()+","+ CommonUtils.carBrandNameApi3.toString()+","+ CommonUtils.carModelNameApi3.toString();
                          }
                          else if(tittle=="Car4 Details"){
                            CommonUtils.carPlateNumber4=carplatenumber.text;
                            CommonUtils.carBrandNameApi4=carBrandNameApi;
                            CommonUtils.carBrandId4=carBrandId;
                            CommonUtils.carModelNameApi4=carModelNameApi;
                            CommonUtils.carModelId4=carModelId;
                            OwnerIdTxt4.text=CommonUtils.carPlateNumber4.toString()+","+ CommonUtils.carBrandNameApi4.toString()+","+ CommonUtils.carModelNameApi4.toString();
                          }
                          else if(tittle=="Car5 Details"){
                            CommonUtils.carPlateNumber5=carplatenumber.text;
                            CommonUtils.carBrandNameApi5=carBrandNameApi;
                            CommonUtils.carBrandId5=carBrandId;
                            CommonUtils.carModelNameApi5=carModelNameApi;
                            CommonUtils.carModelId5=carModelId;
                            OwnerIdTxt5.text=CommonUtils.carPlateNumber5.toString()+","+ CommonUtils.carBrandNameApi5.toString()+","+ CommonUtils.carModelNameApi5.toString();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () async {
                if (from.toString() == "MYID") {

                  CommonUtils.NAVIGATE_PATH = CommonUtils.MyidPage;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => ConsumerTab()));
                  // Navigator.pop(this.context, MaterialPageRoute(builder: (context) => Onboarding()));
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            title: Text("Profile"),
            backgroundColor: Maincolor,
            centerTitle: true,),
          body: LoadData(context),
        ));
  }

  Widget LoadData(BuildContext context) {
    return
      // Stack(
      // children: [
      //  Column(
      //   children: [
      //  Expanded(
      //   flex: 10,
      SingleChildScrollView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            GrayLine(),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon_fullname.png", width: 25, height: 25,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,

                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: TextField(
                          cursorColor: Colors.grey,
                          controller: FristName,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.grey, fontSize: 15

                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9a-zA-Z.@_]')),
                          ],
                          decoration: InputDecoration(
                            hintText: "Giver Name",
                            hintStyle: TextStyle(color: lightGrey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ),
            GrayLine(),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  children: [

                    Container(


                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [

                          Radio(
                            value: 1, groupValue: GednerId, onChanged: (value) {
                            setState(() {
                              GednerId = 1;
                              SelectGender = "Male";
                            });
                          },


                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => Maincolor),


                          ),
                          SizedBox(width: 12,),
                          Text("Male", style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey

                          ),),
                          Radio(value: 2,
                            groupValue: GednerId,
                            onChanged: (values) {
                              setState(() {
                                GednerId = 2;
                                SelectGender = "Female";
                              });
                            },


                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => Maincolor),

                          ),
                          Text("female", style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.grey,
                          ),),

                        ],
                      ),


                    ),
                  ],
                ),
              ),
            ),
            GrayLine(),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon_birthday.png", width: 25, height: 25,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,

                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: TextField(
                          controller: DoBTxt,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Date of Birth (DD/MM/YY)",
                            border: InputBorder.none,
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now().subtract(
                                  Duration(days: 1)),
                              firstDate: DateTime(
                                  1860),
                              //DateTime.now() - not to allow to choose before today.
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
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                DoBTxt.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ),
            GrayLine(),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon_mobile.png", width: 25, height: 25,),
                    SizedBox(width: 22,),
                    Container(
                      width: 45,
                      child: TextField(
                        enabled: false,
                        cursorColor: Colors.grey,
                        controller: Phonecode,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.grey, fontSize: 15

                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9a-zA-Z.@_]')),
                        ],
                        decoration: InputDecoration(
                          hintText: "+65",
                          hintStyle: TextStyle(color: lightGrey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    /*Text("+65",style: TextStyle(
                                    color: Colors.grey
                                ),),*/
                    SizedBox(width: 20,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,

                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          enabled: false,
                          cursorColor: Colors.grey,
                          controller: Mobilenum,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.grey, fontSize: 15

                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9a-zA-Z.@_]')),
                          ],
                          decoration: InputDecoration(
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(color: lightGrey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ),
            GrayLine(),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon_email.png", width: 25, height: 25,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,

                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: TextField(
                          enabled: false,
                          cursorColor: Colors.grey,
                          controller: EmailAddress,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.grey, fontSize: 15

                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9a-zA-Z.@_!#$%&*+-/=?^\`{|}~]')),
                          ],
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            hintStyle: TextStyle(color: lightGrey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ),


            Visibility(
              visible: false,
              child: Container(
                height: 40,

                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(value: 1,
                            groupValue: Buyer_seller,
                            onChanged: (value) {
                              setState(() {
                                Buyer_seller = 1;
                                SelectBuyer_seller = "Seller";
                              });
                            },


                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => Maincolor),


                          ),
                          SizedBox(width: 12,),
                          Text("Seller", style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey

                          ),),
                          Radio(value: 2,
                            groupValue: Buyer_seller,
                            onChanged: (values) {
                              setState(() {
                                Buyer_seller = 2;
                                SelectBuyer_seller = "Buyer";
                              });
                            },


                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => Maincolor),

                          ),
                          Text("Buyer", style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.grey,
                          ),),


                        ],
                      ),),

                    /* Expanded(
                                  flex: 1,
                                  child: InfoIconMessage(Infomessage: "Are you a buyer or seller of vehicle?"),)*/
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: backgroundcolor2, width: 0.5)
                    )
                ),
              ),
            ),

            GrayLine(),
            Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/home.png", width: 25, height: 25,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,

                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Stack(
                          children:[
                            TextField(
                              cursorColor: Colors.grey,
                              controller: addressTxt,
                              keyboardType: TextInputType.name,
                              style: TextStyle(color: backgroundcolor2, fontSize: 15

                              ),

                              decoration: InputDecoration(
                                hintText: "address",
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

                    ),
                  ],
                ),
              ),
            ),
            GrayLine(),
            // Car Details Started


            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child:Stack(
                  children: [
                    Container(
                      height: Contantheight,
                      child: Row(
                        children: [
                          Image.asset("assets/car.png", width: 25, height: 25,),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.7,

                            child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: TextField(
                                readOnly: true,
                                cursorColor: Colors.grey,
                                controller: OwnerIdTxt1,
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Car 1 Details",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        SignupCarSelectionFragment("Car1 Details");
                      },
                      child: SizedBox(width:double.infinity,
                      height: Contantheight,

                      ),
                    )
                  ],
                ),
              ),
            ),
            GrayLine(),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child:Stack(
                  children: [
                    Container(
                      height: Contantheight,
                      child: Row(
                        children: [
                          Image.asset("assets/car.png", width: 25, height: 25,),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.7,

                            child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: TextField(
                                readOnly: true,
                                cursorColor: Colors.grey,
                                controller: OwnerIdTxt2,
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Car 2 Details",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        SignupCarSelectionFragment("Car2 Details");
                      },
                      child: SizedBox(width:double.infinity,
                        height: Contantheight,

                      ),
                    )
                  ],
                ),
              ),
            ),
            GrayLine(),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child:Stack(
                  children: [
                    Container(
                      height: Contantheight,
                      child: Row(
                        children: [
                          Image.asset("assets/car.png", width: 25, height: 25,),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.7,

                            child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: TextField(
                                readOnly: true,
                                cursorColor: Colors.grey,
                                controller: OwnerIdTxt3,
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Car 3 Details",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        SignupCarSelectionFragment("Car3 Details");
                      },
                      child: SizedBox(width:double.infinity,
                        height: Contantheight,

                      ),
                    )
                  ],
                ),
              ),
            ),
            GrayLine(),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child:Stack(
                  children: [
                    Container(
                      height: Contantheight,
                      child: Row(
                        children: [
                          Image.asset("assets/car.png", width: 25, height: 25,),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.7,

                            child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: TextField(
                                readOnly: true,
                                cursorColor: Colors.grey,
                                controller: OwnerIdTxt4,
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Car 4 Details",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        SignupCarSelectionFragment("Car4 Details");
                      },
                      child: SizedBox(width:double.infinity,
                        height: Contantheight,

                      ),
                    )
                  ],
                ),
              ),
            ),
            GrayLine(),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child:Stack(
                  children: [
                    Container(
                      height: Contantheight,
                      child: Row(
                        children: [
                          Image.asset("assets/car.png", width: 25, height: 25,),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.7,

                            child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: TextField(
                                readOnly: true,
                                cursorColor: Colors.grey,
                                controller: OwnerIdTxt5,
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Car 5 Details",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        SignupCarSelectionFragment("Car5 Details");
                      },
                      child: SizedBox(width:double.infinity,
                        height: Contantheight,

                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () async {
                if (FristName.text.isEmpty) {
                  showAlertDialog_oneBtn(this.context, alert, enter_valid_name);
                }
                // else if (DoBTxt.text.isEmpty) {
                //   showAlertDialog_oneBtn(this.context, alert1, choose_date);
                // }
                else {
                  var fName = FristName.text.toString();
                  //   var sname = SecondName.text.toString();
                  var Gender = SelectGender;
                  var Dob = DoBTxt.text.toString();
                  var email = EmailAddress.text.toString();
                  var num = Phonecode.text.toString() + "," +
                      Mobilenum.text.toString();
                  // var Promotioupdatevia = updateVia;
                  /*if(SelectBuyer_seller == "Buyer"){
                                 brokettype = "BUYER";
                              }
                              else if(SelectBuyer_seller == "Seller"){
                                 brokettype = "SELLER";
                              }
                              else{
                                brokettype ="";
                              }*/

                  var vehiclenu = addressTxt.text.toString();
                  var owneridd = OwnerIdTxt1.text.toString();
                  //  print(brokettype+":"+vehiclenu+":"+owneridd);
                  var connectivityresult = await(Connectivity()
                      .checkConnectivity());
                  if (connectivityresult == ConnectivityResult.mobile ||
                      connectivityresult == ConnectivityResult.wifi) {
                    print("connecr");
                    showLoadingView(context);
                    _UpdateProfile(
                        fName,
                        Gender,
                        Dob,
                        num,
                        email,
                        vehiclenu,
                        owneridd);
                  }
                  else {
                    showAlertDialog_oneBtn(this.context, "Network",
                        "Internet Connection. Please turn on Internet Connection");
                    print("notttt");
                  }
                }
                // Validation


              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                child: Container(
                  height: 40,

                  decoration: BoxDecoration(
                    color: poketblue2,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),

                  child: Center(child: Text(
                    save, style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,)),
                ),
              ),
            ),
          ],
        ),
      );
    //  ),


    //   ],

    //   );


    // ],

    // );

  }

  _GetProfile() async {
    final http.Response response = await http.post(Uri.parse(PROFILE_URL),
        body: {
          "consumer_id": CommonUtils.consumerID.toString(),
          "action_event": "1"
        }
    ).timeout(Duration(seconds: 30));
    print(response.body);
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      print(newData);
      var frist_name = Utils().stringSplit(
          newData['p2']); //frist name//second name
      var gender = Utils().stringSplit(newData['p3']); //gender
      var DOB = Utils().stringSplit(newData['p4']); //DOB
      var Email = Utils().stringSplit(newData['p5']); //Email
      var mobile_num = Utils().stringSplit(newData['p6']);
      var address1 = Utils().stringSplit(newData['p7']);
      var address2 = Utils().stringSplit(newData['p8']);

      var ownerId1 = Utils().stringSplit(newData['p9']);
      var ownerId2 = Utils().stringSplit(newData['p10']);
      var ownerId3 = Utils().stringSplit(newData['p11']);
      var ownerId4 = Utils().stringSplit(newData['p12']);
      var ownerId5 = Utils().stringSplit(newData['p13']);

      var brandName1 = Utils().stringSplit(newData['p14']);
      var brandName2 = Utils().stringSplit(newData['p15']);
      var brandName3 = Utils().stringSplit(newData['p16']);
      var brandName4 = Utils().stringSplit(newData['p17']);
      var brandName5 = Utils().stringSplit(newData['p18']);

      var model1 = Utils().stringSplit(newData['p19']);
      var model2 = Utils().stringSplit(newData['p20']);
      var model3 = Utils().stringSplit(newData['p21']);
      var model4 = Utils().stringSplit(newData['p22']);
      var model5 = Utils().stringSplit(newData['p23']);



      if (mobile_num.contains(",")) {
        var numm = mobile_num.split(",");
        Mobilenum.text = numm[1];
        if (numm[0].contains("+")) {
          Phonecode.text = numm[0];
        } else {
          Phonecode.text = "+" + numm[0];
        }
      }
      else {
        Mobilenum.text = mobile_num;
      }


      FristName.text = frist_name;

      if (DOB == "none") {
        DoBTxt.text = "";
      }
      else {
        DoBTxt.text = DOB;
      }
      EmailAddress.text = Email;
      addressTxt.text = address1+" "+address2;

      if(ownerId1=="none"){
        CommonUtils.carPlateNumber1="";
      }
      else{
        CommonUtils.carPlateNumber1=ownerId1;
      }

      if(ownerId2=="none"){
        CommonUtils.carPlateNumber2="";
      }
      else{
        CommonUtils.carPlateNumber2=ownerId2;
      }

      if(ownerId3=="none"){
        CommonUtils.carPlateNumber3="";
      }
      else{
        CommonUtils.carPlateNumber3=ownerId3;
      }

      if(ownerId4=="none"){
        CommonUtils.carPlateNumber4="";
      }
      else{
        CommonUtils.carPlateNumber4=ownerId4;
      }

      if(ownerId5=="none"){
        CommonUtils.carPlateNumber5="";
      }
      else{
        CommonUtils.carPlateNumber5=ownerId5;
      }



      if(ownerId1!="none"){

        CommonUtils.carBrandId1=brandName1.toString().split(":")[0];
        CommonUtils.carModelId1=model1.toString().split(":")[0];
        OwnerIdTxt1.text = ownerId1+","+brandName1.toString().split(":")[1]+","+model1.toString().split(":")[1];
      }
      if(ownerId2!="none"){
        CommonUtils.carBrandId2=brandName2.toString().split(":")[0];
        CommonUtils.carModelId2=model2.toString().split(":")[0];
        OwnerIdTxt2.text = ownerId2+","+brandName2.toString().split(":")[1]+","+model2.toString().split(":")[1];
      }
      if(ownerId3!="none"){
        CommonUtils.carBrandId3=brandName3.toString().split(":")[0];
        CommonUtils.carModelId3=model3.toString().split(":")[0];
        OwnerIdTxt3.text = ownerId3+","+brandName3.toString().split(":")[1]+","+model3.toString().split(":")[1];
      }
      if(ownerId4!="none"){
        CommonUtils.carBrandId4=brandName4.toString().split(":")[0];
        CommonUtils.carModelId4=model4.toString().split(":")[0];
        OwnerIdTxt4.text = ownerId4+","+brandName4.toString().split(":")[1]+","+model4.toString().split(":")[1];
      }

      if(ownerId5!="none"){

        CommonUtils.carBrandId5=brandName5.toString().split(":")[0];
        CommonUtils.carModelId5=model5.toString().split(":")[0];
        OwnerIdTxt5.text = ownerId5+","+brandName5.toString().split(":")[1]+","+model5.toString().split(":")[1];
      }






      setState(() {

        if (gender == "male") {
          GednerId = 1;
          SelectGender = "Male";
        }
        else if (gender == "female") {
          GednerId = 2;
          SelectGender = "Female";
        }
        else {
          GednerId = 0;
        }
      });
    }
  }

  _UpdateProfile(var Fname, Gender, Dob, Phone, Email, vehiclenu,
      owneridd) async {

    print(CommonUtils.carBrandId1.toString());
    print(CommonUtils.carBrandId2.toString());
    print(CommonUtils.carBrandId3.toString());
    print(CommonUtils.carBrandId4.toString());
    print(CommonUtils.carBrandId5.toString());


    print(CommonUtils.carModelId1.toString());
    print(CommonUtils.carModelId2.toString());
    print(CommonUtils.carModelId3.toString());
    print(CommonUtils.carModelId4.toString());
    print(CommonUtils.carModelId5.toString());


    print(PROFILE_URL.toString());

    final http.Response response = await http.post(Uri.parse(PROFILE_URL),
        body: {
          "consumer_id": CommonUtils.consumerID.toString(),
          "action_event": "2",
          "cma_timestamps": Utils().getTimeStamp(),
          "time_zone": Utils().getTimeZone(),
          "software_version": CommonUtils.softwareVersion,
          "os_version": CommonUtils.osVersion,
          "phone_model": CommonUtils.deviceModel,
          "device_type": CommonUtils.deviceType,
          'consumer_application_type': CommonUtils.consumerApplicationType,
          'consumer_language_id': CommonUtils.consumerLanguageId,

          "full_name": FristName.text.toString(),
          "gender":SelectGender.toString(),
          "phone_no" : countrycode+Mobilenum.text.toString(),
          "email":EmailAddress.text.toString(),
          "date_of_birth":DoBTxt.text.toString(),
          "user_address":  addressTxt.text,


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

        }

    ).timeout(Duration(seconds: 30));
    print(response.body.toString());
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = jsonDecode(jsonstring);
    var newData = data['info'];
    var Mesage = Utils().stringSplit(newData['p2']);
    var status = Utils().stringSplit(newData['p1']);
    if (status.toLowerCase().toString() == "true") {
      CommonUtils.consumerName = Fname.toString();
    }

    if (Platform.isAndroid) {
      showAlertDialog_oneBtnWitDismissp(context, "Alert", Mesage);
    }
    if (Platform.isIOS) {
      ShowNativeDialogue(context, "Alert", Mesage).then((value) =>
          Navigator.pop(context));
    }
  }

//}

  void showAlertDialog_oneBtnWitDismissp(BuildContext context, String tittle,
      String message) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message, style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: () {
            if (from.toString() == "MYID") {

              CommonUtils.NAVIGATE_PATH = CommonUtils.MyidPage;
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => ConsumerTab()));
              // Navigator.pop(this.context, MaterialPageRoute(builder: (context) => Onboarding()));
            } else {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            }

          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child: Center(
                  child: Text(ok, style: TextStyle(color: Maincolor),)),
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
}

class GrayLine extends StatelessWidget {
  const GrayLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: SizedBox(
        height: 0.5,
        width: double.infinity,
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }


}


