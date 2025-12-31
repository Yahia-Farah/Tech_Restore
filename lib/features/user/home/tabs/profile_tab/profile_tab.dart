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

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              local.profile,
              style: TextStyle(color: AppColors.white),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary,));
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
                color: AppColors.primary,
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
                          color: AppColors.black.withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        user.phone ?? "",
                        style: TextStyle(
                          color: AppColors.black.withValues(alpha: 0.6),
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

                      // Navigation Options
                      _buildNavigationOption(
                        context,
                        icon: Icons.shopping_bag_outlined,
                        title: local.orders,
                        subtitle: 'View your order history',
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              AppRoutes.userOrders,
                            ),
                      ),
                      const SizedBox(height: 12),
                      _buildNavigationOption(
                        context,
                        icon: Icons.build_outlined,
                        title: local.repair,
                        subtitle: 'Track your repair requests',
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              AppRoutes.userRepairs,
                            ),
                      ),
                      const SizedBox(height: 12),
                      _buildNavigationOption(
                        context,
                        icon: Icons.location_on_outlined,
                        title: local.addresses,
                        subtitle: 'Manage your delivery addresses',
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              AppRoutes.userAddresses,
                            ),
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
                              builder:
                                  (context) => BlocProvider(
                                    create:
                                        (context) => getIt<LogoutViewModel>(),
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

  Widget _buildNavigationOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }
}
