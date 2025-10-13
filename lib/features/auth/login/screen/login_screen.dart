import 'package:flutter/material.dart';

import '../../../../core/color_manager.dart';
import '../../../../core/reusable_components/CustomButton.dart';
import '../../../../core/reusable_components/customfield.dart';
import '../../../../core/strings_manager.dart';
import '../../../shop/layout.dart';
import '../../../user/home/screen/home_screen.dart';
import '../../register/screen/register_screen.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(StringsManager.login),
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
                Text(StringsManager.welcomeback, style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22
                ),),
              ),
              SizedBox(height: 20,),
              Customfield(
                hint: StringsManager.Email,
                keyboard: TextInputType.emailAddress,
              ),
              SizedBox(height: 20,),
              Customfield(
                hint: StringsManager.password,
                keyboard: TextInputType.visiblePassword,
                isObscured: true,
              ),
              SizedBox(height: 17,),
              Text(StringsManager.forgetpassword,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color:ColorManager.hint
              ),),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: CustomButton(
                  Textcolor: ColorManager.background,
                  color: ColorManager.primary,
                  text: StringsManager.login,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
              SizedBox(height: 14,),
              Container(
                width: double.infinity,
                child: CustomButton(
                  Textcolor: ColorManager.secondary,
                  color: ColorManager.bottons,
                  text: StringsManager.withgoogle, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainLayout()),
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
                  text: StringsManager.newuser,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
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
