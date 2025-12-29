import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/offers/offer_request.dart';
import '../../../presentation/viewmodel/offers_cubit.dart';
import '../../../presentation/viewmodel/offers_state.dart';
import '../../../data/models/offers/get_all_offers_model.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>('');
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(1);
  final int itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    context.read<OffersCubit>().getAllOffers(isRefresh: true);
    _searchController.addListener(() {
      _searchQueryNotifier.value = _searchController.text;
      _currentPageNotifier.value = 1;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQueryNotifier.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BlocConsumer<OffersCubit, OffersState>(
      listener: (context, state) {
        if (state is OffersActionSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is OffersActionError || state is OffersError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text((state as dynamic).msg)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<OffersCubit>();
        List<Content> offers = cubit.offers;
        if (state is OffersLoading ||
            (state is OffersInitial && offers.isEmpty)) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        }

        return ValueListenableBuilder<String>(
          valueListenable: _searchQueryNotifier,
          builder: (context, searchQuery, _) {
            // Filter offers based on search query
            final filteredOffers =
                searchQuery.isEmpty
                    ? offers
                    : offers.where((o) {
                      final name = (o.name ?? '').toLowerCase();
                      final description = (o.description ?? '').toLowerCase();
                      final query = searchQuery.toLowerCase();
                      return name.contains(query) ||
                          description.contains(query);
                    }).toList();

            return ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, currentPage, _) {
                // Pagination logic
                final totalPages =
                    filteredOffers.isEmpty
                        ? 1
                        : (filteredOffers.length / itemsPerPage).ceil();
                final startIndex = (currentPage - 1) * itemsPerPage;
                final endIndex =
                    (startIndex + itemsPerPage < filteredOffers.length)
                        ? startIndex + itemsPerPage
                        : filteredOffers.length;
                final currentOffers =
                    filteredOffers.isEmpty
                        ? <Content>[]
                        : filteredOffers.sublist(startIndex, endIndex);

                return Scaffold(
                  backgroundColor: Colors.grey.shade100,
                  body: RefreshIndicator(
                    color: Colors.green,
                    onRefresh: () => cubit.getAllOffers(isRefresh: true),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
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
                                    local.offersTitle,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    local.offersSubtitle,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Search + Add Offer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: _searchController,
                                    hint: local.searchOffers,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                CustomElevatedButton(
                                  text: local.addNewOffer,
                                  onPressed:
                                      () =>
                                          _showAddOrEditDialog(context, local),
                                  color: Colors.green.shade50,
                                  textColor: Colors.green,
                                  borderRadius: 12,
                                  width: 138,
                                  height: 48,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Table
                            Card(
                              child: Column(
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: [
                                        DataColumn(
                                          label: Text(local.offerColumnTitle),
                                        ),
                                        DataColumn(
                                          label: Text(local.offerColumnContent),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            local.offerColumnDiscount,
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            local.offerColumnDuration,
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(local.offerColumnStatus),
                                        ),
                                        DataColumn(
                                          label: Text(local.offerColumnActions),
                                        ),
                                      ],
                                      rows:
                                          currentOffers
                                              .map(
                                                (offer) => _buildOfferRow(
                                                  context,
                                                  offer,
                                                  local,
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                  // Pagination
                                  if (filteredOffers.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredOffers.length} ${local.offersTitle}",
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
                                                                !cubit
                                                                    .lastPage))
                                                        ? () async {
                                                          if (currentPage <
                                                              totalPages) {
                                                            _currentPageNotifier
                                                                    .value =
                                                                currentPage + 1;
                                                          } else if (currentPage ==
                                                                  totalPages &&
                                                              !cubit.lastPage) {
                                                            await cubit
                                                                .getAllOffers();
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
                                  SizedBox(height: 10),
                                ],
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
          },
        );
      },
    );
  }

  DataRow _buildOfferRow(
    BuildContext context,
    Content offer,
    AppLocalizations local,
  ) {
    Color statusColor;
    String status = offer.status ?? "";
    switch (status) {
      case "ACTIVE":
        statusColor = Colors.green;
        break;
      case "SCHEDULED":
        statusColor = Colors.blue;
        break;
      case "EXPIRED":
        statusColor = Colors.black;
        break;
      default:
        statusColor = Colors.grey;
    }
    String discount =
        offer.discountValue != null ? offer.discountValue.toString() : "-";
    if (offer.discountType != null &&
        offer.discountType is String &&
        offer.discountType!.isNotEmpty) {
      discount += " " + offer.discountType.toString();
    }
    // Format duration to be more readable
    String formatDateForDisplay(String? dateString) {
      if (dateString == null || dateString.isEmpty) return '-';
      try {
        final date = DateTime.parse(dateString);
        return '${date.day}/${date.month}/${date.year}';
      } catch (e) {
        return dateString;
      }
    }

    String startDateFormatted = formatDateForDisplay(offer.startDate);
    String endDateFormatted = formatDateForDisplay(offer.endDate);
    String duration = "$startDateFormatted to $endDateFormatted";
    return DataRow(
      cells: [
        DataCell(Text(offer.name ?? "")),
        DataCell(Text(offer.description ?? "")),
        DataCell(Text(discount)),
        DataCell(Text(duration)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(status, style: TextStyle(color: statusColor)),
          ),
        ),
        DataCell(
          Row(
            children: [
              _buildActionButton(
                icon: Icons.edit,
                label: local.edit,
                color: Colors.blue,
                onTap:
                    () => _showAddOrEditDialog(
                      context,
                      AppLocalizations.of(context)!,
                      offer: offer,
                    ),
                isRTL: Localizations.localeOf(context).languageCode == 'ar',
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                icon: Icons.delete,
                label: local.delete,
                color: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (ctx) => AlertDialog(
                          title: Text(
                            local.delete,
                            style: TextStyle(color: AppColors.primary),
                          ),
                          content: Text(local.are_you_sure_delete),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text(
                                local.cancel,
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                context.read<OffersCubit>().deleteOffer(
                                  offer.id ?? "",
                                );
                              },
                              child: Text(
                                local.delete,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );
                },
                isRTL: Localizations.localeOf(context).languageCode == 'ar',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showAddOrEditDialog(
    BuildContext context,
    AppLocalizations local, {
    Content? offer,
  }) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: offer?.name ?? '');
    final descController = TextEditingController(
      text: offer?.description ?? '',
    );
    final discountController = TextEditingController(
      text: offer?.discountValue?.toString() ?? '',
    );
    final startDateController = TextEditingController(
      text:
          offer?.startDate != null
              ? DateTime.tryParse(
                    offer!.startDate!,
                  )?.toLocal().toIso8601String().split('T').first ??
                  ''
              : '',
    );
    final endDateController = TextEditingController(
      text:
          offer?.endDate != null
              ? DateTime.tryParse(
                    offer!.endDate!,
                  )?.toLocal().toIso8601String().split('T').first ??
                  ''
              : '',
    );
    String statusValue = offer?.status ?? 'ACTIVE';
    DateTime? startDate =
        offer?.startDate != null ? DateTime.tryParse(offer!.startDate!) : null;
    DateTime? endDate =
        offer?.endDate != null ? DateTime.tryParse(offer!.endDate!) : null;
    final outerContext =
        context; // Capture the outer context that has access to OffersCubit

    String formatDateTimeForApi(DateTime? dt, {bool isEnd = false}) {
      if (dt == null) return '';
      final dateString = dt.toIso8601String().split('T').first;
      return isEnd ? '${dateString}T23:59:59' : '${dateString}T00:00:00';
    }

    await showDialog(
      context: context,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (dialogContext, setDialogState) => AlertDialog(
                  title: Text(offer == null ? local.addNewOffer : local.edit),
                  content: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFormField(
                            controller: nameController,
                            label: local.offerColumnTitle,
                            validator:
                                (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            controller: descController,
                            label: local.offerColumnContent,
                            validator:
                                (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            controller: discountController,
                            label: local.offerColumnDiscount,
                            keyboardType: TextInputType.number,
                            validator:
                                (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: statusValue,
                            onChanged: (val) {
                              if (val != null) {
                                setDialogState(() => statusValue = val);
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.grey,
                              hintText: local.offerColumnStatus,
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
                              DropdownMenuItem(
                                value: 'ACTIVE',
                                child: Text('ACTIVE'),
                              ),
                              DropdownMenuItem(
                                value: 'SCHEDULED',
                                child: Text('SCHEDULED'),
                              ),
                              DropdownMenuItem(
                                value: 'EXPIRED',
                                child: Text('EXPIRED'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Start date field
                          GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: dialogContext,
                                initialDate: startDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setDialogState(() {
                                  startDate = picked;
                                  startDateController.text =
                                      picked
                                          .toLocal()
                                          .toIso8601String()
                                          .split('T')
                                          .first;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextFormField(
                                controller: startDateController,
                                label: 'Start Date',
                                readonly: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // End date field
                          GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: dialogContext,
                                initialDate: endDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setDialogState(() {
                                  endDate = picked;
                                  endDateController.text =
                                      picked
                                          .toLocal()
                                          .toIso8601String()
                                          .split('T')
                                          .first;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextFormField(
                                controller: endDateController,
                                label: 'End Date',
                                readonly: true,
                              ),
                            ),
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
                    SizedBox(width: 20),
                    CustomElevatedButton(
                      text: local.save,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        final req = OfferRequest(
                          name: nameController.text.trim(),
                          description: descController.text.trim(),
                          discountValue: double.tryParse(
                            discountController.text.trim(),
                          ),
                          discountType: 'PERCENTAGE',
                          status: statusValue,
                          startDate: formatDateTimeForApi(startDate),
                          endDate: formatDateTimeForApi(endDate, isEnd: true),
                        );
                        if (offer != null && offer.id != null) {
                          outerContext.read<OffersCubit>().updateOffer(
                            offer.id!,
                            req,
                          );
                        } else {
                          outerContext.read<OffersCubit>().addOffer(req);
                        }
                        Navigator.pop(ctx);
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      borderRadius: 12,
                      width: 120,
                      height: 55,
                    ),
                  ],
                ),
          ),
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
