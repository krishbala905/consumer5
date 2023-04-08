import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:consumer5/Others/CommonUtils.dart';
import 'package:consumer5/Others/Urls.dart';
import 'package:consumer5/Others/Utils.dart';
import 'package:consumer5/UI/Browse/Detail%20Page/BrowseCardDetailModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Others/AlertDialogUtil.dart';
import '../../../Others/NativeAlertDialog.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import '../../ConsumerTab.dart';
class BrowseVoucherDetailFragment extends StatefulWidget {
  final String Programid;
  final String MerchantId;
  final String CurrentPrice;
  final String OriginalPrice;
  final String Voucherimage;
  final String voucherimage;
  final String programtype;
  final String programname;
  final String outletid;
  final String emailid;
  final String phoneno;
  const BrowseVoucherDetailFragment({Key? key,required this.Programid,required this.MerchantId,required this.CurrentPrice,required this.OriginalPrice,required this.Voucherimage,required this.programtype,required this.outletid, required this.emailid,required this.phoneno,required this.voucherimage,required this.programname}) : super(key: key);

  @override
  State<BrowseVoucherDetailFragment> createState() => _BrowseVoucherDetailFragmentState(this.MerchantId,this.Programid,this.CurrentPrice,this.OriginalPrice,this.Voucherimage,this.programtype,this.outletid,this.emailid,this.phoneno,this.voucherimage,this.programname);
}

class _BrowseVoucherDetailFragmentState extends State<BrowseVoucherDetailFragment> {
  var BenifitVisible = true;
  var merchantVisible = true;
  var TncVisible = true;
  var RewardImageVisible = true;
  var RewardImgIndex = 0;
  var OutletVisible= true;
  String MerchantId;
  String Programid;
  String CurrentPrice;
  String OriginalPrice;
  String Voucherimage;
  String programtype;
  String outletid;
  String phoneno;
  String emailid;
  String voucherimage;
  String programname;
  _BrowseVoucherDetailFragmentState(this.MerchantId,this.Programid,this.CurrentPrice,this.OriginalPrice,this.Voucherimage,this.programtype,this.outletid, this.emailid, this.phoneno,this.voucherimage,this.programname);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(


            appBar: AppBar(title: Text("MBM Wheelpower"), backgroundColor: Maincolor,  centerTitle: true,),

            body: Column(
              children: [
                Expanded(
                    flex: 11,
                    child: LoadDetailPage(context)),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Column(
                        children: [
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  _launchCaller(phoneno);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.call_outlined,color: Colors.red,),
                                    SizedBox(width: 10,),
                                    Text("Call us",style: TextStyle(color: Colors.grey),)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  _launchEmail(emailid);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.email_outlined,color: Colors.red,),
                                    SizedBox(width: 10,),
                                    Text("Email us",style: TextStyle(color: Colors.grey))
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 7,),*/
                          Text( CurrentPrice == "Free" ? "Free": OriginalPrice.toString(),style: TextStyle(color: poketpurple),),
                          SizedBox(height: 7,),
                          CurrentPrice == "Lock" ? Icon(CupertinoIcons.lock,color: Colors.grey,size: 25,):
                          InkWell(
                            onTap: (){
                              showAlertForGetit(Programid,programtype,outletid);
                            },
                            child: Container(
                              height: 28,
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                color: poketblue2,
                                  border: Border.all(color: poketblue2,width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(20))

                              ),
                              child: Center(child: Text("GET",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            )
        ));
  }
  FutureBuilder<List<BrowseCardDetailModel>> LoadDetailPage(
      BuildContext context) {
    return FutureBuilder<List<BrowseCardDetailModel>>(
        future: getEcardData(),
        builder: (context, snapchat) {
          if (snapchat.data != null) {
            final List<BrowseCardDetailModel> res = snapchat.data!;
            return SingleChildScrollView(
                child: Singlechildsrollwidget(context, res));
          }
          // if (snapchat.connectionState == ConnectionState.done) {
          //   final BrowseCardDetailModel res = snapchat.data!;
          //   return Singlechildsrollwidget(context, res);
          // }
          else {
            return Center(
              child:SpinKitCircle(
                color: corporateColor,
                size: 30.0,
              ),
            );;
          }



        });
  }
  Widget Singlechildsrollwidget(BuildContext context, List<BrowseCardDetailModel> Object) {
    print("chck" + Object[0].programImageURLs[0].toString());
    print("chck" + Object[0].merchantLogoURL[0].toString());
    var merchantinfor = Object[0].merchantinfo.toString().replaceAll("\\n", "\n");
    merchantinfor = merchantinfor.replaceAll("\\", "");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          child: Stack(
            children: [
              Center(
                  child: Image.network(
                    voucherimage.toString(),
                    height: 180,
                    width: 220,
                    fit: BoxFit.fitWidth,
                  )),
              /*Positioned(
                  top: 20,
                  left: 20,
                  bottom: 20,
                  child:Icon(Icons.arrow_back_ios,size: 30,)

              ),
              Positioned(
                  top: 20,
                  right: 20,
                  bottom: 20,
                  child:Icon(Icons.arrow_forward_ios,size: 30,)

              )*/
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 0.5,
            width: double.infinity,
            child: Container(
              color: poketpurple,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              programname.toString(),
                style: TextStyle(fontSize: 15, color: poketpurple),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text("Expiry: " + Object[0].expiryDetails.toString())
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 0.5,
            width: double.infinity,
            child: Container(
              color: poketpurple,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Benefits",
                style: TextStyle(fontSize: 15, color: poketpurple),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      BenifitVisible = !BenifitVisible;
                    });
                  },
                  child: Icon(
                    BenifitVisible
                        ? CupertinoIcons.minus_circle
                        : Icons.add_circle_outline,
                    color: poketpurple,
                    size: 25,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Visibility(
            maintainAnimation: true,
            visible: BenifitVisible,
            maintainState: true,
            //maintainAnimation: false,

            child: Text(
              Object[0].benefits.replaceAll("<br>", "\n"),
              style: TextStyle(color: Colors.grey),
            ),
            replacement: SizedBox(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 0.5,
            width: double.infinity,
            child: Container(
              color: poketpurple,
            ),
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rewards",
                style: TextStyle(fontSize: 15, color: poketpurple),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      rewardVisible = !rewardVisible;
                    });
                  },
                  child: Icon(
                    rewardVisible
                        ? CupertinoIcons.minus_circle
                        : Icons.add_circle_outline,
                    color: poketpurple,
                    size: 25,
                  )),
            ],
          ),
        ),*/
        SizedBox(
          height: 10,
        ),
        /*Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Visibility(
            maintainAnimation: true,
            visible: rewardVisible,
            maintainState: true,
            //maintainAnimation: false,

            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: rew.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Image.asset(
                                "assets/ic_topupgift.png",
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: backgroundlight,
                                // border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    Object[0]
                                        .rewardsPointList[index]
                                        .toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "POINTS",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Object[0].rewardsDescList[index].toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Expiry: " +
                                        Object[0]
                                            .rewardsExpiryList[index]
                                            .toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            //  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //   Text("hii"),
            replacement: SizedBox(),
          ),
        ),*/
        /*Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 0.5,
            width: double.infinity,
            child: Container(
              color: poketpurple,
            ),
          ),
        ),*/

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Terms",
                style: TextStyle(fontSize: 15, color: poketpurple),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      TncVisible = !TncVisible;
                    });
                  },
                  child: Icon(
                    TncVisible
                        ? CupertinoIcons.minus_circle
                        : Icons.add_circle_outline,
                    color: poketpurple,
                    size: 25,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Visibility(
            maintainAnimation: true,
            visible: TncVisible,
            maintainState: true,
            //maintainAnimation: false,

            child: Text(
              Object[0].tnc.replaceAll("<br>", "\n"),
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey),
            ),
            replacement: SizedBox(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 0.5,
            width: double.infinity,
            child: Container(
              color: poketpurple,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Merchant Info",
                style: TextStyle(fontSize: 15, color: poketpurple),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      merchantVisible = !merchantVisible;
                    });
                  },
                  child: Icon(
                    merchantVisible
                        ? CupertinoIcons.minus_circle
                        : Icons.add_circle_outline,
                    color: poketpurple,
                    size: 25,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Visibility(
            maintainAnimation: true,
            visible: merchantVisible,
            maintainState: true,
            //maintainAnimation: false,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        child: Image.network(
                          Object[0].merchantLogoURL[0].toString(),
                          height: 35.0,
                          width: 35.0,
                          fit: BoxFit.fitWidth,
                        )),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Object[0].merchantName.toString()),
                          Text(Object[0].merchantSubCategory.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                merchantinfor.toString()),
                    //Object[0].merchantinfo.toString()),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    //  color: backgroundlight,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Text("Website"),
                        Text(Object[0].merchantWebsite.toString()),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            replacement: SizedBox(),
          ),
        ), //gray line
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 0.5,
            width: double.infinity,
            child: Container(
              color: poketpurple,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Participating Outlets",
                style: TextStyle(fontSize: 15, color: poketpurple),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      OutletVisible = !OutletVisible;
                    });
                  },
                  child: Icon(
                    OutletVisible
                        ? CupertinoIcons.minus_circle
                        : Icons.add_circle_outline,
                    color: poketpurple,
                    size: 25,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Visibility(
            maintainAnimation: true,
            visible: OutletVisible,
            maintainState: true,
            //maintainAnimation: false,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    //  color: backgroundlight,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Object[0].outletName[0].toString()),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset("assets/ic_map.png",width: 40,),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text(Object[0].outletBuiding[0].toString()),
                        Text(Object[0].outletAddress[0].toString()),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            height: 0.5,
                            width: double.infinity,
                            child: Container(
                              color: poketpurple,
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Operating Hours"),
                            Container(
                              height: 18,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),


                              child: Center(child: Text(
                                Object[0].outletContact[0].toString(),
                                style: TextStyle(fontSize: 11),)),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text(Object[0].outletOpHours[0].toString().replaceAll("<br>", "\n")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            replacement: SizedBox(),
          ),
        ),

      ],
    );
    // var  totalcount = Object.productInfo.length.toInt();
    // return Column(
    //   crossAxisAlignment:CrossAxisAlignment.start,
    //   children: [
    //     Container(
    //       height: 150,
    //      // child: Stack(
    //       //  children: [
    //
    //          child: Center(child: Image.network(Voucherimage,height: 120,width: 190,fit: BoxFit.fill, )),
    //           /*Positioned(
    //               top: 20,
    //               left: 20,
    //               bottom: 20,
    //               child:Icon(Icons.arrow_back_ios,size: 30,)
    //
    //           ),
    //           Positioned(
    //               top: 20,
    //               right: 20,
    //               bottom: 20,
    //               child:Icon(Icons.arrow_forward_ios,size: 30,)
    //
    //           )*/
    //      //   ],
    //       //),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 10,bottom: 10),
    //       child: SizedBox(
    //         height: 0.5,
    //         width: double.infinity,
    //         child: Container(
    //           color: poketpurple,
    //         ),
    //       ),
    //     ),
    //
    //     Padding(padding: EdgeInsets.only(left: 20),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //
    //         children: [
    //           Text(Object.cardDetails.first.pointVoucherTitle,style: TextStyle(
    //               fontSize: 15,color: poketpurple
    //           ),),
    //
    //           Text("Expiry: " + Object.cardDetails.first.voucherValidity )
    //         ],
    //       ),
    //
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 10,bottom: 10),
    //       child: SizedBox(
    //         height: 0.5,
    //         width: double.infinity,
    //         child: Container(
    //           color: poketpurple,
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20,right: 20),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text("Benifits",style: TextStyle(
    //               fontSize: 15,color: poketpurple
    //           ),),
    //           InkWell(
    //               onTap: ()async{
    //                 setState(() {
    //                   BenifitVisible = !BenifitVisible;
    //                 });
    //
    //               },
    //               child: Icon(BenifitVisible ?  CupertinoIcons.minus_circle : Icons.add_circle_outline,color: poketpurple,size: 25,)),
    //
    //         ],
    //
    //
    //       ),
    //
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20,right: 20),
    //       child: Visibility(
    //         maintainAnimation: true,
    //         visible: BenifitVisible,
    //         maintainState: true,
    //         //maintainAnimation: false,
    //
    //         child:
    //         Text(Object.mktgInfo.replaceAll("<br>","\n"),style: TextStyle(color: Colors.grey),),
    //         replacement: SizedBox(),
    //
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 10,bottom: 10),
    //       child: SizedBox(
    //         height: 0.5,
    //         width: double.infinity,
    //         child: Container(
    //           color: poketpurple,
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20,right: 20),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text("Terms",style: TextStyle(
    //               fontSize: 15,color: poketpurple
    //           ),),
    //           InkWell(
    //               onTap: ()async{
    //                 setState(() {
    //                   TncVisible = !TncVisible;
    //                 });
    //
    //               },
    //               child: Icon(TncVisible ? CupertinoIcons.minus_circle: Icons.add_circle_outline,color: poketpurple,size: 25,)),
    //
    //         ],
    //
    //
    //       ),
    //
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20,right: 20),
    //       child: Visibility(
    //         maintainAnimation: true,
    //         visible: TncVisible,
    //         maintainState: true,
    //         //maintainAnimation: false,
    //
    //         child:
    //         Text(Object.tnc.replaceAll("<br>", "\n"),
    //           textAlign: TextAlign.left,
    //
    //           style: TextStyle(
    //               color: Colors.grey
    //           ), ),
    //         replacement: SizedBox(),
    //
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 10,bottom: 10),
    //       child: SizedBox(
    //         height: 0.5,
    //         width: double.infinity,
    //         child: Container(
    //           color: poketpurple,
    //         ),
    //       ),
    //     ),//gray line
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20,right: 20),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //
    //         children: [
    //
    //           InkWell(
    //               onTap: ()async{
    //                 setState(() {
    //                   RewardImageVisible = !RewardImageVisible;
    //                 });
    //
    //               },
    //               child: Icon(RewardImageVisible? CupertinoIcons.minus_circle: Icons.add_circle_outline,color: poketpurple,size: 25,)),
    //
    //         ],
    //
    //
    //       ),
    //
    //     ),
    //     Visibility(
    //         visible: RewardImageVisible,
    //         child:
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               height: 300,
    //               width: double.infinity,
    //
    //               child:  Stack(
    //                 children: [
    //
    //                   Center(child: Image.network(Object.productInfo[RewardImgIndex],fit: BoxFit.fitWidth, )),
    //                   Positioned(
    //                       top: 20,
    //                       left: 20,
    //                       bottom: 20,
    //                       child:InkWell(
    //                           onTap: ()async {
    //
    //                             print(totalcount);
    //                             setState(() {
    //                               const intt = 1;
    //                               RewardImgIndex = RewardImgIndex - intt;
    //                               if(RewardImgIndex < 0) {
    //                                 RewardImgIndex = Object.productInfo.length - 1 ;
    //
    //                               }
    //                               else {
    //
    //                               }
    //
    //                             });
    //                           },
    //                           child:Icon(Icons.arrow_back_ios,size: 30,) )
    //
    //                   ),
    //                   Positioned(
    //                       top: 20,
    //                       right: 20,
    //                       bottom: 20,
    //                       child:InkWell(
    //
    //                           onTap: ()async {
    //                             setState(() {
    //                               const intt = 1;
    //                               RewardImgIndex = RewardImgIndex + intt;
    //                               if (RewardImgIndex < Object.productInfo.length) {
    //
    //                               }
    //                               else{
    //                                 RewardImgIndex = 0;
    //                               }
    //                             });
    //
    //                           },
    //                           child: Icon(Icons.arrow_forward_ios,size: 30,))
    //
    //                   )
    //                 ],
    //               ),
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 15),
    //               child: Text("MBM Wheelpower"),
    //             ),
    //             Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 10),
    //               child: Container(
    //                 height: 50,
    //                 width: double.infinity,
    //                 decoration: BoxDecoration(
    //
    //                     border: Border.all(color: Colors.black12,width: 1)
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(left: 10),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //
    //                       Text("Website",style: TextStyle(fontWeight: FontWeight.w400),),
    //
    //                       Text(Object.email2,style: TextStyle(color: Colors.grey),),
    //
    //                     ],
    //
    //                   ),
    //                 ),
    //               ),
    //             )
    //
    //           ],
    //         )
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 10,bottom: 10),
    //       child: SizedBox(
    //         height: 0.5,
    //         width: double.infinity,
    //         child: Container(
    //           color: poketpurple,
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20,right: 20),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text("Participating Outlets",style: TextStyle(
    //               fontSize: 15,color: poketpurple
    //           ),),
    //           InkWell(
    //               onTap: ()async{
    //                 setState(() {
    //                   OutletVisible = !OutletVisible;
    //                 });
    //
    //               },
    //               child: Icon(OutletVisible?  CupertinoIcons.minus_circle : Icons.add_circle_outline,color: poketpurple,size: 25,)),
    //
    //         ],
    //
    //
    //       ),
    //
    //     ),
    //     Visibility(
    //       visible: OutletVisible,
    //       child: ParticipatingOutlet(context, Object.outletData),
    //       replacement: SizedBox(),
    //
    //     )
    //
    //   ],
    // );
  }

  // Widget ParticipatingOutlet(BuildContext context,List<OutletDatum> OutletData ) {
  //
  //   return Container();
  //
  //   // return ListView.builder(
  //   //   physics: NeverScrollableScrollPhysics(),
  //   //   reverse: true,
  //   //   shrinkWrap: true,
  //   //   itemCount: OutletData .length,
  //   //   itemBuilder: (context,index) {
  //   //
  //   //     return Padding(
  //   //       padding: EdgeInsets.all(10),
  //   //       child: Container(
  //   //         //height: 200,
  //   //         width: double.infinity,
  //   //         decoration: BoxDecoration(
  //   //             border: Border.all(color: Colors.black12,width: 1)
  //   //         ),
  //   //         child: Column(
  //   //           crossAxisAlignment: CrossAxisAlignment.start,
  //   //           children: [
  //   //             Padding(
  //   //               padding: const EdgeInsets.all(10.0),
  //   //               child: Row(
  //   //                 children: [
  //   //
  //   //                   Expanded(
  //   //                       flex: 7,
  //   //                       child: Column(
  //   //                         crossAxisAlignment: CrossAxisAlignment.start,
  //   //                         children: [
  //   //                           Text(OutletData[index].shopName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey),),
  //   //                           SizedBox(height: 10,),
  //   //                           Text(OutletData[index].address,style: TextStyle(
  //   //                               color: Colors.grey
  //   //                           ),)
  //   //                         ],
  //   //                       )),
  //   //
  //   //
  //   //                   Expanded(
  //   //                       flex: 2,
  //   //                       child: Padding(
  //   //                         padding: const EdgeInsets.only(top: 10),
  //   //                         child: Image.asset("assets/ic_map.png",width: 30,height: 30,)
  //   //                       ))
  //   //                 ],
  //   //               ),
  //   //             ),
  //   //             Padding(
  //   //               padding: const EdgeInsets.only(top: 10,bottom: 10),
  //   //               child: SizedBox(
  //   //                 height: 0.5,
  //   //                 width: double.infinity,
  //   //                 child: Container(
  //   //                   color: Colors.grey,
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //             Padding(padding: EdgeInsets.all(10),
  //   //
  //   //               child: Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text("Oprating Hours",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey)),
  //   //                   Container(
  //   //                     height: 30,
  //   //                     decoration: BoxDecoration(
  //   //                       borderRadius: BorderRadius.all(Radius.circular(10)),
  //   //
  //   //                       border: Border.all(color: Colors.black12,width: 1),
  //   //
  //   //                     ),
  //   //                     child: Padding(
  //   //                       padding: const EdgeInsets.all(5.0),
  //   //                       child: Text(OutletData[index].telp),
  //   //                     ),
  //   //                   )
  //   //                 ],
  //   //
  //   //               ),
  //   //             ),
  //   //             Padding(padding: EdgeInsets.only(left: 10),
  //   //               child: Text(OutletData[index].openingHrsVal,style: TextStyle(
  //   //                   color: Colors.grey
  //   //               ),),
  //   //             ),
  //   //             SizedBox(height: 10,)
  //   //           ],
  //   //         ),
  //   //       ),
  //   //     );
  //   //   },
  //   //
  //   //
  //   // );
  // }

  Future<List<BrowseCardDetailModel>> getEcardData() async {
    print(VIEWPROGRAMDEATAIL_URL.toString());

    final http.Response response = await http.post(
      Uri.parse(VIEWPROGRAMDEATAIL_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        //  "order_data": "newest",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":"2",
        'consumer_application_type':"18",
        'consumer_language_id':CommonUtils.APPLICATIONLANGUAGEID,
        "program_type":"1",
        "country_index":"191",
        "program_id":Programid.toString(),
        "merchant_id":MerchantId.toString()
        // "consumer_id":"191",
        //  "sort_type":"1",
        //  "page_number":"1",
        //  "search_mode":"0",
        //  "keyword":"",
        //  "latitude":"0.0",
        //  "longitude":"0.0"
      },
    ).timeout(Duration(seconds: 30));


    debugPrint("Check13"+ response.body.toString(),wrapWidth: 1024);
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      //  print("hii");
      var newData = data['info'];
      List<BrowseCardDetailModel> object1 = [];
      var p1 = Utils().stringSplit(newData['p1']);
      print("hii" + p1.toString());
      var p2 = Utils().stringSplit(newData['p2']);
      print("hii" + p2.toString());
      var p3 = Utils().stringSplit(newData['p3']);
      print("hii" + p3.toString());
      var p4 = Utils().stringSplit(newData['p4']);
      print("hii" + p4.toString());
      var p5 = Utils().stringSplit(newData['p5']);
      print("hii" + p5.toString());
      var p6 = Utils().stringSplit(newData['p6']);
      print("hii" + p6.toString());
      var p7 = Utils().stringSplit(newData['p7']);
      print("hii" + p7.toString());
      var p8 = Utils().stringSplit(newData['p8']);
      print("hii" + p8.toString());
      var p9 = Utils().stringSplit(newData['p9']);
      print("hii" + p9.toString());
      var p10 = Utils().stringSplit(newData['p10']);
      print("hii" + p10.toString());
      var p11 = Utils().stringSplit(newData['p11']);
      var p12 = Utils().stringSplit(newData['p12']);
      var p13 = Utils().stringSplit(newData['p13']);
      var p14 = Utils().stringSplit(newData['p14']);
      var p15 = Utils().stringSplit(newData['p15']);
      var p16 = Utils().stringSplit(newData['p16']);
      var p17 = Utils().stringSplit(newData['p17']);
      var p18 = Utils().stringSplit(newData['p18']);
      var p19 = Utils().stringSplit(newData['p19']);
      var p20 = Utils().stringSplit(newData['p20']);
      String expiryDetails = p1.split("*")[0].toString();
      String benefits = p2.toString();
      print("cheid"+benefits.toString());
      var rewards = p3.toString();
      print("cheid"+rewards.toString());
      List rewardsPointList = [];
      List rewardsDescList = [];
      List rewardsExpiryList = [];
      if (rewards.toString()!= "none") {
         print("hii");
        for (int i = 0; i < rewards.length; i++) {
          List arrayDetailList = (rewards[i]).split(":");
          // print(arrayDetailList.toString());
          rewardsPointList.add(arrayDetailList[0]);
          rewardsDescList.add(arrayDetailList[1]);
          rewardsExpiryList.add(arrayDetailList[2]);
        }
      }
      String tnc = p4.toString();
      String merchantinfo = p5.split("*")[0].toString();
      List outletID = p6.split("*") as List;
      List outletName = p7.split("*") as List;
      List outletBuiding = p8.split("*") as List;
      List outletAddress = p9.split("*") as List;
      List outletLongLat = p10.split("*") as List;
      List outletOpHours = p11.split("*") as List;
      List outletContact = p12.split("*") as List;
      List programImageURLs = p13.split("*") as List;
      List merchantLogoURL = p14.split("*") as List;
      print("bhar" + merchantLogoURL.toString());
      String merchantName = p15.split("*")[0].toString();
      String merchantSubCategory = p16.split("*")[0].toString();
      String merchantRating = p17.split("*")[0].toString();
      String merchantEmail = p18.split("*")[0].toString();
      String merchantWebsite = p19.split("*")[0].toString();
      List merchantGalleryURLs = p20.split("*") as List;
      if (merchantRating == "none") {
        merchantRating = "0";
      }
      object1.add(new BrowseCardDetailModel(
          expiryDetails: expiryDetails,
          benefits: benefits,
          rewards: rewards,
          rewardsPointList: rewardsPointList,
          tnc: tnc,
          rewardsDescList: rewardsDescList,
          rewardsExpiryList: rewardsExpiryList,
          merchantinfo: merchantinfo,
          outletID: outletID,
          outletName: outletName,
          outletBuiding: outletBuiding,
          outletAddress: outletAddress,
          outletOpHours: outletOpHours,
          outletContact: outletContact,
          programImageURLs: programImageURLs,
          merchantLogoURL: merchantLogoURL,
          merchantName: merchantName,
          merchantSubCategory: merchantSubCategory,
          merchantRating: merchantRating,
          merchantEmail: merchantEmail,
          merchantWebsite: merchantWebsite,
          merchantGalleryURLs: merchantGalleryURLs));
      print("checkd");
      return object1;
    } else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  void showAlertForGetit(var programId,var programtype,var outletid) {
    AlertDialog alert1 = AlertDialog(
      backgroundColor: Colors.white,
      // content: CircularProgressIndicator(),
      content:
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
            "By accepting this card, you agree to join MBM Wheelpower loyalty program and share your profile information to them.",
            textAlign: TextAlign.left,
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
              onTap: () async {
                Navigator.pop(context, true);
                bool internetcheck = await initTimer();
                print("bharathi" + internetcheck.toString());
                if (internetcheck == true) {
                  _DownloadVoucher(programId,programtype,outletid);
                } else {
                  showAlertDialog_oneBtn(this.context, "Network",
                      "No Internet Connection. Please turn on Internet Connection");
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
                        "ACCEPT",
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

  Future<bool> initTimer() async {
    bool check = true;
    if (await checkinternet()) {
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");
        check = true;
        //callSignoutAPi();

      });
    } else {
      check = false;
    }
    print("bharathi1" + check.toString());
    return check;
  }

  Future<bool> checkinternet() async {
    var connectivityresult = await(Connectivity().checkConnectivity());
    if (connectivityresult == ConnectivityResult.none) {
      print("not connected");
      return false;
    }
    else {
      return true;
    }
  }

  _DownloadVoucher(var programId,var programtype,var outletid) async {
    print(programId.toString()+programtype.toString()+outletid.toString());
    print(POKETIT_URL);
    final http.Response response =
    await http.post(Uri.parse(POKETIT_URL), body: {
      "consumer_id": CommonUtils.consumerID.toString(),
      "country_index": "191",
      "program_id": programId.toString(),
      "action_event": programtype.toString(),
      "software_version": CommonUtils.softwareVersion,
      "os_version": CommonUtils.osVersion,
      "phone_model": CommonUtils.deviceModel,
      'consumer_application_type': CommonUtils.consumerApplicationType,
      'consumer_language_id': CommonUtils.consumerLanguageId,
      "device_type": CommonUtils.deviceType,
      "device_token_id": CommonUtils.deviceTokenID,
      "upgrade_card": "1",
      "join_method": "16",
      "download_id":"0",
      "outlet_id":outletid.toString(),
      "pns_id":"0"
      // "member_id":memberid,
    }).timeout(Duration(seconds: 30));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      debugPrint(response.body);

      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      var status = Utils().stringSplit(newData['p1']);
      /* var success = Utils().stringSplit2(newData['p9']) +
          "voucher redeemption is successful";*/
      var Message = Utils().stringSplit(newData['p14']);
      if (status != "False") {
        CommonUtils.NAVIGATE_PATH = "walletPage";
        //  Navigator.pop(context,true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConsumerTab(),
          ),
        );
        //   if (Platform.isAndroid) {
        //  showAlertDialog_oneBtnWitDismissw(context, "Alert", success);
        // }
        /*if (Platform.isIOS) {
          var alert = ShowNativeDialogue(context, "Alert", success);

          *//*CommonUtils.NAVIGATE_PATH = "walletPage";
          alert.whenComplete(() =>


              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ConsumerTab(),)));*//*
        }*/
      }
      else {
        if (Platform.isAndroid) {
          showAlertDialog_oneBtnWitDismissback(context, "Alert", Message);
        }
        if (Platform.isIOS) {
          var alert = ShowNativeDialogue(context, "Alert", Message);

          alert.whenComplete(() => Navigator.pop(context));
        }
      }
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
  _launchEmail(var emailid) async{
  /*  var email_body = CommonUtils.manufacturer.toString()+"\n"+"Model "+CommonUtils.deviceModel.toString()+"\n"+
        "OS "+ CommonUtils.osVersion.toString()+"\n"+"Version "+ CommonUtils.softwareVersion.toString();
    print("check"+ email_body.toString());*/
    final Email email = Email(
      subject: emailContent,
      recipients: [emailid],
      isHTML: false,
     // body: email_body,
    );

    await FlutterEmailSender.send(email);
  }
  void showAlertDialog_oneBtnWitDismissback(BuildContext context,String tittle,String message)
  {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message,style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: (){Navigator.pop(context,true);


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

        // Navigator.pop(context);
      } else {
        // user pressed No button
      }
    });

  }

}
