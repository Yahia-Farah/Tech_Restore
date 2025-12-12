import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/logout_states.dart';
import '../viewmodel/logout_viewmodel.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return BlocConsumer<LogoutViewModel, LogoutStates>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          print("logout successfully");
        } else if (state is LogoutError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            locale!.logoutAlertMsg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
            ),
          ),
          content: Text(
            locale.logoutConfirmTextCenter,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: "Inter",
            ),
          ),
          actions: [
            Row(
              children: [
                CustomElevatedButton(
                  width: 120,
                  height: 50,
                  color: AppColors.white,
                  textColor: Colors.black87,
                  borderColor: AppColors.grey,
                  text: locale.cancel,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 20),
                state is LogoutLoading
                    ? const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red,
                      ),
                    )
                    : CustomElevatedButton(
                      width: 120,
                      height: 50,
                      text: locale.logout,
                      onPressed: () {
                        context.read<LogoutViewModel>().logout();
                      },
                    ),
              ],
            ),
          ],
        );
      },
    );
  }
}
