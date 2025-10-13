import 'package:flutter/material.dart';
import 'package:tech_restore/core/color_manager.dart';


class CustomButton extends StatelessWidget {
  String text ;
  Color color;
  Color Textcolor;
  void Function() onPressed;
  //
  // final void Function() onPressed ;
  CustomButton({required this.text, required this.color,required this.Textcolor,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(8)
         )
      ),
        onPressed: onPressed
        , child: Text(
      text,style: TextStyle(
      color: Textcolor,
      fontWeight: FontWeight.w500,
      fontSize: 16
    ),
    ));
  }
}
