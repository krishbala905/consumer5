import 'package:consumer5/Others/CommonUtils.dart';
import 'package:consumer5/Others/NativeAlertDialog.dart';
import 'package:consumer5/UI/SignUp/SecondSignupScreen.dart';
import 'package:consumer5/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../../Others/AlertDialogUtil.dart';
import '../../res/Colors.dart';
import 'package:intl/intl.dart';
class SignupFragment extends StatefulWidget {
  const SignupFragment({Key? key}) : super(key: key);

  @override
  State<SignupFragment> createState() => _SignupFragmentState();
}

class _SignupFragmentState extends State<SignupFragment> {
  TextEditingController NameTxt = TextEditingController();
  TextEditingController DobTxt = TextEditingController();
  TextEditingController EmailTxt = TextEditingController();
  TextEditingController PasswordTxt = TextEditingController();
  TextEditingController MobilenumberTxt = TextEditingController();
   double Contantheight = 60;
   var GednerId = 1;
   String SelectGender =  'Male';
  var countrycode="+65";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: backgroundlight,
          appBar: AppBar(title: Text("Sign Up",style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor: Maincolor,elevation: 0.0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              color: Colors.white,
              icon:Icon(Icons.arrow_back),
              //replace with our own icon data.
        ),)
          ,
           body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(


              child: Column(
                children: [
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/ic_form_fullname.png",width: 25,height: 25,),
                           SizedBox(width: 8,),
                           Expanded(

                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: TextField(
                                  cursorColor: Colors.grey,
                                  controller: NameTxt,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(color: backgroundcolor2, fontSize: 15

                                  ),

                                  decoration: InputDecoration(
                                    hintText: "Full name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),

                          InfoIconMessage(Infomessage: "We'd love to customize how we address you on your card.",),




                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                 /* Container(
                    height: Contantheight,

                    child: Row(
                      children: [
                        Expanded(
                          flex:8,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(value: 1, groupValue: GednerId, onChanged: (value){


                              setState(() {
                                GednerId = 1;
                                SelectGender = "Male";


                              });

                            },


                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => Maincolor),


                            ),
                            SizedBox(width: 5,),
                            Text("Male",style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.grey

                            ),),
                            Radio(value: 2, groupValue:GednerId, onChanged: (values){


                              setState(() {
                                GednerId = 2;
                                SelectGender = "Female";



                              });


                            },


                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => Maincolor),

                            ),
                            Text("Female",style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),),



                          ],
                        ),),

                        Expanded(
                          flex: 1,
                          child: InfoIconMessage(Infomessage: "This will help us determine the perfect promotions for you.",),)
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  Container(
                    height: Contantheight,

                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/icon_mobile.png",width: 25,height: 25,),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(

                                decoration:BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                          color: Colors.grey,
                                          width: 0.5,
                                        )
                                    )
                                ) ,
                                child: CountryCodePicker(
                                  initialSelection: 'SG',
                                  favorite: ['+65','SG'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: true,
                                  onChanged: _onCountryChange,
                                  showFlag: false,
                                  enabled: true,
                                  textStyle: TextStyle(

                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                )
                            ),
                          ),
                          Text("+65",style: TextStyle(
                            color: Colors.grey
                          ),),
                          Container(
                            height: Contantheight,
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller:MobilenumberTxt,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          InfoIconMessage(Infomessage: "Storing your number will make it easier and faster for you to share a promotion with a friend!",),



                        ],
                      ),
                    ),
                  ),*/
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/ic_form_email.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: EmailTxt,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_!#\$%&*+-/=?^`{|}~]')),

                                ],

                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          InfoIconMessage(Infomessage: "Your email will be used as your Login ID",),




                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                 /* Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/icon_birthday.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: DobTxt,
                                //keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_!#$%&*+-/=?^\`{|}~]')),
                                ],

                                decoration: InputDecoration(
                                  hintText: "Date of Birth",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().subtract(Duration(days:1)),
                                    firstDate: DateTime(
                                        1860 ), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Maincolor, // <-- SEE HERE
                                            onPrimary: Colors.white, // <-- SEE HERE
                                            onSurface: Colors.black, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Maincolor, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      DobTxt.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),
                          ),

                         InfoIconMessage(Infomessage: "Sharing your birthday will allow us to celebrate your day by rewarding you with special treats.")




                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),*/
                  Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/ic_form_password.png",width: 25,height: 25,),
                          SizedBox(width: 8,),
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: TextField(
                                obscureText: true,
                                cursorColor: Colors.grey,
                                controller: PasswordTxt,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: backgroundcolor2, fontSize: 15

                                ),

                                decoration: InputDecoration(
                                  hintText: "Create New Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          InfoIconMessage(Infomessage: "You will use this password for Login")




                        ],


                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                        )
                    ),
                  ),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: () async {
                      if(NameTxt.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "Please Enter Full Name");
                      }
                     /* else if(MobilenumberTxt.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "Please Enter Mobile Number");
                      }*/
                      else if(EmailTxt.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "Please Enter Email Address");

                      }
                      else if(!validateEmail(EmailTxt.text)){
                        showAlertDialog_oneBtn(this.context, alert, "Please Enter Valid EmailID");
                      }
                      else if(PasswordTxt.text.isEmpty == true) {
                        ShowNativeDialogue(context, "Alert", "Please Enter Password");
                      }
                      else {
                        var data = [];
                        data.add(NameTxt.text.toString());
                        /*data.add(SelectGender.toString());
                        data.add(countrycode.toString()+","+MobilenumberTxt.text.toString());*/
                        data.add(EmailTxt.text.toString());
                       // data.add(DobTxt.text.toString());
                        data.add(PasswordTxt.text.toString());


                        CommonUtils.SignupData=data;

                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => SecondSigupScreen(Data: data)));
                      }
                    },
                    child: Container(
                      height: 40,

                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(child: Text("Sign Up",style: TextStyle(
                          color: Colors.white
                      ),)),
                      decoration: BoxDecoration(
                          color: poketblue2,
                          borderRadius:BorderRadius.circular(20)
                      ),
                    ),
                  ),
                 /* Container(
                    height: Contantheight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Expanded(child: Divider(thickness: 1.5)),
                          Text("OR",
                              style: TextStyle(fontSize: 20, color: Colors.grey)),
                          Expanded(child: Divider(thickness: 1.5)),
                        ],


                      ),
                    ),

                  ),
                  InkWell(
                    onTap: () async {

                    },
                    child: Container(
                      height: 40,

                      width: MediaQuery.of(context).size.width * 0.8,
                      child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        *//*SizedBox(
                          width: 2,
                        ),*//*
                        Expanded(
                          child: Image.asset("assets/ic_facebook.png",height: 25, width: 25,),
                          flex: 1,
                        ),
                        //SizedBox( width: 50,),
                        Expanded(
                          flex:2,
                          child: Text(
                            connect_with_facebook,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          //child: Image.asset("assets/email_corporate_color.png"),
                        ),
                      ],
                    ),
                      decoration: BoxDecoration(
                          color:blueFB,
                          borderRadius:BorderRadius.circular(20)
                      ),
                    ),
                  ),*/
                ],

              ),
            ),
          ),

    ));
  }
  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    countrycode = countryCode.toString();
  }
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return false;
    } else {
      return true;
    }
  }
}

class InfoIconMessage extends StatelessWidget {
  final Infomessage;
  const InfoIconMessage({
    Key? key,required this.Infomessage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
         //showAlertDialog_oneBtn(context,"",Infomessage);
         ShowNativeDialogue(context,"",Infomessage);
          //ShowNativeDialogue(context, "", Infomessage.toString());

        },
        child: Image.asset("assets/icon_info.png",width: 25,height: 25,));
  }

}
