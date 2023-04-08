import 'dart:convert';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import '../Models/WalletCardRewardList.dart';
import '../Models/WalletECardModel.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:consumer5/UI/Wallet/SortFragment.dart';
import '../Models/WalletViewmodel.dart';
import '../Models/Walletmodel.dart';
import '../CardFragments/WalletThirdScreen.dart';
import 'WalletSecondScreen.dart';

class WalletVoucherFragment extends StatefulWidget {
  const WalletVoucherFragment({Key? key}) : super(key: key);

  @override
  State<WalletVoucherFragment> createState() => _WalletVoucherFragmentState();
}

class _WalletVoucherFragmentState extends State<WalletVoucherFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SortFragment()
                ));
          },
          child: Container(
              height: 30,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /*Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),*/
                    Image.asset("assets/ic_browse_sort_normal.png",width: 20,),
                    Text(CommonUtils.SelectedWallet_SortByText.toString()),
                    /*),
                    ),*/
                  ],
                ),
              )


          ),
        ),
        Expanded(child: _EVoucher(context)),
      ],
    );
  }
  Future<List<WalletViewmodel>> getEVoucherData() async {
    print(WALLETCARDURL.toString()+CommonUtils.consumerID.toString());
    print(CommonUtils.SelectedWallet_SortBy.toString());
    final http.Response response = await http.post(
      Uri.parse(WALLETCARDURL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
         "order_data": CommonUtils.SelectedWallet_SortBy.toString(),
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':"18",
        'consumer_language_id':CommonUtils.APPLICATIONLANGUAGEID,
        "program_type":"1",
        "country_index":"191",
        "action":"77",


      },
    ).timeout(Duration(seconds: 30));


    debugPrint("Check13Wallet"+ response.body.toString());
    if(response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      //  print("hii");
      var newData = data['info'];
      var p1 = Utils().stringSplit(newData['p1']);

      var p2 = Utils().stringSplit(newData['p2']);

      var p3 = Utils().stringSplit(newData['p3']);
      var p4 = Utils().stringSplit(newData['p4']);
      var p5 = Utils().stringSplit(newData['p5']);
      var p6 = Utils().stringSplit(newData['p6']);
      var p7 = Utils().stringSplit(newData['p7']);
      List<String> programID = p1.split("*");
      List<String> merchantID = p2.split("*");
      List<String> voucherNo = p3.split("*");
      List<String> giftVoucherStripes = p4.split("*");
      List<String> databaseID = p5.split("*");
      List<String> countryIndex = p6.split("*");
      List<String> programType = p7.split("*");
      List<Walletmodel> object = [];
      List<WalletViewmodel> object1 = [];
      for (int i = 0; i < programID.length; i++) {
        object.add(new Walletmodel(
            programID: programID[i],
            merchantID: merchantID[i],
            voucherNo: voucherNo[i],
            giftVoucherStripes: giftVoucherStripes[i],
            databaseID: databaseID[i],
            countryIndex: countryIndex[i],
            programType: programType[i]
        ));
      }
      for (int i = 0; i < programID.length; i++) {
        var programid = programID[i].toString();
        var programtype = programType[i].toString();
        var merchantid = merchantID[i].toString();
        var voucherno = voucherNo[i].toString();
        var databaseid = databaseID[i].toString();
        var giftvoucherstripe = giftVoucherStripes[i].toString();
        print(CommonUtils.SelectedWallet_SortBy.toString());
        final http.Response res = await http.post(
            Uri.parse(WALLETCARDURL),
            body: {
              "consumer_id": CommonUtils.consumerID.toString(),
              "action": "88",
              "device_token_id": CommonUtils.deviceTokenID.toString(),
              "program_type": programtype,
              "program_id": programid,
              "merchant_id": merchantid,
              "voucher_no": voucherno,
              "database_id": databaseid,
              "order_data": CommonUtils.SelectedWallet_SortBy.toString(),
            }
        ).timeout(Duration(seconds: 30));
        debugPrint("check1" + res.body.toString());
        if(res.statusCode == 200 && res.body.isNotEmpty){
          final Xml2Json xml2json = new Xml2Json();
          xml2json.parse(res.body);
          var jsonstring = xml2json.toParker();
          var data = jsonDecode(jsonstring);
          var newdata = data['info'];

          debugPrint("WalletCardData:"+newdata.toString(),wrapWidth: 1024);
          /*if(programtype == "rs"|| programtype == "rm"){
            print("hii");
            var newData = newdata['info'];
            var p1 = Utils().stringSplit(newData['p1']);
            // print("hii"+ p1.toString());
            var p2 = Utils().stringSplit(newData['p2']);

            var p3 = Utils().stringSplit(newData['p3']);
            var p4 = Utils().stringSplit(newData['p4']);
            var p5 = Utils().stringSplit(newData['p5']);
            var p6 = Utils().stringSplit(newData['p6']);
            var p7 = Utils().stringSplit(newData['p7']);
            var p8 = Utils().stringSplit(newData['p8']);
            var p9 = Utils().stringSplit(newData['p9']);
            var p10 = Utils().stringSplit(newData['p10']);
            var p11= Utils().stringSplit(newData['p11']);
            var p12= Utils().stringSplit(newData['p12']);
            var p13= Utils().stringSplit(newData['p13']);
            var p14= Utils().stringSplit(newData['p14']);
            var p15= Utils().stringSplit(newData['p15']);
            var p16= Utils().stringSplit(newData['p16']);
            var p17= Utils().stringSplit(newData['p17']);
            var p18= Utils().stringSplit(newData['p18']);
            var p19= Utils().stringSplit(newData['p19']);
            var p20= Utils().stringSplit(newData['p20']);
            var p21= Utils().stringSplit(newData['p21']);
            var p22= Utils().stringSplit(newData['p22']);
            var p23= Utils().stringSplit(newData['p23']);
            var p24= Utils().stringSplit(newData['p24']);
            var p25= Utils().stringSplit(newData['p25']);
            // print(p1+p2+p3+p4+p5+p6+"end"+p25+p24);
            String merchantName = p2.split("*")[0].toString();
            String merchantID = p2.split("*")[1].toString();
            String merchantEmail = p2.split("*")[2].toString();
            String merchantWebsite = p2.split("*")[3].toString();

            String merchantLogoURL = p3.split("*")[0].toString();
            String displayLogoFlag = p3.split("*")[1].toString();

            String merchantCategory = p4.split("*")[0].toString();
            String merchantSubCategory = p4.split("*")[1].toString();

            String programBackgroundImgURL = p5.split("*")[0].toString();

            String programTextColor = p6.split("*")[0].toString();
            String programID = p7.split("*")[0].toString();
            String countryIndex = p7.split("*")[1].toString();
            String sroSettings = p7.split("*")[2].toString();
            String programExpiryDate = p8.split("*")[0].toString();
            String programTitle = p9.split("*")[0].toString();
            String displayTitleFlag =p9.split("*")[1].toString();
            String programCategory = (p10.split("*")[0].toString()).split(":")[0].toString();
            String programPoints = (p10.split("*")[0].toString()).split(":")[1].toString();
            String upgradeRequirement = p11.split("*")[0].toString();

            String tnc = p12.split("*")[0].toString();
            String benefits = p13.split("*")[0].toString();

            List programTiersString = p14.split("*") as List;
            List tierDescriptionString = p15.split("*") as List;
            List tierIDString = p16.split("*") as List;

            CommonUtils.cardRewards.clear();
            if(programTiersString.length!=1 && programTiersString[0]!="none"){

              for(int i=0 ; i<programTiersString.length;i++){
                CommonUtils.cardRewards.add(new WalletCardRewardList(programTiersString[i],tierDescriptionString[i],tierIDString[i]));
              }

            }
            else{CommonUtils.cardRewards=[];}

            List outletList =[];
            outletList = p18.split("*") as List;
            //  print("check10"+ outletList.toString());
            // print("check10"+ outletList.length.toString());
            List outletName= [];
            List outletIDList = [] ;
            if (outletList.length!=0) {
              // print("hii");
              for (int i = 0; i < outletList.length; i++) {
                List arrayDetailList = (outletList[i]).split(":");
                // print(arrayDetailList.toString());
                outletName.add(arrayDetailList[0]);
                outletIDList.add(arrayDetailList[1]);
                *//*outletIDList = arrayDetailList[1].toString() as List;
                outletName = arrayDetailList[0].toString() as List;*//*
                //   print("Check11"+outletName.toString());
                // print("Check12"+outletIDList.toString());
              }
            }
            //print("Check11"+outletName[0].toString());
            // print("Check12"+outletIDList[1].toString());
            List outletContact = p20.split("*") as List;
            List outletAddress = p21.split("*") as List;
            List outletBuiding = p22.split("*") as List;
            List outletOpHours = p23.split("*") as List;
            // List bundleFormat = p25.split("*") as List;
            String memberID = p24.split("*")[0].toString();
            // print(outletAddress.toString());
            //  List<WalletViewmodel> object1 = [];
            object1.add(new WalletViewmodel(
                programBackgroundImgURL: programBackgroundImgURL,
                programTitle:programTitle,
                programExpiryDate:programExpiryDate,
                tnc: tnc,benefits:benefits,programID:programID,
                countryIndex:countryIndex,merchantName:merchantName,
                merchantID:merchantID,
                merchantEmail:merchantEmail,
                merchantWebsite: merchantWebsite,
                merchantLogoURL:merchantLogoURL,
                displayLogoFlag:displayLogoFlag,
                merchantCategory:merchantCategory,
                merchantSubCategory:merchantSubCategory,
                programTextColor:programTextColor,
                sroSettings:sroSettings,
                displayTitleFlag:displayTitleFlag,
                programCategory: programCategory,
                programPoints:programPoints,
                upgradeRequirement:upgradeRequirement,
                outletName:outletName,
                outletIDList:outletIDList,
                outletContact:outletContact,
                outletAddress:outletAddress,
                outletBuiding:outletBuiding,
                outletOpHours:outletOpHours,
                //  bundleFormat:bundleFormat,
                memberID:memberID,
                serialnumber:"",outletList: outletList,giftvoucherstripe:giftvoucherstripe,programtype:programtype

            ));
            // print("test1"+ object1.length.toString());


          }*/
           if (programtype =="rv"){
            print("hiii");
            // var newData = newdata['info'];
            var p1 = Utils().stringSplit(newdata['p1']);
            //   print("hiii"+ p1.toString());
            var p2 = Utils().stringSplit(newdata['p2']);

            var p3 = Utils().stringSplit(newdata['p3']);
            var p4 = Utils().stringSplit(newdata['p4']);
            var p5 = Utils().stringSplit(newdata['p5']);
            var p6 = Utils().stringSplit(newdata['p6']);
            var p7 = Utils().stringSplit(newdata['p7']);
            var p8 = Utils().stringSplit(newdata['p8']);
            var p9 = Utils().stringSplit(newdata['p9']);
            var p10 = Utils().stringSplit(newdata['p10']);
            var p11= Utils().stringSplit(newdata['p11']);
            var p12= Utils().stringSplit(newdata['p12']);
            var p13= Utils().stringSplit(newdata['p13']);
            var p14= Utils().stringSplit(newdata['p14']);
            var p15= Utils().stringSplit(newdata['p15']);
            var p16= Utils().stringSplit(newdata['p16']);
            var p17= Utils().stringSplit(newdata['p17']);
            var p18= Utils().stringSplit(newdata['p18']);
            var p19= Utils().stringSplit(newdata['p19']);
            var p20= Utils().stringSplit(newdata['p20']);
            var p21= Utils().stringSplit(newdata['p21']);
            var p22= Utils().stringSplit(newdata['p22']);
            var p23= Utils().stringSplit(newdata['p31']);
            print("hiii"+ p23.toString());
            String merchantName = p2.split("*")[0].toString();
            String merchantID = p2.split("*")[1].toString();
            String merchantEmail = p2.split("*")[2].toString();
            String merchantWebsite = p2.split("*")[3].toString();

            String merchantLogoURL = p3.split("*")[0].toString();
            String displayLogoFlag = p3.split("*")[1].toString();

            String merchantCategory = p4.split("*")[0].toString();
            String merchantSubCategory = p4.split("*")[1].toString();

            String programBackgroundImgURL = p5.split("*")[0].toString();

            String programTextColor = p6.split("*")[0].toString();
            String programID = p7.split("*")[0].toString();
            String countryIndex = p7.split("*")[1].toString();
            String sroSettings = p7.split("*")[2].toString();
            String programExpiryDate = p8.split("*")[0].toString();
            String programTitle = p9.split("*")[0].toString();
            String displayTitleFlag =p9.split("*")[1].toString();
            String programCategory = (p10.split("*")[0].toString()).split(":")[0].toString();
            String programPoints = (p10.split("*")[0].toString()).split(":")[1].toString();
            // String upgradeRequirement = p11.split("*")[0].toString();

            String tnc = p11.split("*")[0].toString();
            String benefits = p12.split("*")[0].toString();
            String voucherDescription = p13.split("*")[0].toString();
            String promptMessage = p14.split("*")[0].toString();
            List outletList =[];
            outletList = p15.split("*") as List;
            //  print("check10"+ outletList.toString());
            //  print("check10"+ outletList.length.toString());
            List outletName= [];
            List outletIDList = [] ;
            if (outletList.length!=0) {
              // print("hii");
              for (int i = 0; i < outletList.length; i++) {
                List arrayDetailList = (outletList[i]).split(":") as List;
                // print(arrayDetailList.toString());
                outletName.add(arrayDetailList[0]);
                outletIDList.add(arrayDetailList[1]);
                /*outletIDList = arrayDetailList[1].toString() as List;
                outletName = arrayDetailList[0].toString() as List;*/
                //  print("Check11"+outletName.toString());
                //  print("Check12"+outletIDList.toString());
              }
            }
            // print("Check15"+outletName[0].toString());
            // print("Check16"+outletIDList[1].toString());
            List outletContact = p17.split("*") as List;
            List outletAddress = p18.split("*") as List;
            List outletBuiding = p19.split("*") as List;
            List outletOpHours = p20.split("*") as List;
            //List bundleFormat = p22.split("*") as List;
            String serialnumber = p21.split("*")[0].toString();
            // List<WalletViewmodel> object1 = [];
            object1.add(new WalletViewmodel(
                programBackgroundImgURL: programBackgroundImgURL,
                programTitle:programTitle,
                programExpiryDate:programExpiryDate,
                tnc: tnc,benefits:benefits,programID:programID,
                countryIndex:countryIndex,merchantName:merchantName,
                merchantID:merchantID,
                merchantEmail:merchantEmail,
                merchantWebsite: merchantWebsite,
                merchantLogoURL:merchantLogoURL,
                displayLogoFlag:displayLogoFlag,
                merchantCategory:merchantCategory,
                merchantSubCategory:merchantSubCategory,
                programTextColor:programTextColor,
                sroSettings:sroSettings,
                displayTitleFlag:displayTitleFlag,
                programCategory: programCategory,
                programPoints:programPoints,
                upgradeRequirement:"",
                outletName:outletName,
                outletIDList:outletIDList,
                outletContact:outletContact,
                outletAddress:outletAddress,
                outletBuiding:outletBuiding,
                outletOpHours:outletOpHours,
                // bundleFormat:bundleFormat,
                memberID:"",
                serialnumber:serialnumber, outletList: outletList,programtype:programtype,giftvoucherstripe: giftvoucherstripe

            ));
            //  print("test"+ object1.length.toString());

          }else{

          }
        }
      }
      print(object1.toString()+"checka");
      print(object1.length.toString()+"checkb");
      return object1;
    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<WalletViewmodel>> _EVoucher(BuildContext context) {

    return FutureBuilder<List<WalletViewmodel>>(

      future: getEVoucherData(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          final List<WalletViewmodel>? posts = snapshot.data;
          print(posts.toString()+"checkd");
          if(posts!=null && posts.isNotEmpty){
            //  if(snapshot.data!.length!=0){
            return _buildPostsHome(context, posts);
          }

          else{

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(child: Text(no_vchr_found,style: TextStyle(color: corporateColor,fontSize: 15),)),
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
  Widget _buildPostsHome(BuildContext context, List<WalletViewmodel> Post) {


    return AnimationLimiter(

        child:
        GridView.builder(
            itemCount: Post.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 250,

                crossAxisCount: 2

            ), itemBuilder: (context, index) {
          return
            AnimationConfiguration.staggeredList(position: index,
                duration: const Duration(milliseconds: 375),

                child:
                SlideAnimation(
                  verticalOffset: 50.0,

                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      child: InkWell(
                        onTap: (){
                          // print(index);
                          if(Post[index].giftvoucherstripe =="0") {
                            /*Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  WalletSecondScreen(object1: Post[index])));*/

                           /* Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    WalletSecondScreen(object1: Post[index])));*/
                          }// need to delete else block navigator //bharathi
                          else{
                            /*Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    WalletSecondScreen(object1: Post[index])));*/
                          }

                        },
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Colors.black26)

                          ),
                          child: Column(

                            children: [
                              Post[index].giftvoucherstripe=="0"?
                              /*InkWell(
                              onTap: ()async{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WalletSecondScreen(object1: Post[index])));
                              },*/
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                      height:125,
                                      child: Image.network(Post[index].programBackgroundImgURL,fit: BoxFit.fill,)),
                                ),
                              )
                              // )
                                  :
                              Padding(padding:const EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    height:125,
                                    //color: Colors.blue,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      //  fit: StackFit.loose,
                                      children:[
                                        // AspectRatio(aspectRatio: 5,fit,child: Image.network(Post[index].programBackgroundImgURL, fit: BoxFit.fill,),),
                                        Image.network(Post[index].programBackgroundImgURL, fit: BoxFit.fill,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            //SizedBox(width: 20,),
                                            Center(
                                                child: Image.asset("assets/ic_gifted.png",width: 40)
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),

                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(Post[index].programTitle,style: TextStyle(
                                      fontSize: 13,fontWeight: FontWeight.bold
                                  ),),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                              child: Text("Expiry: "+Post[index].programExpiryDate,style: TextStyle(
                                fontSize: 13,
                              ),),
                      ),),
                              SizedBox(
                                height: 7,
                              ),
                              check30Days(Post[index].programExpiryDate,Post[index].programtype),


                            ],
                          ),

                        ),



                      ),
                    ),
                  ),
                )

            );

        }

        )

    );
  }
  Widget check30Days(var date, var prgmType){
    print("checktodays"+ date.toString());
   /* var newformat = DateFormat("dd-MM-yyyy");
 date = newformat.format(date);
 print("check the year"+ date.toString());*/
    if(date.toString().contains(" ")){
      date = date.toString().split(" ")[0];
      List temp = date.toString().split("-");
      date = temp[2]+"-"+temp[1]+"-"+temp[0];
      print("kjsgjhkd"+date.toString());
      print("testa"+temp[0].toString());
      print("testa"+temp[1].toString());
      print("testa"+temp[2].toString());
    }
    List temp=date.toString().split("-");
    print("kjsgjhkd2"+date.toString());


    var date1 = DateTime(int.parse(temp[2]), int.parse(temp[1]), int.parse(temp[0]));
    print("bharu"+date1.toString());
    var date2 = DateTime.now();
    var difference = date1.difference(date2).inDays+1;

    if(difference<=31){
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                border: Border.all(color: Colors.red,style: BorderStyle.solid)
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(difference.toString()+" "+daysLeft,style: TextStyle(color: Maincolor,fontSize: 14,),),
              )),
        ),
      );
    }
    else{
      return Text(empty);
    }
  }
}
