import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../data/models/products/add_product_request.dart';
import '../../viewmodel/devices_cubit.dart';
import '../../viewmodel/devices_state.dart';
import '../../../data/models/products/get_all_category_model.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _stockQuantityController = TextEditingController();
  String? _selectedCategoryId;
  String _condition = 'NEW';
  String? _imageWarning;
  List<Content> _categories = [];

  @override
  void initState() {
    super.initState();
    context.read<DevicesCubit>().getCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _stockQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<DevicesCubit, DevicesState>(
      listener: (context, state) {
        if (state is DeviceAddSuccess) {
          Navigator.pop(context, true);
        }
        if (state is DeviceAddError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.msg)));
        }
        if (state is CategoriesLoaded) {
          setState(() {
            _categories = state.categories;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Image.asset(AppIcons.arrowBack, color: AppColors.primary),
            ),
            scrolledUnderElevation: 0,
            title: Text(local.add_device),
            titleTextStyle: TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      label: local.device_name,
                      validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.grey,
                      ),
                      height: 150,
                      child: Expanded(
                        child: CustomTextFormField(
                          controller: _descriptionController,
                          label: local.devices_management_desc,
                          validator:
                              (v) => v!.trim().isEmpty ? 'Required' : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _priceController,
                      label: local.price,
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v!.trim().isEmpty) return 'Required';
                        if (double.tryParse(v.trim()) == null)
                          return 'Invalid number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _imageUrlController,
                      label: 'Image URL',
                      keyboardType: TextInputType.url,
                      onChanged: (val) {
                        setState(() {
                          _imageWarning = null;
                        });
                      },
                    ),
                    if (_imageUrlController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            _imageUrlController.text,
                            height: 120,
                            width: 140,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (c, e, s) => const SizedBox(
                                  height: 120,
                                  width: 140,
                                  child: Center(
                                    child: Text('Invalid/No Image'),
                                  ),
                                ),
                          ),
                        ),
                      ),
                    if (_imageWarning != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          _imageWarning!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _stockQuantityController,
                      label: local.quantity,
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v!.trim().isEmpty) return 'Required';
                        if (int.tryParse(v.trim()) == null)
                          return 'Invalid number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.grey,
                        hintText: local.inventory_category,
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
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      items:
                          _categories
                              .map(
                                (category) => DropdownMenuItem<String>(
                                  value: category.id,
                                  child: Text(category.name ?? ''),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });
                      },
                      validator: (v) => v == null ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _condition,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.grey,
                        hintText: local.status,
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
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      items: const [
                        DropdownMenuItem(value: 'NEW', child: Text('NEW')),
                        DropdownMenuItem(value: 'USED', child: Text('USED')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _condition = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        text: local.save,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_imageUrlController.text.isNotEmpty &&
                                !_imageUrlController.text.startsWith('http')) {
                              setState(() {
                                _imageWarning =
                                    'Please upload your image to an image hosting and paste a public URL.';
                              });
                              return;
                            }
                            final product = AddProductRequest(
                              name: _nameController.text.trim(),
                              description: _descriptionController.text.trim(),
                              price: double.tryParse(
                                _priceController.text.trim(),
                              ),
                              imageUrl:
                                  _imageUrlController.text.trim().isEmpty
                                      ? null
                                      : _imageUrlController.text.trim(),
                              category:
                                  _selectedCategoryId != null
                                      ? Category(id: _selectedCategoryId)
                                      : null,
                              stockQuantity: int.tryParse(
                                _stockQuantityController.text.trim(),
                              ),
                              condition: _condition,
                            );
                            context.read<DevicesCubit>().addDevice(product);
                          }
                        },
                        color: AppColors.primary,
                        textColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
