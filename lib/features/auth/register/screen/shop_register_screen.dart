import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/toast_helper.dart';
import '../../domain/entites/shop_entity.dart';
import '../../forget_password/presentation/viewmodel/verify_code_viewmodel.dart';
import '../viewmodel/shop_register_viewmodel.dart';
import '../../data/models/signup_shop_models/sign_up_shop_request_model.dart';

class ShopRegisterScreen extends StatefulWidget {
  const ShopRegisterScreen({super.key});

  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  String _shopType = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(AppIcons.arrowBack, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        scrolledUnderElevation: 0,
        title: Text(local.signup),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
            listener: (context, state) {
              if (state is ShopRegisterSuccess) {
                ToastHelper.showCustomToast(
                  context,
                  text: state.message,
                  isError: false,
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.emailVerification,
                  (routes) => false,
                  arguments: VerifyEmailData(
                    email: _emailController.text.trim(),
                    isRegister: true,
                  ),
                );
              } else if (state is ShopRegisterError) {
                ToastHelper.showCustomToast(
                  context,
                  text: state.message,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        local.shopSubtitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: AppColors.primary[80],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: AppColors.primary,
                      ),
                      controller: _nameController,
                      hint: local.name,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.primary,
                      ),
                      controller: _emailController,
                      hint: local.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Icons.comment_outlined,
                        color: AppColors.primary,
                      ),
                      controller: _descriptionController,
                      hint: local.shopDescription,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: AppColors.primary,
                      ),
                      controller: _phoneController,
                      hint: local.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                      ),
                      controller: _passwordController,
                      hint: local.password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      hint: Row(
                        children: [
                          Icon(Icons.store, color: AppColors.primary),
                          SizedBox(width: 8),
                          Text(
                            'Select shop type',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      isExpanded: true,
                      value: _shopType.isEmpty ? null : _shopType,
                      items:
                          ['REPAIRER', 'SELLER', 'BOTH']
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      onChanged: (value) {
                        setState(() {
                          _shopType = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Address Fields
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primary,
                            ),
                            controller: _stateController,
                            hint: 'State',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTextFormField(
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: AppColors.primary,
                            ),
                            controller: _cityController,
                            hint: 'City',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            prefixIcon: Icon(
                              Icons.edit_road,
                              color: AppColors.primary,
                            ),
                            controller: _streetController,
                            hint: 'Street',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTextFormField(
                            prefixIcon: Icon(
                              Icons.home_work_outlined,
                              color: AppColors.primary,
                            ),
                            controller: _buildingController,
                            hint: 'Building',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    state is ShopRegisterLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            textColor: AppColors.white,
                            color: AppColors.primary,
                            text: local.signup,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final entity = ShopEntity(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  name: _nameController.text.trim(),
                                  description:
                                      _descriptionController.text.trim(),
                                  phone: '+2${_phoneController.text.trim()}',
                                  shopType: _shopType,
                                  shopAddress: ShopAddress(
                                    state: _stateController.text.trim(),
                                    city: _cityController.text.trim(),
                                    street: _streetController.text.trim(),
                                    building: _buildingController.text.trim(),
                                  ),
                                );
                                context.read<ShopRegisterCubit>().signUp(
                                  entity,
                                );
                              }
                            },
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
