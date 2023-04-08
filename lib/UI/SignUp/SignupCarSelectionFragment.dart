import 'dart:convert';

import 'package:consumer5/Others/AlertDialogUtil.dart';
import 'package:consumer5/UI/SignUp/CarDetailsModel.dart';
import 'package:consumer5/UI/SignUp/SecondSignupScreen.dart';
import 'package:consumer5/UI/SignUp/Signupfragment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import '../More/Profile.dart';

class SignupCarSelectionFragment extends StatefulWidget {
  var tittle;
  var from;

  SignupCarSelectionFragment(this.tittle,this.from);

  @override
  State<SignupCarSelectionFragment> createState() => _SignupCarSelectionFragmentState(tittle,from);
}

class _SignupCarSelectionFragmentState extends State<SignupCarSelectionFragment> {
  var tittle;

  TextEditingController carplatenumber = TextEditingController();


  List posts2=[];

  String carBrand_temp_hint="Car Brand";
  String carModel_temp_hint="Car Model";

  List carModelList=[];

  var carModelName;
  var carModelNameApi;
  var carModelId;


  var carBrandName;
  var carBrandNameApi;
  var carBrandId;

  var from;

  _SignupCarSelectionFragmentState(this.tittle,this.from);

  @override
  void initState() {
    // TODO: implement initState
    checkeligibilty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:[
            // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
            SizedBox(height: 125,),
            Center(
              child: Text(tittle,style: TextStyle(color: Colors.black),),
            ),
            SizedBox(height: 5,),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context,true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: poketblue2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 35,
                    width: 100,

                    child: Center(
                        child: Text(
                          cancel_caps,
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: () async{
                    print(tittle);
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
                      }
                      else if(tittle=="Car2 Details"){
                        CommonUtils.carPlateNumber2=carplatenumber.text;
                        CommonUtils.carBrandNameApi2=carBrandNameApi;
                        CommonUtils.carBrandId2=carBrandId;
                        CommonUtils.carModelNameApi2=carModelNameApi;
                        CommonUtils.carModelId2=carModelId;
                      }
                      else if(tittle=="Car3 Details"){
                        CommonUtils.carPlateNumber3=carplatenumber.text;
                        CommonUtils.carBrandNameApi3=carBrandNameApi;
                        CommonUtils.carBrandId3=carBrandId;
                        CommonUtils.carModelNameApi3=carModelNameApi;
                        CommonUtils.carModelId3=carModelId;
                      }
                      else if(tittle=="Car4 Details"){
                        CommonUtils.carPlateNumber4=carplatenumber.text;
                        CommonUtils.carBrandNameApi4=carBrandNameApi;
                        CommonUtils.carBrandId4=carBrandId;
                        CommonUtils.carModelNameApi4=carModelNameApi;
                        CommonUtils.carModelId4=carModelId;
                      }
                      else if(tittle=="Car5 Details"){
                        CommonUtils.carPlateNumber5=carplatenumber.text;
                        CommonUtils.carBrandNameApi5=carBrandNameApi;
                        CommonUtils.carBrandId5=carBrandId;
                        CommonUtils.carModelNameApi5=carModelNameApi;
                        CommonUtils.carModelId5=carModelId;
                      }
                      carplatenumber.dispose();
                      if(from==0) {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) =>
                            SecondSigupScreen(Data: CommonUtils.SignupData),));
                      }
                      else{
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) =>
                            ProfileFragment("Profile"),));
                      }

                    }



                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: poketblue2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 35,
                    width: 100,

                    child: Center(
                        child: Text(
                          ok,
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),

              ],
            ),
          ],

        ),
      )
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
      List<CarDetailsModel> posts = body.map((dynamic item) => CarDetailsModel.fromJson(item),).toList();
      setState(() {
        posts2=body.toList();
      });

    }

  }
}
