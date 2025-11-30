import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../../core/config/di.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../auth/logout/viewmodel/logout_viewmodel.dart';
import '../../../../auth/logout/views/logout_widget.dart';
import '../../../profile/presentation/viewmodel/profile_cubit.dart';
import '../../../profile/presentation/viewmodel/states/profile_states.dart';

class AccountTab extends StatelessWidget {
  AccountTab({super.key});

  final List<Map<String, String>> repairHistory = [
    {
      "title": "Macbook Pro",
      "date": "March 2024",
      "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
    },
    {
      "title": "Macbook Air",
      "date": "June 2019",
      "image": "https://images.unsplash.com/photo-1509395176047-4a66953fd231",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(local.profile),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is ProfileLoaded) {
              final user = state.profile;

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProfileCubit>().getUserProfile();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${user.firstName ?? ''} ${user.lastName ?? ''}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email ?? "",
                        style: TextStyle(
                          color: AppColors.black.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        user.phone ?? "",
                        style: TextStyle(
                          color: AppColors.black.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomElevatedButton(
                            width: 180,
                            height: 50,
                            textColor: AppColors.black,
                            color: AppColors.buttons,
                            text: local.editProfile,
                            onPressed: () async {
                              final updated = await Navigator.pushNamed(
                                context,
                                AppRoutes.editProfile,
                                arguments: user,
                              );

                              if (updated == true && context.mounted) {
                                context.read<ProfileCubit>().getUserProfile();
                              }
                            },
                          ),
                          const SizedBox(width: 10),
                          CustomElevatedButton(
                            width: 180,
                            height: 50,
                            textColor: AppColors.white,
                            color: AppColors.primary,
                            text: local.addPhoto,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text("${local.email}: ${user.email ?? ''}"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text("${local.phone}: ${user.phone ?? ''}"),
                      ),
                      const Divider(height: 30),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          local.repair,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Column(
                        children: repairHistory.map((device) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                device["image"]!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(device["title"]!),
                            subtitle: Text(device["date"]!),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          textColor: AppColors.white,
                          color: AppColors.primary,
                          text: local.signOut,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => BlocProvider(
                                create: (context) => getIt<LogoutViewModel>(),
                                child: const LogoutDialogWidget(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
