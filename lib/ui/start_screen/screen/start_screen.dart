import 'package:flutter/material.dart';
import 'package:tech_restore/core/color_manager.dart';
import 'package:tech_restore/core/strings_manager.dart';
import 'package:tech_restore/ui/login/screen/login_screen.dart';

import '../../../core/assset_manager.dart';
import '../../../core/reusable_components/CustomButton.dart';
import '../../register/screen/register_screen.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "start";
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: Container(
       padding: EdgeInsets.symmetric(
         horizontal: 20
       ),
       width: double.infinity,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Image.asset(AsssetsManager.StartScreen),
           SizedBox(height: 30,),
           Text(StringsManager.welcome,style:TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 20,
             color: ColorManager.secondary
           ),),
           Text(StringsManager.Startquoute,style:TextStyle(
             fontWeight: FontWeight.w700,
             fontSize: 18,
             color: ColorManager.secondary
           ),),
           SizedBox(height: 50,),
           Container(
             width: double.infinity,
               child: CustomButton(
                 Textcolor: ColorManager.background,
                 color: ColorManager.primary,
                 onPressed: () { Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => LoginScreen()),
               ); },
                 text: StringsManager.start,

               ))
         ],
       ),
     ),
    );
  }
}
