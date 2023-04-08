import 'dart:convert';

import 'package:consumer5/UI/Wallet/SortFragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import '../Others/AlertDialogUtil.dart';
import '../Others/CommonUtils.dart';
import '../Others/LocalNotificationService.dart';
import '../Others/PPNAPIClass.dart';
import '../Others/PPNApiClassXML.dart';
import '../Others/Urls.dart';
import '../Others/Utils.dart';
import '../res/Colors.dart';
import 'Browse/BrowseFragment.dart';
import 'Inbox/InboxDetails.dart';
import 'Inbox/InboxFragment.dart';
import 'MYID/MyidFragment.dart';
import 'More/MoreFragment.dart';
import 'Wallet/WalletFragment.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ConsumerTab extends StatefulWidget {
  const ConsumerTab({Key? key}) : super(key: key);

  @override
  State<ConsumerTab> createState() => _ConsumerTabState();
}

class _ConsumerTabState extends State<ConsumerTab> {
  String navigatePage="none";

  var tittle="Browse";
  int _selectedIndex = 0;
  var myWalletActive=0;
  var homeActive=1;
  var MyidActive=0;
  var walletActive=0;
  var InboxActive=0;
  var moreActive=0;

  static const List<Widget> _widgetOptions = <Widget>[
    BrowseFragment(),
    WalletFragment(),
    MyidFragment(),
    InboxFragment(),
    MoreFragment(),
  ];

  var isDeviceConnected=false;
  bool isALert=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("testInitConsumerTab");
    // Foreground




    /*if(FirebaseMessaging.onMessage.isBroadcast){
      FirebaseMessaging.onMessage.asBroadcastStream().listen((RemoteMessage message) {




        var encodedData=jsonEncode(message.data);
        var decodedData=jsonDecode(encodedData);
        String showtitle=decodedData["message"];
        String moreData=decodedData["moredata"];

        CommonUtils.msgid=moreData;

        LocalNotificationService.initialize(context);
        LocalNotificationService.displayForBroadCast(appName,showtitle);


      });
    }*/
    //foreground
    FirebaseMessaging.onMessage.listen((message) async {
      print("1:"+message.data.toString());

      if(message.notification!=null){
        print("1:Gokul");
        try{
          debugPrint("Frgnd:1:"+message.data.toString());
          try{
            LocalNotificationService.initialize(context);
            LocalNotificationService.display(message);
          }
          catch(e){
            debugPrint("frgExce:"+e.toString());
          }
          /*var action="0";
          print("q:"+CommonUtils.pid);
          if(CommonUtils.pid!="0"){
            action="1";
          }
          dynamic result=await callPPNAPIXML(context,action,CommonUtils.pid,"","");
*/


        }
        catch(e){
          debugPrint("FrgndExcep"+e.toString());
        }
      }

    });

    //
    // // BackGround
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print("Gokul2");
      if (message.notification != null) {
        print("Gokul1");
        try {

          dynamic result=await callPPNAPIXML(context,"0","","","");
          changeToPage(result);

        }
        catch (e) {
          debugPrint("FrgndExcep" + e.toString());
        }
      }

      if(message.data!=null){
        print("Gokul");
        print("bharathi"+ message.data.toString());
        print("bharathi"+ message.toString());
        print("bharathi"+ message.notification.toString());
        var encodedData=jsonEncode(message.data);
        var decodedData=jsonDecode(encodedData);
        print("decode"+ decodedData.toString());
        String moreData=decodedData["moredata"];
        navigateToInboxDetailsPage(moreData);
      }
    });

    hideKeyboard();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        var action="0";
        print("q:"+CommonUtils.pid);
        if(CommonUtils.pid!="0"){
          action="1";
        }
        // dynamic result=await callPPNAPIXML(context,"","","");
        dynamic result=await callPPNAPIXML(context,action,CommonUtils.pid,"","");
        changeToPage(result);
      }
      catch (e) {
        debugPrint("InitExcep" + e.toString());
      }
    });
    print("bharathicheck3");
    changeToPage(CommonUtils.NAVIGATE_PATH);

    CommonUtils.NAVIGATE_PATH=CommonUtils.none;
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset('assets/ic_action_bar.png'),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text(tittle),
          backgroundColor: Maincolor,
        *//*actions: [
          _selectedIndex==1?
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SortFragment()
                  ));
            },
            child: Container(
              width: 70,
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  setActive(myWalletActive, "assets/ic_browse_sort_normal.png", "assets/ic_browse_sort_normal.png"),
                  SizedBox(height: 5,),

                ],
              ),
            ),
          ): Container(),
        ],*//*
      ),*/
      body: WillPopScope(
        onWillPop: ()async{
          print(CommonUtils.NAVIGATE_PATH);
          Navigator.of(context).pop(true);
          SystemNavigator.pop();
          return false;
        },
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  CommonUtils.Serachkey = "";
                  setState(() {
                    _selectedIndex=0;
                    tittle="Browse";
                    homeActive=1;
                    MyidActive=0;
                    walletActive=0;
                    InboxActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(homeActive, "assets/ic_browse_over.png", "assets/ic_browse_normal.png"),
                      SizedBox(height: 2,),
                      setActiveTittle(homeActive, "Browse"),
                    ],
                  ),
                ),
              )),

              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    CommonUtils.Serachkey = "";
                    _selectedIndex=1;
                    tittle="Wallet";
                    walletActive=1;
                    homeActive=0;
                    MyidActive=0;
                    InboxActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(walletActive, "assets/ic_wallet_over.png", "assets/ic_wallet_normal.png"),
                      SizedBox(height: 2,),
                      setActiveTittle(walletActive, "Wallet"),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    CommonUtils.Serachkey = "";
                    _selectedIndex=2;
                    tittle="My ID";
                    homeActive=0;
                    MyidActive=1;
                    walletActive=0;
                    InboxActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(MyidActive, "assets/ic_myid_over.png", "assets/ic_myid_normal.png"),
                      SizedBox(height: 2,),
                      setActiveTittle(MyidActive, "My ID"),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    CommonUtils.Serachkey = "";
                    _selectedIndex=3;
                    tittle="Inbox";
                    homeActive=0;
                    MyidActive=0;
                    InboxActive=1;
                    walletActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          setActive(InboxActive, "assets/ic_inbox_over.png", "assets/ic_inbox_normal.png"),
                          SizedBox(height: 2,),
                          setActiveTittle(InboxActive, "Inbox"),
                        ],
                      ),
                       _InboxCount(context),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    CommonUtils.Serachkey = "";
                    _selectedIndex=4;
                    tittle="More";
                    homeActive=0;
                    MyidActive=0;
                    walletActive=0;
                    InboxActive=0;
                    moreActive=1;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(moreActive, "assets/ic_more_over.png", "assets/ic_more_normal.png"),
                      SizedBox(height: 2,),
                      setActiveTittle(moreActive, "More"),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
  Widget setActive(var active ,var activeIcon,var inactiveIcon){

    if (active==1){
      return Image.asset(activeIcon,height: 20,width: 25,);
    }
    else{
      return Image.asset(inactiveIcon,height: 20,width: 25,);
    }
  }
  Widget setActiveTittle(var active ,var tittle){

    if (active==1){


      return Text(tittle,style: TextStyle(fontSize: 12,color: poketpurple),);
    }
    else{
      return Text(tittle,style: TextStyle(fontSize: 12,color: Colors.grey),);
    }
  }
  void changeToPage(String navigatePath){

    if(navigatePath==CommonUtils.walletPage){
      setState(() {
        _selectedIndex=1;
        tittle="Wallet";
        homeActive=0;
        MyidActive=0;
        walletActive=1;
        InboxActive = 0;
        moreActive=0;
      });
    }

    else if(navigatePath==CommonUtils.MyidPage){
      setState(() {
        _selectedIndex=2;
        tittle="My ID";
        homeActive=0;
        MyidActive=1;
        walletActive=0;
        InboxActive = 0;
        moreActive=0;
      });
    }

    /*else if(navigatePath == CommonUtils.rewardsPage) {
      setState(() {
        _selectedIndex=2;
        tittle="Rewards";
        homeActive=0;
        MyidActive=1;
        walletActive=0;
        InboxActive = 0;
        moreActive=0;
      });

    }*/
    else if(navigatePath==CommonUtils.inboxPage){

      setState(() {
        _selectedIndex=3;
        tittle="Inbox";
        homeActive=0;
        MyidActive=0;
        walletActive=0;
        InboxActive = 1;
        moreActive=0;
      //  WidgetsBinding.instance.addPostFrameCallback((_) {
          /*Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  InboxFragment()));*/
        });
     // });
    }
    else if(navigatePath==CommonUtils.KEY_FEEDBACK_POINT_TRANSACTION){
      showRewardsDeliveryDialog(context,CommonUtils.PPN_RESPONSE_CONTENT);
    }
    else if(navigatePath==CommonUtils.KEY_MEMBER_POINT_TRANSACTION){
      showRewardsDeliveryDialog(context,CommonUtils.PPN_RESPONSE_CONTENT);
    }
    else if(navigatePath==CommonUtils.none){

    }

  }
  Widget showInboxCount(var _counter){
    if(_counter=="0"){
      return Container();
    }
    else{
      return  Positioned(

        right: 20,
        top: 5,
        child: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(9),
          ),
          constraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: Text(
            '$_counter',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  void navigateToInboxDetailsPage(var moreData){

    if(moreData!="0"){
      CommonUtils.msgid=moreData;
      Navigator.push(context, MaterialPageRoute(builder: (context) => InboxDetails(),));
    }

  }
  Future<String> getInboxCount() async {

    final http.Response response = await http.post(
      Uri.parse(INBOX_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "country_index": "+65",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,

      },
    ).timeout(Duration(seconds: 30));

    if(response.statusCode==200)
    {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var data2 = data['info'];
      debugPrint("checkkk"+data.toString(),wrapWidth:1200);
      var posts1 = stringSplit(data2['p13']);


      print("InboxCount:"+posts1);
      return posts1;

    }
    else {

      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<String> _InboxCount(BuildContext context) {

    return FutureBuilder<String>(

      future: getInboxCount(),
      builder: (context, snapshot) {


        if (snapshot.connectionState == ConnectionState.done) {

          final String ? posts = snapshot.data;
          if(posts!=null&& posts!="none"){
            print(posts.toString());
            return _buildPostsInbox(context, posts);
          }
          else{
            print("checkbhar");
            return Container();
          }

        } else {
          return Center(
            child:SpinKitCircle(
              color: corporateColor,
              size: 10.0,
            ),
          );
        }
      },
    );
  }
  Widget _buildPostsInbox(BuildContext context, String posts) {
    return showInboxCount(posts);
  }
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
}
