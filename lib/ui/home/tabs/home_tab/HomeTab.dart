import 'package:flutter/material.dart';
import 'package:tech_restore/ui/home/tabs/home_tab/CreateOrder.dart';

import '../../../../core/color_manager.dart';
import '../../../../core/reusable_components/CustomButton.dart';
import '../../../../core/strings_manager.dart';
import '../../screen/home_screen.dart';

class Hometab extends StatelessWidget {
  const Hometab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("hello nada"),
          titleTextStyle: TextStyle(
              color: ColorManager.secondary,
              fontSize: 18,
              fontWeight: FontWeight.w700
          )),

      body:
      Container(

        padding: EdgeInsets.all(18),
        width: double.infinity,
        child: CustomButton(
          Textcolor: ColorManager.background,
          color: ColorManager.primary,
          text: StringsManager.neworder,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Createorder()),
            );
          },
        ),
      ),

    );
  }
}
