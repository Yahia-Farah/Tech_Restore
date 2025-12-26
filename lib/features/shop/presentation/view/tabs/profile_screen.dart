import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/config/di.dart';
import '../../../data/repositories/shop_repository.dart';
import '../../viewmodel/profile_cubit.dart';
import '../../viewmodel/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt<ShopRepository>())..getShopProfile(),
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatefulWidget {
  const _ProfileScreenContent();

  @override
  State<_ProfileScreenContent> createState() => _ProfileScreenContentState();
}

class _ProfileScreenContentState extends State<_ProfileScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _populateFields(profile) {
    _nameController.text = profile.name ?? '';
    _descriptionController.text = profile.description ?? '';
    _phoneController.text = profile.phone ?? '';
  }

  void _clearPasswordField() {
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Image.asset(AppIcons.arrowBack, color: AppColors.white),
        ),
        title: Text(
          local.profile,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return IconButton(
                  icon: Icon(_isEditing ? Icons.close : Icons.edit),
                  onPressed: () {
                    setState(() {
                      if (_isEditing) {
                        _clearPasswordField();
                      } else {
                        _populateFields(state.profile);
                      }
                      _isEditing = !_isEditing;
                    });
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            setState(() {
              _isEditing = false;
            });
            _clearPasswordField();
          } else if (state is ProfileUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.green));
            } else if (state is ProfileUpdateLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.green));
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.msg}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<ProfileCubit>().getShopProfile(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is ProfileLoaded || state is ProfileUpdateSuccess) {
              // Handle both ProfileLoaded and ProfileUpdateSuccess states
              final profile = state is ProfileLoaded 
                  ? state.profile 
                  : (state as ProfileUpdateSuccess).profile;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          // Shop icon with background
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.store,
                              size: 48,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Shop name
                          Text(
                            profile.name ?? local.shop_name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          
                          // Description if available
                          if (profile.description != null && profile.description!.isNotEmpty) ...[
                            Text(
                              profile.description!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 16),
                          ],
                          
                          // Status badges row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Verification badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: profile.verified == true 
                                      ? Colors.green.withValues(alpha: 0.2)
                                      : Colors.orange.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      profile.verified == true ? Icons.verified : Icons.pending,
                                      color: profile.verified == true ? Colors.green : Colors.orange,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      profile.verified == true ? local.verified_status : local.under_review,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: profile.verified == true ? Colors.green : Colors.orange,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              if (profile.rating != null && profile.rating! > 0) ...[
                                const SizedBox(width: 12),
                                // Rating badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        profile.rating!.toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.amber,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    if (!_isEditing) ...[
                      // Display Mode - New Design
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with icon
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  local.shop_information,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Shop ID
                            _buildInfoRowWithIcon(
                              icon: Icons.tag,
                              label: profile.id ?? local.not_provided,
                              iconColor: Colors.green,
                            ),
                            const SizedBox(height: 16),

                            // Email
                            _buildInfoRowWithIcon(
                              icon: Icons.email_outlined,
                              label: profile.email ?? local.not_provided,
                              iconColor: Colors.green,
                            ),
                            const SizedBox(height: 16),

                            // Phone
                            _buildInfoRowWithIcon(
                              icon: Icons.phone_outlined,
                              label: profile.phone ?? local.not_provided,
                              iconColor: Colors.green,
                            ),
                            const SizedBox(height: 16),

                            // Status badges
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    profile.activate == true ? local.active_status : local.inactive,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Verification status
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    profile.verified == true ? local.verified_status : local.under_review,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Rating
                            if (profile.rating != null && profile.rating! > 0) ...[
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${profile.rating?.toStringAsFixed(1)} ⭐',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Created date
                            if (profile.createdAt != null) ...[
                              _buildInfoRowWithIcon(
                                icon: Icons.calendar_today_outlined,
                                label: _formatDate(profile.createdAt!),
                                iconColor: Colors.green,
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Updated date
                            if (profile.updatedAt != null) ...[
                              _buildInfoRowWithIcon(
                                icon: Icons.update_outlined,
                                label: _formatDate(profile.updatedAt!),
                                iconColor: Colors.green,
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Shop type
                            if (profile.shopType != null) ...[
                              _buildInfoRowWithIcon(
                                icon: Icons.category_outlined,
                                label: profile.shopType!,
                                iconColor: Colors.green,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      if (profile.shopAddress != null) ...[
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[200]!),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title with icon
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    local.shop_address_title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // State
                              if (profile.shopAddress!.state != null) ...[
                                _buildInfoRowWithIcon(
                                  icon: Icons.location_city_outlined,
                                  label: profile.shopAddress!.state!,
                                  iconColor: Colors.green,
                                ),
                                const SizedBox(height: 16),
                              ],

                              // City
                              if (profile.shopAddress!.city != null) ...[
                                _buildInfoRowWithIcon(
                                  icon: Icons.location_on_outlined,
                                  label: profile.shopAddress!.city!,
                                  iconColor: Colors.green,
                                ),
                                const SizedBox(height: 16),
                              ],

                              // Street
                              if (profile.shopAddress!.street != null) ...[
                                _buildInfoRowWithIcon(
                                  icon: Icons.streetview_outlined,
                                  label: profile.shopAddress!.street!,
                                  iconColor: Colors.green,
                                ),
                                const SizedBox(height: 16),
                              ],

                              // Building
                              if (profile.shopAddress!.building != null) ...[
                                _buildInfoRowWithIcon(
                                  icon: Icons.business_outlined,
                                  label: profile.shopAddress!.building!,
                                  iconColor: Colors.green,
                                ),
                                const SizedBox(height: 16),
                              ],

                              // Notes
                              if (profile.shopAddress!.notes != null && profile.shopAddress!.notes!.isNotEmpty) ...[
                                _buildInfoRowWithIcon(
                                  icon: Icons.note_outlined,
                                  label: profile.shopAddress!.notes!,
                                  iconColor: Colors.green,
                                ),
                                const SizedBox(height: 16),
                              ],

                              // Default address badge
                              if (profile.shopAddress!.isDefault == true) ...[
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        local.default_address,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ] else ...[
                      // Edit Mode
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(
                                local.edit_profile,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Name field
                              _buildTextField(
                                controller: _nameController,
                                hint: local.shop_name,
                                isArabic: isArabic,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter shop name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Description field
                              TextFormField(
                                controller: _descriptionController,
                                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                                maxLines: 3,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.grey,
                                  hintText: local.shop_description_label,
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                    horizontal: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Phone field
                              _buildTextField(
                                controller: _phoneController,
                                hint: local.phone,
                                isArabic: isArabic,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter phone number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Password field (optional)
                              _buildTextField(
                                controller: _passwordController,
                                hint: local.new_password_optional,
                                isArabic: isArabic,
                                obscureText: true,
                              ),
                              const SizedBox(height: 24),

                              // Update button
                              BlocBuilder<ProfileCubit, ProfileState>(
                                builder: (context, state) {
                                  final isLoading = state is ProfileUpdateLoading;
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: isLoading ? null : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<ProfileCubit>().updateShopProfile(
                                            name: _nameController.text,
                                            description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
                                            phone: _phoneController.text,
                                            password: _passwordController.text.isEmpty ? null : _passwordController.text,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              local.updateProfile,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }
            return const Center(child: Text('No profile data'));
          },
        ),
      ),
    );
  }

  Widget _buildInfoRowWithIcon({
    required IconData icon,
    required String label,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool isArabic,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return CustomTextFormField(
      controller: controller,
      hint: hint,
      validator: validator,
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
      obscureText: obscureText,
    );
  }
}