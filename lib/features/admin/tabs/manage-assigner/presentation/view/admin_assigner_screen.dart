import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';

class AdminAssignerScreen extends StatefulWidget {
  const AdminAssignerScreen({super.key});

  @override
  State<AdminAssignerScreen> createState() => _AdminAssignerScreenState();
}

class _AdminAssignerScreenState extends State<AdminAssignerScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";
  final int _totalAssigners = 0;
  final int _pendingAssigners = 0;
  final int _approvedAssigners = 0;
  final List<Map<String, dynamic>> _assigners = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.card_giftcard,
                  color: AppColors.primary[70],
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  local.assigner_management,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary[70],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              local.monitor_and_manage_assigners,
              style: TextStyle(fontSize: 14, color: AppColors.black[40]),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.card_giftcard,
                    iconColor: AppColors.primary[70] ?? AppColors.black,
                    label: local.total_assigners,
                    value: _totalAssigners.toString(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.pending_outlined,
                    iconColor: Colors.orange,
                    label: local.pending,
                    value: _pendingAssigners.toString(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                    label: local.approved,
                    value: _approvedAssigners.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              local.search,
              style: TextStyle(fontSize: 14, color: AppColors.hint),
            ),
            const SizedBox(height: 8),
            Card(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.black[30]!, width: 1),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _searchController,
                      hint: local.search_by_name_email_phone,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.black[30]!,
                      ),
                      onChanged: (val) {
                        setState(() => _searchQuery = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildFilterButton(
                                local.all,
                                "All",
                                Icons.list,
                                _selectedFilter == "All",
                                onPressed: () => _onFilterChanged("All"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildFilterButton(
                                local.pending,
                                "Pending",
                                Icons.close,
                                _selectedFilter == "Pending",
                                onPressed: () => _onFilterChanged("Pending"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFilterButton(
                                local.approved,
                                "Approved",
                                Icons.check,
                                _selectedFilter == "Approved",
                                onPressed: () => _onFilterChanged("Approved"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildFilterButton(
                                local.suspended,
                                "Suspended",
                                Icons.delete_outline,
                                _selectedFilter == "Suspended",
                                onPressed: () => _onFilterChanged("Suspended"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.black[30]!, width: 1),
              ),
              elevation: 0,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColors.grey,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            local.id.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            local.name.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            local.email.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            local.phone.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            local.status.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            local.completed.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            local.actions.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_assigners.isEmpty)
                    _buildEmptyState(local)
                  else
                    ..._assigners.map((assigner) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.black[30]!,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                assigner['id'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                assigner['name'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                assigner['email'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                assigner['phone'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: _buildStatusChip(assigner['status'] ?? ''),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                assigner['completed'] ?? '0',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return SizedBox(
      height: 140,
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.black[30]!, width: 1),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: AppColors.black[40]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(
    String text,
    String value,
    IconData icon,
    bool isSelected, {
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 50,
      child: CustomElevatedButton(
        text: text,
        onPressed: onPressed,
        color: isSelected ? AppColors.primary[70] : AppColors.grey,
        textColor: isSelected ? AppColors.white : AppColors.black,
        width: double.infinity,
        height: 42,
        borderRadius: 8,
        suffixIcon: Icon(
          icon,
          size: 18,
          color: isSelected ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'pending':
        bgColor = Colors.orange.withOpacity(0.15);
        textColor = Colors.orange;
        displayText = 'Pending';
        break;
      case 'approved':
        bgColor = Colors.green.withOpacity(0.15);
        textColor = Colors.green;
        displayText = 'Approved';
        break;
      case 'suspended':
        bgColor = Colors.red.withOpacity(0.15);
        textColor = Colors.red;
        displayText = 'Suspended';
        break;
      default:
        bgColor = AppColors.grey;
        textColor = AppColors.black;
        displayText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations local) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_giftcard, size: 80, color: AppColors.black[30]!),
          const SizedBox(height: 16),
          Text(
            local.no_assigners_available,
            style: TextStyle(fontSize: 16, color: AppColors.black[40]!),
          ),
        ],
      ),
    );
  }
}
