import 'package:consumer5/Others/CommonUtils.dart';
import 'package:flutter/material.dart';

import '../../res/Colors.dart';

class Carlist extends StatefulWidget {
  final List brandname;
   Carlist(  {Key? key,required this.brandname}) : super(key: key);

  @override
  State<Carlist> createState() => _CarlistState(brandname);
}

class _CarlistState extends State<Carlist> {
  List<dynamic> brandname = [];

  _CarlistState(this.brandname);

  void initState(){
    print("chekc"+brandname.length.toString());
    print(brandname[1].toString());

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Maincolor,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            color: Colors.black,
            icon:Icon(Icons.arrow_back),
            //replace with our own icon data.
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: brandname.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  Navigator.pop(context,true);
                  print(brandname[index].toString());

                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(2),
                  child: Text(brandname[index].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                    decoration: BoxDecoration(
                border: Border(
                bottom: BorderSide(color: backgroundcolor2,width: 0.5)
                )
                ),
                ),
              );
            }

        )
    );
  }
}
