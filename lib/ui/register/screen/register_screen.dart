import 'package:flutter/material.dart';
import 'package:tech_restore/core/color_manager.dart';
import 'package:tech_restore/core/strings_manager.dart';
import 'package:tech_restore/ui/admin/tabs/admin_dashboard_screen.dart';

import '../../../core/reusable_components/CustomButton.dart';
import '../../../core/reusable_components/customfield.dart';
import '../../admin/admin_layout.dart';
import '../../home/screen/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "register";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(StringsManager.signup),
        titleTextStyle: TextStyle(
          color: ColorManager.secondary,
          fontSize: 18,
          fontWeight: FontWeight.w700
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Align(
                  alignment: Alignment.center,
                  child:
                  Text(StringsManager.signupquote, style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22
                  ),),
                ),
              Align(
                alignment: Alignment.center,
                child:
                Text(StringsManager.secsignupquote, style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                ),),
              ),
              SizedBox(height: 20,),
              Customfield(
                hint: StringsManager.name,
                keyboard: TextInputType.name,
          
              ),
              SizedBox(height: 20,),
              Customfield(
                hint: StringsManager.username,
                keyboard: TextInputType.name,
              ),
              SizedBox(height: 20,),
              Customfield(
                hint: StringsManager.Email,
                keyboard: TextInputType.emailAddress,
              ),
              SizedBox(height: 20,),
              Customfield(
                hint: StringsManager.phone,
                keyboard: TextInputType.phone,
              ),
              SizedBox(height: 20,),
              Customfield(
                hint: StringsManager.password,
                keyboard: TextInputType.visiblePassword,
                isObscured: true,
              ),
              SizedBox(height: 20,),
              Text(
                  StringsManager.bycontinuing,
                style: TextStyle(
                  fontSize: 18,
                  color: ColorManager.hint
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: CustomButton(
                  Textcolor: ColorManager.secondary,
                  color: ColorManager.bottons,
                  text: StringsManager.signup,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: CustomButton(
                  Textcolor: ColorManager.secondary,
                  color: ColorManager.bottons,
                  text: StringsManager.withgoogle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminLayout()),
                    );
                  },
                ),
              ),







            ],
          ),
        ),
      ),
    );
  }
}
