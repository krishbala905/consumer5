import 'dart:convert';
import 'package:consumer5/UI/Wallet/Models/Card/WalletmodelNew.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:consumer5/UI/Wallet/SortFragment.dart';
import 'WalletThirdScreen.dart';

class WalletCardFragment extends StatefulWidget {
  const WalletCardFragment({Key? key}) : super(key: key);

  @override
  State<WalletCardFragment> createState() => _WalletCardFragmentState();
}

class _WalletCardFragmentState extends State<WalletCardFragment> {
  @override
  Widget build(BuildContext context) {
    return
      Column(
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
          // Expanded(child: _ECard(context)),
          Expanded(child: _ECard1(context)),
        ],
      );
  }


  //JSON
  Future<List<WalletmodelNew>> getEcardData1() async {

    print("WALLETCARDURLNEW1:"+WALLETCARDURLNEW);

    final http.Response response = await http.post(
      // Uri.parse(WALLETCARDURLNEW),
      Uri.parse(BASEURL1+"newapi/MBMNewUiPoketWalletCmd"),

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



    if(response.statusCode == 200) {



      List<dynamic> body = jsonDecode(response.body)['data']['Cards'];
      List<WalletmodelNew> posts1 = body.map((dynamic item) => WalletmodelNew.fromJson(item),).toList();
      return posts1;
    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<WalletmodelNew>> _ECard1(BuildContext context) {

    return FutureBuilder<List<WalletmodelNew>>(

      future: getEcardData1(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          final List<WalletmodelNew>? posts = snapshot.data;
          print(posts.toString()+"checkd");
          if(posts!=null && posts.isNotEmpty){
            //  if(snapshot.data!.length!=0){
            return _buildPostsHome1(context, posts);
          }

          else{

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(child: Text(no_card_found,style: TextStyle(color: corporateColor,fontSize: 15),)),
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
  Widget _buildPostsHome1(BuildContext context, List<WalletmodelNew> Post) {


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
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  WalletThirdScreen(object1: Post[index])));
                        },
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Colors.black26)

                          ),
                          child: Column(

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                      height:125,
                                      child: Image.network(Post[index].img_url,fit: BoxFit.fill,)),
                                ),
                              ),
                              //
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(Post[index].program_title,style: TextStyle(
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
                                  child: Text("Expiry: "+Post[index].expire_date,style: TextStyle(
                                    fontSize: 13,
                                  ),),
                                ),),



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

}
