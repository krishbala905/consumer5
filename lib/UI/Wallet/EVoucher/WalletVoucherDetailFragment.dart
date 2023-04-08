import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import 'package:http/http.dart' as http;

import '../Models/Card/ECardAllDetailsModel.dart';
import '../Models/Card/WalletmodelNew.dart';
import '../Models/Card/WalletmodelVoucher1New.dart';


class WalletVoucherDetailFragment extends StatefulWidget {
  late WalletmodelVoucher1New object1;
  WalletVoucherDetailFragment(this.object1, {Key? key}) : super(key: key);

  @override
  State<WalletVoucherDetailFragment> createState() => _WalletVoucherDetailFragmentState( object1);
}

class _WalletVoucherDetailFragmentState extends State<WalletVoucherDetailFragment> {
  WalletmodelVoucher1New object1;

  bool ShowDescription = true;
  bool Showdescription = true;
  bool ShowTermsTxt = true;
  _WalletVoucherDetailFragmentState(this.object1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _ECard1(context),
      ),
    );
  }
  Future<ECardAllDetailsModel> getEcardData1() async {


    final http.Response response = await http.post(
      Uri.parse(BASEURL1+"newapi/MBMNewUiPoketWalletCardDetailsCmd"),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':"5",
        'consumer_language_id':CommonUtils.APPLICATIONLANGUAGEID,

        "member_id":object1.member_id,
        "program_id":object1.program_id,
        "program_type":object1.program_type,
      },
    ).timeout(Duration(seconds: 30));

    print("Gokul");
    debugPrint("Detaislpage"+response.body.toString(),wrapWidth: 1024);
    if (response.statusCode == 200 ) {
      print("Gokul1");
      late Map<String , dynamic> data;
      try{
        data=jsonDecode(response.body)["data"];
      }
      catch (e){
        print("Gokul122:"+e.toString());
      }


      print("Gokul2:"+data.isEmpty.toString());
      var eCardAllDetailsModel =ECardAllDetailsModel.fromJson(data);
      print("Gokul3");
      debugPrint("eCardAllDetailsModel : "+eCardAllDetailsModel.toJson().toString());
      return eCardAllDetailsModel;
    }
    else {

      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<ECardAllDetailsModel> _ECard1(BuildContext context) {

    return FutureBuilder<ECardAllDetailsModel>(

      future: getEcardData1(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          final ECardAllDetailsModel? posts = snapshot.data;

          if(posts!=null){
            //  if(snapshot.data!.length!=0){
            return _buildPostsHome1(context, posts);
          }

          else{

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(child: Text("Details Not Found",style: TextStyle(color: corporateColor,fontSize: 15),)),
                SizedBox(height: 10,),
                //  Center(child: Text(merchant_instruc_for_card,style: TextStyle(color: Colors.black54,fontSize: 12),)),
              ],
            );
          }
        }

        else {
          return Center(
            child:SpinKitCircle(
              color: corporateColor,
              size: 30.0,
            ),
          );
        }
      },
    );
  }
  Widget _buildPostsHome1(BuildContext context,ECardAllDetailsModel post) {


    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Center(
            child: ClipRRect(borderRadius: BorderRadius.circular(20),
              child: Image.network(object1.img_url,width: MediaQuery.of(context).size.width/1.75,),),
          ),
          SizedBox(height: 10,),
          Container(height: 1,width: double.infinity,color: Colors.black38,),
          SizedBox(height: 10,),
          Text(object1.program_title,style: TextStyle(color: poketPurple,fontSize: 15),),
          SizedBox(height: 10,),
          Row(
            children: [
              Text("Expiry:",style: TextStyle(color: Colors.black54,fontSize: 15),),
              Text("  "+object1.expire_date,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
            ],
          ),
          SizedBox(height: 10,),
          Container(height: 1,width: double.infinity,color: Colors.black38,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Benefits",style: TextStyle(color: poketPurple,fontSize: 15),),
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
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Visibility(
              visible: ShowDescription,
              child: Text(decodeBase64(post.cardData?.Description),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(height: 1,width: double.infinity,color: Colors.black38,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Terms",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: poketPurple),
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
                decodeBase64(post.cardData?.Tnc),

                maxLines: 2,

                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(height: 1,width: double.infinity,color: Colors.black38,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Participating Outlets",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: poketPurple),
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
          if(post.locations?.length!=0)
            Visibility(visible: Showdescription,
                child: _buildparticipatingoutlet(context, post)),

        ],
      ),
    );
  }

  Widget _buildparticipatingoutlet(BuildContext context, ECardAllDetailsModel object1) {
    if (object1 == null) {
      return Container();
    } else {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: object1.locations?.length,
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
                                  child: Text(object1.locations?[index].shop_name,
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
                            Text(object1.locations?[index].building_name,
                              style: TextStyle(fontSize: 12, color: Colors.grey),),
                            SizedBox(height: 5,),
                            Text(decodeBase64(object1.locations?[index].address),
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
                                      _launchCaller(object1.locations?[index].tel.toString());
                                    },
                                    child: Center(child: Text(
                                      object1.locations?[index].tel,
                                      style: TextStyle(fontSize: 11),)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text(
                              convertBrkToNewLine(object1.locations?[index].openinghrs),
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


  String decodeBase64(var data){
    return utf8.decode(base64.decode(data)).replaceAll("<br>", "\n");
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

  String convertBrkToNewLine(var data){

    return data.toString().replaceAll("<br>", "\n");

  }
}

