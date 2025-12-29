import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/config/di.dart';
import '../../../data/repositories/shop_repository.dart';
import '../../../data/models/addresses/address_request.dart';
import '../../viewmodel/addresses_cubit.dart';
import '../../viewmodel/addresses_state.dart';
import '../widgets/edit_address_dialog.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              AddressesCubit(getIt<ShopRepository>())
                ..getAllAddresses(isRefresh: true),
      child: const _AddressesScreenContent(),
    );
  }
}

class _AddressesScreenContent extends StatefulWidget {
  const _AddressesScreenContent();

  @override
  State<_AddressesScreenContent> createState() =>
      _AddressesScreenContentState();
}

class _AddressesScreenContentState extends State<_AddressesScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isPrimary = false;

  @override
  void dispose() {
    _governorateController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _governorateController.clear();
    _cityController.clear();
    _streetController.clear();
    _buildingController.clear();
    _notesController.clear();
    setState(() {
      _isPrimary = false;
    });
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
          local.addresses,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocListener<AddressesCubit, AddressesState>(
        listener: (context, state) {
          if (state is AddressesActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            _clearForm();
          } else if (state is AddressesActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.msg), backgroundColor: Colors.red),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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
                      Icons.location_on,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    local.branches_and_addresses,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Existing addresses list
              BlocBuilder<AddressesCubit, AddressesState>(
                builder: (context, state) {
                  if (state is AddressesLoading &&
                      context.read<AddressesCubit>().addresses.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  } else if (state is AddressesError) {
                    return Center(
                      child: Column(
                        children: [
                          Text('Error: ${state.msg}'),
                          ElevatedButton(
                            onPressed:
                                () => context
                                    .read<AddressesCubit>()
                                    .getAllAddresses(isRefresh: true),
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final addresses = context.read<AddressesCubit>().addresses;

                  if (addresses.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Center(
                        child: Text(
                          'No addresses found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children:
                        addresses
                            .map(
                              (address) => Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${address.state ?? ''}, ${address.city ?? ''}, ${address.street ?? ''}${address.building != null ? ', ${address.building}' : ''}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (address.notes != null &&
                                              address.notes!.isNotEmpty) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              address.notes!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                          if (address.isDefault == true) ...[
                                            const SizedBox(height: 4),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.green.withValues(
                                                  alpha: 0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                'Default',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green[700],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (
                                                dialogContext,
                                              ) => BlocProvider.value(
                                                value:
                                                    context
                                                        .read<AddressesCubit>(),
                                                child: EditAddressDialog(
                                                  address: address,
                                                ),
                                              ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.edit_outlined,
                                          color: Colors.green,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        if (address.id != null) {
                                          context
                                              .read<AddressesCubit>()
                                              .deleteAddress(address.id!);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Add new address form
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment:
                        isArabic
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      Text(
                        local.add_new_address,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Governorate field
                      _buildTextField(
                        controller: _governorateController,
                        hint: local.governorate,
                        isArabic: isArabic,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter governorate';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // City field
                      _buildTextField(
                        controller: _cityController,
                        hint: local.city,
                        isArabic: isArabic,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Street field
                      _buildTextField(
                        controller: _streetController,
                        hint: local.street,
                        isArabic: isArabic,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter street';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Building number field
                      _buildTextField(
                        controller: _buildingController,
                        hint: local.building_number,
                        isArabic: isArabic,
                      ),
                      const SizedBox(height: 16),

                      // Notes field
                      _buildTextField(
                        controller: _notesController,
                        hint: 'Notes (Optional)',
                        isArabic: isArabic,
                      ),
                      const SizedBox(height: 20),

                      // Primary address checkbox
                      Row(
                        mainAxisAlignment:
                            isArabic
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          if (!isArabic) ...[
                            Checkbox(
                              value: _isPrimary,
                              onChanged: (value) {
                                if (value == true) {
                                  _showDefaultAddressConfirmation(context, () {
                                    setState(() {
                                      _isPrimary = true;
                                    });
                                  });
                                } else {
                                  setState(() {
                                    _isPrimary = false;
                                  });
                                }
                              },
                              activeColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            local.set_as_primary,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          if (isArabic) ...[
                            const SizedBox(width: 8),
                            Checkbox(
                              value: _isPrimary,
                              onChanged: (value) {
                                if (value == true) {
                                  _showDefaultAddressConfirmation(context, () {
                                    setState(() {
                                      _isPrimary = true;
                                    });
                                  });
                                } else {
                                  setState(() {
                                    _isPrimary = false;
                                  });
                                }
                              },
                              activeColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Add address button
                      BlocBuilder<AddressesCubit, AddressesState>(
                        builder: (context, state) {
                          final isLoading = state is AddressesActionLoading;
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  isLoading
                                      ? null
                                      : () {
                                        if (_formKey.currentState!.validate()) {
                                          final request = AddressRequest(
                                            state: _governorateController.text,
                                            city: _cityController.text,
                                            street: _streetController.text,
                                            building:
                                                _buildingController.text.isEmpty
                                                    ? null
                                                    : _buildingController.text,
                                            notes:
                                                _notesController.text.isEmpty
                                                    ? null
                                                    : _notesController.text,
                                            isDefault: _isPrimary,
                                            latitude:
                                                0.0, // You can implement location picker later
                                            longitude: 0.0,
                                          );
                                          context
                                              .read<AddressesCubit>()
                                              .addAddress(request);
                                        }
                                      },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child:
                                  isLoading
                                      ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : Text(
                                        local.add_address,
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
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool isArabic,
    String? Function(String?)? validator,
  }) {
    return CustomTextFormField(
      controller: controller,
      hint: hint,
      validator: validator,
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
    );
  }

  void _showDefaultAddressConfirmation(
    BuildContext context,
    VoidCallback onConfirm,
  ) {
    final local = AppLocalizations.of(context)!;
    final cubit = context.read<AddressesCubit>();

    // Check if there's already a default address
    final hasDefaultAddress = cubit.addresses.any(
      (address) => address.isDefault == true,
    );

    if (!hasDefaultAddress) {
      // No default address exists, just confirm
      onConfirm();
      return;
    }

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.warning_outlined,
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  local.warning,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            content: Text(
              local.default_address_warning,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(
                  local.cancel,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(local.confirm),
              ),
            ],
          ),
    );
  }
}
