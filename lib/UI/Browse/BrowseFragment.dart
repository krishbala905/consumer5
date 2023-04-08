


import 'package:consumer5/UI/Browse/CardFragment.dart';
import 'package:consumer5/UI/Browse/VoucherFragment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import 'Model/ECardModel.dart';
class BrowseFragment extends StatefulWidget {

  const BrowseFragment({Key? key}) : super(key: key);

  @override
  State<BrowseFragment> createState() => _BrowseFragmentState();
}

class _BrowseFragmentState extends State<BrowseFragment> {
  TextEditingController _Searching = TextEditingController();
  bool _searchBoolean = false;
  int Index = 0;
  String keys = "" ;
Icon cusicon = Icon(Icons.search);
Widget cussearchbar = Text("Browse");


  Widget _searchTextField() { //add
    return TextField(
      controller: _Searching,
        style: TextStyle(color:Colors.white, fontSize: 15

        ),

      // onChanged: (value) {
      //   print(value);
      // },
      onEditingComplete: () {
        FocusScope.of(context).unfocus();

        CommonUtils.Serachkey = _Searching.text;
        print(_Searching.text);


      },


    );
  }
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset('assets/ic_applogo.png'),
        ),
        elevation: 0,
       actions: <Widget>[
         IconButton(onPressed: (){
           setState(() {
             if(this.cusicon.icon == Icons.search){
               this. cusicon = Icon(Icons.cancel);
               this.cussearchbar = TextField(

                 textInputAction: TextInputAction.go,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: "Enter Keyword",
                   hintStyle: TextStyle(
                     color: Colors.white70,
                   )
                 ),
                 controller: _Searching,
                 style: TextStyle(color:Colors.white, fontSize: 15

                 ),
                 onEditingComplete: () {
                   FocusScope.of(context).unfocus();

                   CommonUtils.Serachkey = _Searching.text;
                   print(_Searching.text);


                 },


               );
             }else{
               this.cusicon = Icon(Icons.search);
               this.cussearchbar = Text("Browse");
               _Searching.text = "";
             }
           });
         }, icon: cusicon),
       ],
        automaticallyImplyLeading: false,
        centerTitle: true,
          title: cussearchbar,
        //Text("Browse"),
        backgroundColor: Maincolor,
      ),
      body: new DefaultTabController(
        length: 2,
        child: new Scaffold(


          appBar: new PreferredSize(

            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              decoration: BoxDecoration(color:Colors.white),
              height: 40.0,
              child: new TabBar(
                indicatorColor: poketblue,
                unselectedLabelColor: lightGrey,
                labelColor:poketblue,
                onTap: (index){
                  CommonUtils.Serachkey = "";


                },


                tabs: [
                  Tab(child: Text('CARDS',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13 ),),),
                  Tab(child: Text('VOUCHERS',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),),



                ],
              ),
            ),
          ),

          body:  new TabBarView(
            children: [
              CardFragment(),

              VoucherFragment(),
        ],
      ),

        ),
      ),
    );

  }


}
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
 // Future<List<ECardModel>> getEcardData() async


}