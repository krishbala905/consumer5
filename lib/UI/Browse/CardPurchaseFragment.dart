
    
    
    
import 'package:consumer5/UI/Browse/Purchase_web.dart';
import 'package:flutter/material.dart';

import '../../res/Colors.dart';

class CardPurchaseFragment extends StatefulWidget {
  var cardImgurl,programName,prgmId,prgmType,outletId,programPrice;
   CardPurchaseFragment(this.cardImgurl,this.programName,this.prgmId,this.prgmType,this.outletId,this.programPrice,{Key? key}) : super(key: key);

  @override
  State<CardPurchaseFragment> createState() => _CardPurchaseFragmentState(cardImgurl,programName,prgmId,prgmType,outletId,programPrice);
}

class _CardPurchaseFragmentState extends State<CardPurchaseFragment> {
  TextEditingController qtyController=TextEditingController();
  TextEditingController amountController1=TextEditingController();
  TextEditingController amountController2=TextEditingController();
  TextEditingController amountController3=TextEditingController();
  var cardImgurl,programName,prgmId,programtypetemp,outletId,programPrice;


  _CardPurchaseFragmentState(this.cardImgurl,this.programName,this.prgmId, this.programtypetemp,
      this.outletId, this.programPrice);


  @override
  void initState() {
    // TODO: implement initState
    amountController1.text=programPrice;
    amountController2.text=programPrice;
    amountController3.text=programPrice;
print("checkbhar"+programtypetemp.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: Image.asset('assets/ic_action_bar.png'),
        // ),
        elevation: 0,
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Text("Confirm Purchase"),
        backgroundColor: Maincolor,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(left:10,right: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text("MBM Wheelpower Reward",style: TextStyle(color: Colors.black),),
                    SizedBox(height: 10,),
                    Container(height: 1,color: grey,),
                    SizedBox(height: 15,),
                    // CardLayout(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(cardImgurl,width: MediaQuery.of(context).size.width/2.5,height: 100,fit: BoxFit.fill,),
                        SizedBox(width:10),
                        Text(programName,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(height: 1,color: grey,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[

                          Expanded(flex:2,child: Row(
                            children: [
                            Text("Qty"),
                            SizedBox(width: 10,),
                              Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(border: Border.all(width: 1,color:grey)),
                                  child: Center(child: Text("1"))),
                            ],
                          ),),
                          Expanded(flex:1,child: Text("Price:"),),
                          Expanded(flex:1,child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextField(decoration: InputDecoration(
                                border: InputBorder.none,
                              ),textAlign: TextAlign.end,controller: amountController1,)),),
                      ]
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[

                          Expanded(flex:2,child: Text("Subtotal"),),

                          Expanded(flex:1,child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextField(controller: amountController2,textAlign: TextAlign.end,decoration: InputDecoration(border: InputBorder.none,),)),),
                      ]
                    ),
                    SizedBox(height: 10,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[

                          Expanded(flex:2,child: Text("Total Price",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500),),),

                          Expanded(flex:1,child: Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: TextField(controller: amountController3,style:TextStyle(fontSize: 21,fontWeight: FontWeight.w500) ,textAlign: TextAlign.end,decoration: InputDecoration(border: InputBorder.none,),)),),
                        ]
                    ),
                    SizedBox(height: 10,),
                    Container(height: 1,color: grey,),
                    SizedBox(height: 25,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[

                          Expanded(flex:1,child: Text("Payment",),),

                          Expanded(flex:1,child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Image.asset("assets/ic_paypal_visa.png",width: MediaQuery.of(context).size.width/4,)
                          ),),
                        ]
                    ),


                  ],
                ),
              ),
            ),
          ),
          Expanded(flex:3,child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                // Padding(
                //   padding: const EdgeInsets.only(left:65,right: 65),
                //   child: Text("By confirming the purchase, I agree to Poket Rewards app Terms of Use and Privacy Policy.",textAlign: TextAlign.center,),
                // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,

                child:Text("By confirming the purchase, I agree to Poket Rewards app Terms of Use and Privacy Policy.",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 12)) ,
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:30,right: 30),
                child: InkWell(
                  onTap: (){
                    var programtype="";
                    if (programtypetemp == 1){
                      programtype = "rm";}

                    if (programtypetemp == 2){
                      programtype = "rs";}

                    if (programtypetemp == 3){
                      programtype = "rv";}

print("check"+programtype.toString());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Purchase_web(prgmId, "1", programtype, programPrice, outletId),));
                  },
                  child: Container(
                    height:50,decoration:BoxDecoration(color: backgroundcolor1,borderRadius: BorderRadius.circular(20),border: Border.all(color: backgroundcolor1)),child: Center(child: Text("Confirm Purchase",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,))),),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/ic_security.png",width: 10,height:10,fit:BoxFit.fill ,),
                    SizedBox(width: 10,),
                    Text("All information is transmitted over a secure connection",style: TextStyle(color: Colors.grey,fontSize: 11),),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
    