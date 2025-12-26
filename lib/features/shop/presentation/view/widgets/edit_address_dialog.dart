import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/addresses/address_request.dart';
import '../../viewmodel/addresses_cubit.dart';
import '../../viewmodel/addresses_state.dart';

class EditAddressDialog extends StatefulWidget {
  final dynamic address;

  const EditAddressDialog({super.key, required this.address});

  @override
  State<EditAddressDialog> createState() => _EditAddressDialogState();
}

class _EditAddressDialogState extends State<EditAddressDialog> {
  late final TextEditingController _governorateController;
  late final TextEditingController _cityController;
  late final TextEditingController _streetController;
  late final TextEditingController _buildingController;
  late final TextEditingController _notesController;
  late bool _isPrimary;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _governorateController = TextEditingController(
      text: widget.address.state ?? '',
    );
    _cityController = TextEditingController(text: widget.address.city ?? '');
    _streetController = TextEditingController(
      text: widget.address.street ?? '',
    );
    _buildingController = TextEditingController(
      text: widget.address.building ?? '',
    );
    _notesController = TextEditingController(text: widget.address.notes ?? '');
    _isPrimary = widget.address.isDefault ?? false;
  }

  @override
  void dispose() {
    _governorateController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return BlocConsumer<AddressesCubit, AddressesState>(
      listener: (context, state) {
        if (state is AddressesActionSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.edit_location,
                  color: Colors.green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                local.edit_address,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children: [
                    // Governorate field
                    CustomTextFormField(
                      controller: _governorateController,
                      hint: local.governorate,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter governorate';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // City field
                    CustomTextFormField(
                      controller: _cityController,
                      hint: local.city,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter city';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Street field
                    CustomTextFormField(
                      controller: _streetController,
                      hint: local.street,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter street';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Building number field
                    CustomTextFormField(
                      controller: _buildingController,
                      hint: local.building_number,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                    const SizedBox(height: 16),

                    // Notes field
                    CustomTextFormField(
                      controller: _notesController,
                      hint: 'Notes (Optional)',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
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
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                local.cancel,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed:
                  state is AddressesActionLoading
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
                            latitude: widget.address.latitude ?? 0.0,
                            longitude: widget.address.longitude ?? 0.0,
                          );
                          context.read<AddressesCubit>().updateAddress(
                            widget.address.id!,
                            request,
                          );
                        }
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  state is AddressesActionLoading
                      ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : Text(local.updateText),
            ),
          ],
        );
      },
    );
  }

  void _showDefaultAddressConfirmation(
    BuildContext context,
    VoidCallback onConfirm,
  ) {
    final local = AppLocalizations.of(context)!;
    final cubit = context.read<AddressesCubit>();

    // Check if there's already a default address (excluding current one being edited)
    final hasDefaultAddress = cubit.addresses.any(
      (address) => address.isDefault == true && address.id != widget.address.id,
    );

    if (!hasDefaultAddress) {
      // No other default address exists, just confirm
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
