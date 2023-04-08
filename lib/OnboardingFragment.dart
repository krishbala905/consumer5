
// import 'package:consumer5/UI/SignUp/SignupCarSelectionFragment.dart';
import 'package:consumer5/UI/SignUp/Signupfragment.dart';
import 'package:consumer5/res/Colors.dart';
import 'package:consumer5/res/Strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Others/Urls.dart';
import 'UI/Login/Login.dart';

class OnboardingFragment extends StatefulWidget {
  const OnboardingFragment({Key? key}) : super(key: key);

  @override
  State<OnboardingFragment> createState() => _OnboardingFragmentState();
}

class _OnboardingFragmentState extends State<OnboardingFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_bg_main.png'),
              fit: BoxFit.fill,
            )),
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 200.0,),
              Text(alreadyhaveanaccount, style: TextStyle(color: Colors.white,fontSize: 18)),
              SizedBox(height: 15.0,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Login(),));
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(60.0, 0, 60.0, 0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: backgroundcolor3),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*SizedBox(
                          width: 2,
                        ),*/
                        Expanded(
                          child: Image.asset("assets/ic_login.png",color: backgroundcolor3,height: 25, width: 25,),
                          flex: 1,
                        ),
                        SizedBox( width: 50,),
                        Expanded(
                          flex:2,
                          child: Text(
                            login_small_letter,
                            style: TextStyle(
                              color:backgroundcolor3,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //child: Image.asset("assets/email_corporate_color.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupFragment(),));

                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(60.0, 0, 60.0, 0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color:  backgroundcolor3,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: backgroundcolor3),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        /*SizedBox(
                          width: 2,
                        ),*/
                        Expanded(
                          child: Image.asset("assets/ic_signup.png",color: Colors.white,height: 20, width: 25,),
                          flex: 1,
                        ),
                        SizedBox( width: 30,),
                        Expanded(
                          flex: 3,
                          child: Text(
                            createnewaccount,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          //child: Image.asset("assets/email_corporate_color.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right: 30),
                child: Container(

                  child: Column(


                    children: [
                      // SizedBox(width: 10),
                      Text(Bysigningyoutoagreethe,style: TextStyle(color: Colors.white,
                        fontSize: 13,
                      ),),
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: ()async{
                          final url =TERMS_AND_CONDITION_URL;
                          if (await canLaunch(url)) launch(url);
                        },
                        child: Text(termsofservice + " " + ampersand,style: TextStyle(fontSize: 13,color: Colors.white,
                            decoration: TextDecoration.underline),),
                      ),
                      SizedBox(height: 5,),
                      /*Text(ampersand,style: TextStyle(fontSize: 13,)),*/
                      GestureDetector(
                        onTap: ()async{
                          final url = PRIVACY_URL;
                          if (await canLaunch(url)) launch(url);
                        },
                        child: Text(privacypolicy,style: TextStyle(color: Colors.white,fontSize: 13,
                            decoration: TextDecoration.underline),),
                      ),

                    ],

                  ),
                ),
              ),

            ]
        ),
      ),
    ));
  }
}
