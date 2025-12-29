import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../data/models/products/get_all_category_model.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../presentation/viewmodel/devices_cubit.dart';
import '../../../presentation/viewmodel/devices_state.dart';
import '../../../data/models/products/product_model.dart';
import '../../../data/models/products/add_product_request.dart';
import '../widgets/add_device_screen.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>('');
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(1);
  final int itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    context.read<DevicesCubit>().getAllDevices(isRefresh: true);
    _searchController.addListener(() {
      _searchQueryNotifier.value = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQueryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return BlocConsumer<DevicesCubit, DevicesState>(
      listener: (context, state) {
        if (state is DeviceAddSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.msg)));
        } else if (state is DeviceAddError || state is DevicesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text((state as dynamic).msg)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<DevicesCubit>();
        List<ProductModel> devices = cubit.devices;
        if (state is DevicesLoading ||
            (state is DevicesInitial && devices.isEmpty)) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        }
        return ValueListenableBuilder<String>(
          valueListenable: _searchQueryNotifier,
          builder: (context, searchQuery, _) {
            final filteredDevices =
                searchQuery.isEmpty
                    ? devices
                    : devices.where((d) {
                      final name = d.name?.toLowerCase() ?? '';
                      final desc = d.description?.toLowerCase() ?? '';
                      final query = searchQuery.toLowerCase();
                      return name.contains(query) || desc.contains(query);
                    }).toList();
            return ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, currentPage, _) {
                final totalPages =
                    filteredDevices.isEmpty
                        ? 1
                        : (filteredDevices.length / itemsPerPage).ceil();
                final startIndex = (currentPage - 1) * itemsPerPage;
                final endIndex =
                    (startIndex + itemsPerPage < filteredDevices.length)
                        ? startIndex + itemsPerPage
                        : filteredDevices.length;
                final currentDevices =
                    filteredDevices.isEmpty
                        ? <ProductModel>[]
                        : filteredDevices.sublist(startIndex, endIndex);
                return RefreshIndicator(
                  color: Colors.green,
                  onRefresh: () => cubit.getAllDevices(isRefresh: true),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  local.devices_management,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  local.devices_management_desc,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  controller: _searchController,
                                  hint: local.search_hint,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  text: local.add_device,
                                  onPressed: () async {
                                    final devicesCubit = cubit;
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (newContext) => BlocProvider.value(
                                              value: devicesCubit,
                                              child: const AddDeviceScreen(),
                                            ),
                                      ),
                                    );
                                    if (result == true) {
                                      cubit.getAllDevices(isRefresh: true);
                                    }
                                  },
                                  color: AppColors.primary,
                                  textColor: Colors.white,
                                  suffixIcon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Devices Table
                          Card(
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: [
                                      DataColumn(
                                        label: Text(local.device_name),
                                      ),
                                      DataColumn(
                                        label: Text(local.device_type),
                                      ),
                                      DataColumn(label: Text(local.price)),
                                      DataColumn(label: Text(local.quantity)),
                                      DataColumn(label: Text(local.status)),
                                      DataColumn(label: Text(local.actions)),
                                    ],
                                    rows:
                                        currentDevices
                                            .map(
                                              (device) => _buildDeviceRow(
                                                device,
                                                local,
                                              ),
                                            )
                                            .toList(),
                                  ),
                                ),
                                // Pagination bar like offers_screen
                                if (filteredDevices.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredDevices.length} ${local.devices}",
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.chevron_left,
                                              ),
                                              onPressed:
                                                  currentPage > 1
                                                      ? () =>
                                                          _currentPageNotifier
                                                                  .value =
                                                              currentPage - 1
                                                      : null,
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: null,
                                              child: Text('$currentPage'),
                                            ),
                                            if (currentPage < totalPages)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                    ),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors
                                                                .grey
                                                                .shade300,
                                                        foregroundColor:
                                                            Colors.black,
                                                      ),
                                                  onPressed:
                                                      () =>
                                                          _currentPageNotifier
                                                                  .value =
                                                              currentPage + 1,
                                                  child: Text(
                                                    '${currentPage + 1}',
                                                  ),
                                                ),
                                              ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.chevron_right,
                                              ),
                                              onPressed:
                                                  (currentPage < totalPages ||
                                                          (currentPage ==
                                                                  totalPages &&
                                                              !cubit.lastPage))
                                                      ? () async {
                                                        if (currentPage <
                                                            totalPages) {
                                                          // Local pagination
                                                          _currentPageNotifier
                                                                  .value =
                                                              currentPage + 1;
                                                        } else if (currentPage ==
                                                                totalPages &&
                                                            !cubit.lastPage) {
                                                          // Fetch next page from API
                                                          await cubit
                                                              .getAllDevices();
                                                          // Move to next page after fetching
                                                          _currentPageNotifier
                                                                  .value =
                                                              currentPage + 1;
                                                        }
                                                      }
                                                      : null,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, ProductModel product) async {
    final local = AppLocalizations.of(context)!;
    final outerContext =
        context; // Capture the outer context that has access to DevicesCubit
    final cubit = outerContext.read<DevicesCubit>();
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: product.name ?? '');
    final descriptionController = TextEditingController(
      text: product.description ?? '',
    );
    final priceController = TextEditingController(
      text: product.price?.toString() ?? '',
    );
    final imageUrlController = TextEditingController(
      text: product.imageUrl ?? '',
    );
    final stockQuantityController = TextEditingController(
      text: product.stock?.toString() ?? '',
    );
    String? selectedCategoryId = product.categoryId;
    String condition = product.condition?.toUpperCase() ?? 'NEW';
    String? imageWarning;
    List<Content> categories = cubit.categories;
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder:
              (ctx, setState) => AlertDialog(
                title: Text(
                  local.edit,
                  style: TextStyle(color: AppColors.primary),
                ),
                content: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: nameController,
                          label: local.device_name,
                          validator:
                              (v) => v!.trim().isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: descriptionController,
                          label: local.devices_management_desc,
                          validator:
                              (v) => v!.trim().isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: priceController,
                          label: local.price,
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v!.trim().isEmpty) return 'Required';
                            if (double.tryParse(v.trim()) == null)
                              return 'Invalid number';
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: imageUrlController,
                          label: 'Image URL',
                          keyboardType: TextInputType.url,
                          onChanged: (val) {
                            setState(() {
                              imageWarning = null;
                            });
                          },
                        ),
                        if (imageUrlController.text.isNotEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imageUrlController.text,
                                  height: 94,
                                  width: 110,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (c, e, s) => const SizedBox(
                                        height: 94,
                                        width: 110,
                                        child: Center(
                                          child: Text('Invalid/No Image'),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        if (imageWarning != null)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                imageWarning!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: stockQuantityController,
                          label: local.quantity,
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v!.trim().isEmpty) return 'Required';
                            if (int.tryParse(v.trim()) == null)
                              return 'Invalid number';
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedCategoryId,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.grey,
                            hintText: local.inventory_category,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items:
                              categories
                                  .map(
                                    (category) => DropdownMenuItem<String>(
                                      value: category.id,
                                      child: Text(category.name ?? ''),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategoryId = value;
                            });
                          },
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: condition,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.grey,
                            hintText: local.status,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'NEW', child: Text('NEW')),
                            DropdownMenuItem(
                              value: 'USED',
                              child: Text('USED'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              condition = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(
                      local.cancel,
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  CustomElevatedButton(
                    text: local.save,
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      if (imageUrlController.text.isNotEmpty &&
                          !imageUrlController.text.startsWith('http')) {
                        setState(() {
                          imageWarning =
                              'Please upload your image to an image hosting and paste a public URL.';
                        });
                        return;
                      }
                      final req = AddProductRequest(
                        name: nameController.text.trim(),
                        description: descriptionController.text.trim(),
                        price: double.tryParse(priceController.text.trim()),
                        imageUrl:
                            imageUrlController.text.trim().isEmpty
                                ? null
                                : imageUrlController.text.trim(),
                        category:
                            selectedCategoryId != null
                                ? Category(id: selectedCategoryId)
                                : null,
                        stockQuantity: int.tryParse(
                          stockQuantityController.text.trim(),
                        ),
                        condition: condition,
                      );
                      if (product.id != null) {
                        outerContext.read<DevicesCubit>().updateDevice(
                          product.id!,
                          req,
                        );
                      }
                      Navigator.pop(ctx);
                    },
                    color: AppColors.primary,
                    textColor: Colors.white,
                    borderRadius: 12,
                    width: 120,
                    height: 44,
                  ),
                ],
              ),
        );
      },
    );
  }

  DataRow _buildDeviceRow(ProductModel device, AppLocalizations local) {
    Color statusColor =
        (device.condition?.toUpperCase() == 'NEW') ? Colors.green : Colors.red;
    Color bgColor =
        (device.condition?.toUpperCase() == 'NEW')
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1);
    return DataRow(
      cells: [
        DataCell(Text(device.name ?? '')),
        DataCell(Text(device.categoryName ?? '')),
        DataCell(Text(device.price?.toStringAsFixed(2) ?? '')),
        DataCell(Text(device.stock?.toString() ?? '')),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              device.condition?.toUpperCase() == 'NEW'
                  ? local.newDev
                  : local.used,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              _buildActionButton(
                icon: Icons.edit,
                label: local.edit,
                color: Colors.blue,
                onTap: () => _showEditDialog(context, device),
                isRTL: Localizations.localeOf(context).languageCode == 'ar',
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                icon: Icons.delete,
                label: local.delete,
                color: Colors.red,
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (ctx) => AlertDialog(
                          title: Text(
                            local.delete,
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            'Are you sure you want to delete this device?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text(local.cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: Text(
                                local.delete,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );
                  if (confirm == true) {
                    context.read<DevicesCubit>().deleteDevice(device.id!);
                  }
                },
                isRTL: Localizations.localeOf(context).languageCode == 'ar',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required bool isRTL,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
