import 'dart:convert';
import 'package:consumer5/UI/Wallet/Models/WalletmodelNew.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:consumer5/Others/AlertDialogUtil.dart';
import 'package:consumer5/Others/CommonUtils.dart';
import 'package:consumer5/Others/Utils.dart';
import 'package:consumer5/UI/ConsumerTab.dart';
import 'package:consumer5/res/Colors.dart';
import 'package:consumer5/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Others/Urls.dart';
import 'package:consumer5/UI/Wallet/Models/ParticipatingOutletmodel.dart';
import 'package:consumer5/UI/Wallet/Models/WalletViewmodel.dart';
import 'package:xml2json/xml2json.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletDetailFragment extends StatefulWidget {
  final WalletmodelNew Object1;
   WalletDetailFragment({Key? key,required this.Object1}) : super(key: key);

  @override
  State<WalletDetailFragment> createState() => _WalletDetailFragmentState(this.Object1);
}

class _WalletDetailFragmentState extends State<WalletDetailFragment> {
  WalletmodelNew Object1;
  var fulrnuno;
  bool ShowDescription = true;
  bool Showdescription = true;
  bool ShowTermsTxt = true;
  _WalletDetailFragmentState(this.Object1);
  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child:
    Scaffold(

      //appBar: AppBar(title: Text(Object1.merchantName),backgroundColor: Maincolor,centerTitle: true,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(child: Image.network(Object1.img_url,fit: BoxFit.fill,height: MediaQuery.of(context).size.height * 0.2,)),
            SizedBox(height: 5,),

            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: false,
              child: Center(child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: Maincolor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                child: InkWell(
                  onTap: (){
                    clickredeem();
                  },
                  child: Center(
                      child: Text(
                        "Use Manual Redemption",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
                ),
            ),

            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 0.5,
              width: double.infinity,
              child: Container(
                color: poketPurple,
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(Object1.program_title,style: TextStyle(fontSize: 17,color: poketPurple),),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(expiry+ Object1.expire_date,style: TextStyle(fontSize: 12),),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 0.5,
              width: double.infinity,
              child: Container(
                color: poketPurple,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Benefits",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: poketPurple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {
                        print("hellooo");
                        setState(() {
                          ShowDescription = !ShowDescription;
                        });
                      },
                      child: ShowDescription == false
                          ? Image.asset(
                        "assets/ic_more.png",
                        width: 20,
                        height: 20,
                      )
                          : Image.asset(
                        "assets/ic_less.png",
                        width: 20,
                        height: 20,
                      )),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Visibility(
                visible: ShowDescription,
                child: Text(
                  "Benefits",
                  // Object1.benefits.toString().replaceAll("\\n", "\n"),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 0.5,
              width: double.infinity,
              child: Container(
                color: poketPurple,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Terms",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: poketPurple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {
                        print("hellooo");
                        setState(() {
                          ShowTermsTxt = !ShowTermsTxt;
                        });
                      },
                      child: ShowTermsTxt == false
                          ? Image.asset(
                        "assets/ic_more.png",
                        width: 20,
                        height: 20,
                      )
                          : Image.asset(
                        "assets/ic_less.png",
                        width: 20,
                        height: 20,
                      )),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Visibility(
                visible: ShowTermsTxt,
                child: Text(
                  // Object1.tnc.toString().replaceAll("\\n", "\n"),
                  "TNC",

                  maxLines: 2,

                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 0.5,
              width: double.infinity,
              child: Container(
                color: poketPurple,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Participating Outlets",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: poketPurple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {
                        print("hellooo");
                        setState(() {
                          Showdescription = !Showdescription;
                        });
                      },
                      child: Showdescription == false
                          ? Image.asset(
                        "assets/ic_more.png",
                        width: 20,
                        height: 20,
                      )
                          : Image.asset(
                        "assets/ic_less.png",
                        width: 20,
                        height: 20,
                      )),
                )
              ],
            ),
            // if(Object1.outletList.length.toString()!="0")
            //   Visibility(visible: Showdescription,
            //       child: _buildparticipatingoutlet(context, Object1)),
            //


          ],

        ),
      )
    ),
    );
  }

/* Future<List<ParticipatingOutletmodel>> getParticipatingOutlet(WalletViewmodel object) async {

  print("OutletDetailsCmdUrl:"+PARTICIPATINGOUTLETCMD);
  print("prgmId:"+object.programID.toString());

   final http.Response response = await http.post(
     Uri.parse(PARTICIPATINGOUTLETCMD),

     body: {
       "device_type":CommonUtils.deviceType,
       "software_version":CommonUtils.softwareVersion,
       "os_version":CommonUtils.osVersion,
       "device_model":CommonUtils.deviceModel,
       "device_imei":"",
       "time_zone":Utils().getTimeZone(),
       'consumer_application_type':CommonUtils.consumerApplicationType,
       'consumer_language_id':CommonUtils.consumerLanguageId,
       'country_index':"191",
       'program_id':object.programID,
       "consumer_id": CommonUtils.consumerID.toString(),

     },
   ).timeout(Duration(seconds: 30));


   print(response.body.toString());
  if(response.statusCode==200 && jsonDecode(response.body)["status"] == "True") {
    List<dynamic> body = jsonDecode(response.body)["outlet_data"];
    print("hdjek"+body.toString());
    List<ParticipatingOutletmodel> posts1 = body.map((dynamic item) =>
        ParticipatingOutletmodel.fromJson(item),).toList();
    print("hdjek"+posts1.toString());
    return posts1;
  }
   else {

     throw "Unable to retrieve posts.";
   }

 }*/

 /*FutureBuilder<List<ParticipatingOutletmodel>> _buildparticipatingoutletFutureBuilde(BuildContext context , WalletViewmodel object) {

   return FutureBuilder<List<ParticipatingOutletmodel>>(

     future: getParticipatingOutlet(object),
     builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.done) {
         final List<ParticipatingOutletmodel>? posts = snapshot.data;
         if(posts!=null && posts.isNotEmpty){
           print("jekdjg"+posts.toString());
           return _buildparticipatingoutlet(context, posts);}
         else{
           return Container(

           );
         }
       } else {
         return Center(
           child:SpinKitCircle(
             color: Maincolor,
             size: 30.0,
           ),
         );
       }
     },
   );
 }
*/

  Widget setFullRunNO(String data){
    fulrnuno=data;
    return Text(data,
      style:  TextStyle(fontSize: 12),
    );
  }

  Future<void> clickredeem() {
    TextEditingController mTxtRedeemCodeController=TextEditingController();
    TextEditingController mTxtRemarksController=TextEditingController();
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

              height: 200,
              child: Padding(

                padding: const EdgeInsets.only(left:15.0,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
                    SizedBox(height: 10,),
                    TextField(
                      controller: mTxtRedeemCodeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[

                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly

                      ],
                      decoration: InputDecoration(

                        hintText: "Enter Reedemption Code",
                        hintStyle: TextStyle(fontSize: 17,color: Colors.grey),

                        enabledBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey,),
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey,),
                        ),

                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        controller: mTxtRemarksController,

                        decoration: InputDecoration(
                          hintText: "Remarks",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        )
                    ),

                    SizedBox(height: 20,),
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
                            if(mTxtRedeemCodeController.text.toString()!=""){
                              showLoadingView(context);
                              var connectivityresult = await(Connectivity().checkConnectivity());
                              if(connectivityresult == ConnectivityResult.mobile || connectivityresult == ConnectivityResult.wifi ) {
                                print("connecr");
                               Navigator.pop(context, true);
                                callRedeemAPIForVoucher(mTxtRedeemCodeController.text,mTxtRemarksController.text);
                              }
                              else{
                                showAlertDialog_oneBtnWitDismiss(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
                                print("notttt");

                              }
                            }
                            else{
                              showAlertDialog_oneBtn(context, alert, "Please fill in all the fields");
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
                    SizedBox(height: 20,),
                  ],

                ),
              ),
            ),
          );
        }
    );
  }
 Future<void> callRedeemAPIForVoucher(var redeemCode,var remarks) async {
   // showLoadingView(context);

   final http.Response response = await http.post(
     Uri.parse(REDEEMVOUCHER_URL),

     body: {
       "consumer_id": CommonUtils.consumerID.toString(),
       "program_id": Object1.program_id.toString(),
       "redemption_code":redeemCode.toString(),
       "remarks":remarks.toString(),
       "serial_no":memberid.toString(),
       "merchant_id":Object1.merchant_id.toString(),
       'merchant_country_index':"191",
       'country_index':"191",
       // "serial_no":Object1.serialnumber.toString()
       "serial_no":"serial"

     },
   ).timeout(Duration(seconds: 30));



   print(response.statusCode.toString());


   // Navigator.pop(context);
   print("Mres:${response.body.toString()}");
   if (response.statusCode == 200) {
     final Xml2Json xml2json = new Xml2Json();
     xml2json.parse(response.body);
     var jsonstring = xml2json.toParker();
     var data = jsonDecode(jsonstring);
     var newData = data['info'];
     var status = Utils().stringSplit(newData['p1']);

     var message = Utils().stringSplit(newData['p2']);

     var p3 = Utils().stringSplit(newData['p3']);

     if ( status=="True") {
       showAlertDialog_oneBtnWitDismissrdeem(context, alert, message);
     }
     else { showAlertDialog_oneBtnWitDismiss(context, alert, "Invalid Redemption Code");}
   }

   else {showAlertDialog_oneBtn(context, alert1, something_went_wrong1);}
 }
 void showAlertDialog_oneBtnWitDismissrdeem(BuildContext context,String tittle,String message)
 {
   AlertDialog alert = AlertDialog(
     backgroundColor: Colors.white,
     title: Text(tittle),
     // content: CircularProgressIndicator(),
     content: Text(message,style: TextStyle(color: Colors.black45)),
     actions: [
       GestureDetector(
         onTap: (){
           Navigator.pop(context);
           print("refreshcheck");
           CommonUtils.NAVIGATE_PATH=CommonUtils.walletPage;
           Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (_) => ConsumerTab()));
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

       Navigator.pop(context);
     } else {
       // user pressed No button
     }
   });

 }
}
_launchCaller(mobile) async {

  final Uri launchUri=Uri(
    scheme: 'tel',
    path: mobile,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $mobile';
  }
}
Widget _buildparticipatingoutlet(BuildContext context, WalletViewmodel object1) {
  if (object1 == null) {
    return Container();
  } else {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: object1.outletList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 10,),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(object1.outletName[index],
                                  style: TextStyle(fontSize: 14),maxLines: 2,softWrap: true,),
                              ),
                              /*Container(
                              height: 18,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),*/


                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset("assets/ic_map.png",width: 40,),
                              ),
                              //  ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(object1.outletBuiding[index],
                            style: TextStyle(fontSize: 12, color: Colors.grey),),
                          SizedBox(height: 5,),
                          Text(object1.outletAddress[index],
                            style: TextStyle(fontSize: 12, color: Colors.grey),),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 0.5,
                            width: double.infinity,
                            child: Container(
                              color: poketPurple,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Operating Hours",
                                style: TextStyle(fontSize: 11),),
                              Container(
                                height: 18,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey),
                                ),


                                child: InkWell(
                                  onTap: (){
                                    _launchCaller(object1.outletContact[index].toString());
                                  },
                                  child: Center(child: Text(
                                    object1.outletContact[index],
                                    style: TextStyle(fontSize: 11),)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Text(object1.outletOpHours[index].toString(),
                            style: TextStyle(fontSize: 12, color: Colors.grey),),


                        ],


                      ),
                    ],


                  ),
                ),
              ),
            ),
          );
        });
  }
}
/*ListView _buildparticipatingoutlet(BuildContext context, <WalletViewmodel> object1) {
  print(object1.length.toString());
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: object1.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 10,),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(object1[index].shop_name,
                              style: TextStyle(fontSize: 14),),
                            *//*Container(
                              height: 18,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),*//*


                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset("assets/ic_map.png",width: 40,),
                            ),
                          //  ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(object1[index].building_name,
                          style: TextStyle(fontSize: 12, color: Colors.grey),),
                        SizedBox(height: 5,),
                        Text(object1[index].address,
                          style: TextStyle(fontSize: 12, color: Colors.grey),),
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 0.5,
                          width: double.infinity,
                          child: Container(
                            color: poketPurple,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Operating Hours",
                              style: TextStyle(fontSize: 11),),
                            Container(
                                height: 18,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey),
                                ),


                                  child: InkWell(
                                    onTap: (){
                                      _launchCaller(object1[index].tel.toString());
                                    },
                                    child: Center(child: Text(
                                      object1[index].tel,
                                      style: TextStyle(fontSize: 11),)),
                                  ),
                                ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text(object1[index].opening_hrs.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.grey),),


                      ],


                    ),
                  ],


                ),
              ),
            ),
          ),
        );
      });


}*/
