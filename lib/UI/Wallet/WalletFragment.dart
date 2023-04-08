import 'package:consumer5/UI/Wallet/CardFragments/WalletCardFragment.dart';
import 'package:consumer5/UI/Wallet/EVoucher/WalletNewVoucherFragment.dart';
import 'package:flutter/material.dart';

import '../../res/Colors.dart';

class WalletFragment extends StatefulWidget {
  const WalletFragment({Key? key}) : super(key: key);

  @override
  State<WalletFragment> createState() => _WalletFragmentState();
}

class _WalletFragmentState extends State<WalletFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset('assets/ic_applogo.png'),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Text("Wallet"),
        backgroundColor: Maincolor,),
      body: DefaultTabController(
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


                tabs: [
                  Tab(child: Text('CARDS',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13 ),),),
                  Tab(child: Text('VOUCHERS',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),),




                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              new WalletCardFragment(),
              // new WalletVoucherFragment(),
              new WalletNewVoucherFragment(),
            ],
          ),

        ),
      ),
    );
  }

}
