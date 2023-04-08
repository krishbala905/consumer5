import 'package:flutter/material.dart';
import 'package:consumer5/Others/CommonUtils.dart';
import 'package:consumer5/UI/ConsumerTab.dart';
import 'package:consumer5/generated/l10n.dart';
import 'package:consumer5/res/Colors.dart';
// import 'package:geolocation/geolocation.dart';
//import 'package:geolocator/geolocator.dart';
import '../../res/Strings.dart';
enum language{nearest,newest,expiring,brandaz,brandza}
class SortFragment extends StatefulWidget {
  const SortFragment({Key? key}) : super(key: key);

  @override
  State<SortFragment> createState() => _SortFragmentState();
}

class _SortFragmentState extends State<SortFragment> {
  language _site = language.newest;
  // int _site = 0;
  String latitude = '00.00000';
  String longitude = '00.00000';
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Maincolor,
        centerTitle: true,
        title: Text(wallet,style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
      body:  Container(
        padding: EdgeInsets.only(left: 20.0,right: 20.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Expanded(
            flex: 4,
            child:Column(
              children:[
          SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sort_bt_txt,style: TextStyle(fontSize: 15.0,color: Maincolor),),
                    Image.asset("assets/ic_browse_sort_over.png",width: 20,),
                  ],
                ),
          SizedBox(height: 20,),
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
                Ink(
                  color: _site == language.nearest? Colors.transparent : Colors.transparent,
                  child: ListTile(
                    title:  Text(Nearest_txt,style: TextStyle(
                        fontSize: 18
                    ),),
                    leading:  Radio(
                      value: language.nearest,
                      groupValue: _site,
                      activeColor: Maincolor,
                      onChanged: (language? value) {
                        // _getCurrentLocation();
                        setState(() {
                          _site = value!;
                        //  getLocation();
                          // fillColor: MaterialStateColor.resolveWith((states) => Colors.white);
                        });
                      },
                    ),
                  ),
                ),
                Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          Ink(
            color: _site == language.newest? Colors.transparent : Colors.transparent,
            child: ListTile(
              title:  Text(Newset_txt,style: TextStyle(
                  fontSize: 18
              ),),
              leading:  Radio(
                value: language.newest,
                groupValue: _site,
                activeColor: Maincolor,
                onChanged: (language? value) {

                  setState(() {
                    _site = value!;
                    CommonUtils.latitude = "0.0";
                    CommonUtils.longitude = "0.0";

                    // fillColor: MaterialStateColor.resolveWith((states) => Colors.white);
                  });
                },
              ),
            ),
          ),
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          Ink(
            color: _site == language.expiring? Colors.transparent : Colors.transparent,
            child: ListTile(
              title:  Text(Expiring_txt,style: TextStyle(
                  fontSize: 18
              ),),
              leading:  Radio(
                activeColor: Maincolor,
                value: language.expiring,
                groupValue: _site,
                onChanged: (language? value) {
                  setState(() {
                    _site = value!;
                    CommonUtils.latitude = "0.0";
                    CommonUtils.longitude = "0.0";
                  });
                },
              ),
            ),
          ),
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          Ink(
            color: _site == language.brandaz? Colors.transparent : Colors.transparent,
            child: ListTile(
              title:  Text(Brand_az,style: TextStyle(
                  fontSize: 18
              ),),
              leading:  Radio(
                activeColor: Maincolor,
                value: language.brandaz,
                groupValue: _site,
                onChanged: (language? value) {
                  setState(() {
                    _site = value!;
                    CommonUtils.latitude = "0.0";
                    CommonUtils.longitude = "0.0";
                  });
                },
              ),
            ),
          ),
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          Ink(
            color: _site == language.brandza? Colors.transparent : Colors.transparent,
            child: ListTile(
              title:  Text(Brand_za,style: TextStyle(
                  fontSize: 18
              ),),
              leading:  Radio(
                activeColor: Maincolor,
                value: language.brandza,
                groupValue: _site,
                onChanged: (language? value) {
                  setState(() {
                    _site = value!;
                    CommonUtils.latitude = "0.0";
                    CommonUtils.longitude = "0.0";
                  });
                },
              ),
            ),
          ),
          Container(decoration: BoxDecoration(color: lightGrey), height: 0.5,),
          SizedBox(
            height: 50,
          )],),),
          Expanded(flex:1,
            child: Container(
              padding: EdgeInsets.only(top: 50),
              //color: Colors.red,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 140,
                    child: TextButton(onPressed: (){
                      Navigator.of(context).pop();

                    }, child: Text(cancel ,style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),),
                      style: ButtonStyle(

                          backgroundColor: MaterialStateProperty.all(Colors.white,),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.grey)


                          ))


                      ),
                    ),


                  ),
                  SizedBox(
                    width: 140,
                    child: TextButton(onPressed: (){
                      var selectedlanguage = _site.toString();
                      debugPrint(selectedlanguage);
                      if(selectedlanguage == "language.expiring"){
                        print("check2");
                        CommonUtils.SelectedWallet_SortBy = "expiry";
                        CommonUtils.SelectedWallet_SortByText = "Expiring";
                      }else if(selectedlanguage == "language.brandaz"){
                      CommonUtils.SelectedWallet_SortBy = "ascend";
                      CommonUtils.SelectedWallet_SortByText = "Brand A-Z";
                      }else if(selectedlanguage == "language.brandza"){
                      CommonUtils.SelectedWallet_SortBy = "descend";
                      CommonUtils.SelectedWallet_SortByText = "Brand Z-A";
                      }
                      else if(selectedlanguage == "language.nearest"){
                        CommonUtils.SelectedWallet_SortBy = "nearest";
                        CommonUtils.SelectedWallet_SortByText = "Nearest";
                      }else{
                        print("check");
                      CommonUtils.SelectedWallet_SortBy = "newest";
                      CommonUtils.SelectedWallet_SortByText = "Newest";
                      }
                      Navigator.pop(context,true);
                      CommonUtils.NAVIGATE_PATH = CommonUtils.walletPage;
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => ConsumerTab()));
                    }, child: Text(apply_txt ,style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),),
                      style: ButtonStyle(

                          backgroundColor:MaterialStateProperty.all(Color(0xFF007AFF),),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),


                          ))


                      ),
                    ),
                  ),

                ],

              ),


            ),),
        ],

    ),
      ),
    ));
  }
 /* _getCurrentLocation() async {
    Geolocation.enableLocationServices().then((result) {
      // Request location
      // print(result);
    }).catchError((e) {
      // Location Services Enablind Cancelled
      // print(e);
    });

    Geolocation.currentLocation(accuracy: LocationAccuracy.best)
        .listen((result) {
      if (result.isSuccessful) {
        setState(() {
          latitude = result.location.latitude.toString();
          longitude = result.location.longitude.toString();
        });
        print(latitude.toString()+":"+longitude.toString());
      }
    });
  }*/
// void getLocation()async{
//   await Geolocator.checkPermission();
//   await Geolocator.requestPermission();
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//   print(position.latitude.toString());
//   print(position.longitude.toString());
//   setState(() {
//
//       CommonUtils.latitude = position.latitude.toString();
//       CommonUtils.longitude = position.longitude.toString();
//   });
//
// }
}
