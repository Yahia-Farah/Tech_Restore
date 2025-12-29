import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../data/models/profile_response.dart';
import '../../viewmodel/edit_profile_cubit.dart';
import '../../viewmodel/states/edit_profile_states.dart';
import '../../../../../../core/widgets/custom_toast.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileResponse user;

  const EditProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          OverlayState overlayState = Overlay.of(context);
          final overlayEntry = OverlayEntry(
            builder:
                (_) => CustomToast(text: local.profileUpdated, isError: false),
          );
          overlayState.insert(overlayEntry);
          Future.delayed(const Duration(seconds: 2), () {
            overlayEntry.remove();
          });

          Navigator.pop(context, true);
        } else if (state is EditProfileError) {
          OverlayState overlayState = Overlay.of(context);
          final overlayEntry = OverlayEntry(
            builder:
                (_) => CustomToast(
                  text: "${local.error}: ${state.message}",
                  isError: true,
                ),
          );
          overlayState.insert(overlayEntry);
          Future.delayed(const Duration(seconds: 2), () {
            overlayEntry.remove();
          });
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
            ),
            title: Text(
              local.editProfileTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage(
                    "assets/images/profile_image.png",
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  controller: cubit.firstNameController,
                  label: local.firstName,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: cubit.lastNameController,
                  label: local.lastName,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: cubit.emailController,
                  label: local.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: cubit.phoneController,
                  label: local.phoneNumber,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 30),
                CustomElevatedButton(
                  text: local.updateProfile,
                  isLoading: state is EditProfileLoading,
                  onPressed: () {
                    cubit.editProfile();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
