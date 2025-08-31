import 'package:flutter/material.dart';
import 'package:tech_restore/core/color_manager.dart';

class Customfield extends StatelessWidget {
  String hint;
  TextInputType keyboard;
  bool isObscured ;
   Customfield({
     this.isObscured = false,
     required this.hint,
     required this.keyboard
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:keyboard ,
      obscureText: isObscured,
      decoration: InputDecoration(
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

        ),
        hintStyle: TextStyle(
          color: ColorManager.hint,
          fontSize: 16,
          fontWeight: FontWeight.w400
        ),
          hintText: hint,
          suffixIcon: isObscured? Icon(
            Icons.visibility_off_rounded,
            size: 24,
            color: ColorManager.hint,
          ) : null ,

    ),
    );
  }
}
