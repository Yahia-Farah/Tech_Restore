import 'package:flutter/material.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
          title: Text("hello nada"),
          titleTextStyle: TextStyle(
              color: AppColors.secondary,
              fontSize: 18,
              fontWeight: FontWeight.w700
          )),

      body:
      Container(

        padding: EdgeInsets.all(18),
        width: double.infinity,
        child: CustomElevatedButton(
          textColor: AppColors.white,
          color: AppColors.primary,
          text: local.newOrder,
          onPressed: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => Createorder()),
            // );
          },
        ),
      ),

    );
  }
}
