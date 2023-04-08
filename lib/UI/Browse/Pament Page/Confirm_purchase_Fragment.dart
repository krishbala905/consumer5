import 'package:consumer5/UI/More/Profile.dart';
import 'package:flutter/material.dart';

class Confirm_purchase_Fragment extends StatefulWidget {
  const Confirm_purchase_Fragment({Key? key}) : super(key: key);

  @override
  State<Confirm_purchase_Fragment> createState() => _Confirm_purchase_FragmentState();
}

class _Confirm_purchase_FragmentState extends State<Confirm_purchase_Fragment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("MBM Wheelpower"),
            GrayLine()

          ],

        ),
      ),
    );
  }
}
