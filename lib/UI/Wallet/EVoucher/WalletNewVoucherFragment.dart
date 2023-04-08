import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../../res/Strings.dart';
import '../Models/Card/WalletmodelVoucher1New.dart';
import '../SortFragment.dart';
import 'WalletSecondScreen.dart';

class WalletNewVoucherFragment extends StatefulWidget {
  const WalletNewVoucherFragment({Key? key}) : super(key: key);

  @override
  State<WalletNewVoucherFragment> createState() => _WalletNewVoucherFragmentState();
}

class _WalletNewVoucherFragmentState extends State<WalletNewVoucherFragment> {
  var GiftVoucherStripes="0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:  Column(
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
        ),
     // body: _EVoucher(context),
    );
  }

  Future<List<WalletmodelVoucher1New>> getEcardData1() async {

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
      debugPrint("hdke"+response.body.toString());

      List<dynamic> body = jsonDecode(response.body)['data']['Vouchers'];
      List<WalletmodelVoucher1New> posts1 = body.map((dynamic item) => WalletmodelVoucher1New.fromJson(item),).toList();
      return posts1;
    }
    else {
      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<List<WalletmodelVoucher1New>> _EVoucher(BuildContext context) {

    return FutureBuilder<List<WalletmodelVoucher1New>>(

      future: getEcardData1(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          final List<WalletmodelVoucher1New>? posts = snapshot.data;
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
  Widget _buildPostsHome1(BuildContext context, List<WalletmodelVoucher1New> Post) {


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
                          //    Gokul commented
                          if(GiftVoucherStripes=="0") {

                            // Gokul commented


                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    WalletSecondScreen(object1: Post[index])));
                          }


                        },
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Colors.black26)

                          ),
                          child: Column(

                            children: [
                              // Post[index].=="0"?
                              GiftVoucherStripes=="0"?
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
                                      child: Image.network(Post[index].img_url,fit: BoxFit.fill,)),
                                ),
                              )

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
                                        Image.network(Post[index].img_url, fit: BoxFit.fill,),
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
                              SizedBox(
                                height: 7,
                              ),
                              check30Days(Post[index].expire_date,Post[index].program_type),


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
