import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/data/models/user_model.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/get_users_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/states/get_users_states.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/toast_helper.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int _currentPage = 0;
  final int _itemsPerPage = 5;
  Map<String, String> _selectedRoles = {}; // Track role changes per user

  @override
  void initState() {
    super.initState();
    context.read<GetUsersCubit>().getAllUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<GetUsersCubit, GetUsersState>(
        listener: (context, state) {
          if (state is GetUsersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GetUsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetUsersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GetUsersCubit>().getAllUsers();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is GetUsersLoaded) {
            final users = state.users.content ?? [];
            final local = AppLocalizations.of(context)!;
            
            // Calculate stats
            final totalUsers = users.length;
            final activeUsers = users.where((user) => user.activate == true).length;
            final inactiveUsers = users.where((user) => user.activate == false).length;
            
            // Filter users based on search query
            final filteredUsers = users.where((user) {
              final query = _searchQuery.toLowerCase();
              final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim().toLowerCase();
              final email = (user.email ?? '').toLowerCase();
              return fullName.contains(query) || email.contains(query);
            }).toList();

            // Calculate pagination
            final totalPages = filteredUsers.isEmpty ? 1 : (filteredUsers.length / _itemsPerPage).ceil();
            final startIndex = _currentPage * _itemsPerPage;
            final endIndex = (startIndex + _itemsPerPage).clamp(0, filteredUsers.length);
            final paginatedUsers = filteredUsers.isEmpty 
                ? <UserModel>[] 
                : filteredUsers.sublist(startIndex, endIndex);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subtitle
                  Text(
                    local.manage_user_accounts_roles_status,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Overview Cards
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600) {
                        // Mobile: Stack vertically
                        return Column(
                          children: [
                            _StatsCard(
                              title: local.total_users,
                              value: totalUsers.toString(),
                              icon: Icons.people,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _StatsCard(
                                    title: local.active,
                                    value: activeUsers.toString(),
                                    icon: Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _StatsCard(
                                    title: local.inactive,
                                    value: inactiveUsers.toString(),
                                    icon: Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        // Desktop: Horizontal
                        return Row(
                          children: [
                            Expanded(
                              child: _StatsCard(
                                title: local.total_users,
                                value: totalUsers.toString(),
                                icon: Icons.people,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _StatsCard(
                                title: local.active,
                                value: activeUsers.toString(),
                                icon: Icons.check_circle,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _StatsCard(
                                title: local.inactive,
                                value: inactiveUsers.toString(),
                                icon: Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Search bar
                  CustomTextFormField(
                    controller: _searchController,
                    hint: local.search_by_name_or_email,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                        _currentPage = 0; // Reset to first page on search
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // User List Card
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width - 32,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Table Header
                                Container(
                                  color: Colors.grey[100],
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Row(
                                    children: const [
                                      SizedBox(width: 200, child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
                                      SizedBox(width: 150, child: Text("NAME", style: TextStyle(fontWeight: FontWeight.bold))),
                                      SizedBox(width: 220, child: Text("EMAIL", style: TextStyle(fontWeight: FontWeight.bold))),
                                      SizedBox(width: 180, child: Text("ROLE", style: TextStyle(fontWeight: FontWeight.bold))),
                                      SizedBox(width: 100, child: Text("STATUS", style: TextStyle(fontWeight: FontWeight.bold))),
                                      SizedBox(width: 200, child: Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.bold))),
                                    ],
                                  ),
                                ),
                                // Paginated Users rows
                                if (paginatedUsers.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text('No users found'),
                                  )
                                else
                                  ...paginatedUsers.map((user) => _buildUserRow(user)),
                              ],
                            ),
                          ),
                        ),
                        // Pagination
                        if (totalPages > 1)
                          _buildPagination(totalPages),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildUserRow(UserModel user) {
    final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    final status = (user.activate ?? false) ? "Active" : "Inactive";
    final userId = user.id ?? '';
    final displayId = userId.length > 20 ? '${userId.substring(0, 20)}...' : userId;
    final originalRole = _getValidRole(user.role);
    final currentRole = _getValidRole(_selectedRoles[userId] ?? user.role);
    final hasRoleChanged = _selectedRoles.containsKey(userId) && _selectedRoles[userId] != originalRole;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          // ID Column
          SizedBox(
            width: 200,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    userId,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: userId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ID copied to clipboard'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Icon(Icons.copy, size: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Name Column
          SizedBox(width: 150, child: Text(fullName.isEmpty ? 'N/A' : fullName)),
          // Email Column
          SizedBox(width: 220, child: Text(user.email ?? 'N/A', overflow: TextOverflow.ellipsis)),
          // Role Column with Dropdown and Save
          SizedBox(
            width: 180,
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: currentRole,
                    isExpanded: true,
                    underline: Container(),
                    items: const [
                      DropdownMenuItem(value: 'USER', child: Text('USER')),
                      DropdownMenuItem(value: 'ADMIN', child: Text('ADMIN')),
                      DropdownMenuItem(value: 'SHOP_OWNER', child: Text('SHOP_OWNER')),
                      DropdownMenuItem(value: 'GUEST', child: Text('GUEST')),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedRoles[userId] = newValue;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 4),
                if (hasRoleChanged)
                  InkWell(
                    onTap: () async {
                      final local = AppLocalizations.of(context)!;
                      final success = await context.read<GetUsersCubit>().updateUserRole(userId, currentRole);
                      setState(() {
                        _selectedRoles.remove(userId);
                      });
                      if (success) {
                        ToastHelper.showCustomToast(
                          context,
                          text: local.role_updated_successfully,
                          isError: false,
                        );
                      } else {
                        ToastHelper.showCustomToast(
                          context,
                          text: local.role_update_failed,
                          isError: true,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Status Column
          SizedBox(width: 100, child: _buildStatusChip(status)),
          // Actions Column
          SizedBox(
            width: 200,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // View Button
                ElevatedButton(
                  onPressed: () {
                    _showUserDetailsDialog(context, user);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('View', style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 4),
                // Approve/Suspend Button
                ElevatedButton(
                  onPressed: () async {
                    final local = AppLocalizations.of(context)!;
                    final success = await context.read<GetUsersCubit>().toggleUserStatus(
                      userId,
                      user.activate ?? false,
                    );
                    if (success) {
                      ToastHelper.showCustomToast(
                        context,
                        text: user.activate == false
                            ? local.user_activated_successfully
                            : local.user_deactivated_successfully,
                        isError: false,
                      );
                    } else {
                      ToastHelper.showCustomToast(
                        context,
                        text: local.user_status_update_failed,
                        isError: true,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: user.activate == false 
                        ? Colors.green.shade100 
                        : Colors.purple.shade100,
                    foregroundColor: user.activate == false 
                        ? Colors.green 
                        : Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    user.activate == false ? 'Approve' : 'Suspend',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 4),
                // Delete Button
                ElevatedButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, user);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Delete', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous Button
          ElevatedButton(
            onPressed: _currentPage > 0
                ? () {
                    setState(() {
                      _currentPage--;
                    });
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentPage > 0 ? Colors.grey.shade200 : Colors.grey.shade100,
              foregroundColor: _currentPage > 0 ? Colors.black87 : Colors.grey,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('< Prev'),
          ),
          const SizedBox(width: 8),
          // Page Numbers
          ...List.generate(totalPages, (index) {
            final isCurrentPage = index == _currentPage;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentPage = index;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCurrentPage ? AppColors.primary : Colors.grey.shade200,
                  foregroundColor: isCurrentPage ? Colors.white : Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: const Size(40, 40),
                ),
                child: Text('${index + 1}'),
              ),
            );
          }),
          const SizedBox(width: 8),
          // Next Button
          ElevatedButton(
            onPressed: _currentPage < totalPages - 1
                ? () {
                    setState(() {
                      _currentPage++;
                    });
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentPage < totalPages - 1 
                  ? AppColors.primary.withOpacity(0.1) 
                  : Colors.grey.shade100,
              foregroundColor: _currentPage < totalPages - 1 
                  ? AppColors.primary 
                  : Colors.grey,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Next >'),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileUserRow(UserModel user) {
    final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              fullName.isEmpty ? 'N/A' : fullName,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              user.email ?? 'N/A',
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _getValidRole(String? role) {
    const validRoles = ['USER', 'ADMIN', 'SHOP_OWNER', 'GUEST'];
    if (role != null && validRoles.contains(role.toUpperCase())) {
      return role.toUpperCase();
    }
    return 'USER'; // Default to USER if role is invalid or null
  }

  void _showUserDetailsDialog(BuildContext context, UserModel user) {
    final local = AppLocalizations.of(context)!;
    final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    final status = (user.activate ?? false) ? local.active : local.inactive;
    final statusColor = (user.activate ?? false) ? Colors.green : Colors.red;
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.user_details,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      local.user_info,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(local.id, user.id ?? 'N/A', showCopy: true),
                    const SizedBox(height: 12),
                    _buildDetailRow(local.name, fullName.isEmpty ? 'N/A' : fullName),
                    const SizedBox(height: 12),
                    _buildDetailRow(local.email, user.email ?? 'N/A'),
                    const SizedBox(height: 12),
                    _buildDetailRow(local.phone, user.phone ?? 'N/A'),
                    const SizedBox(height: 12),
                    _buildDetailRow(local.role, user.role ?? 'N/A'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '${local.status}: ',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: CustomElevatedButton(
                  text: local.close,
                  onPressed: () => Navigator.pop(context),
                  color: Colors.green,
                  width: 100,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool showCopy = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: Text(value)),
              if (showCopy)
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ID copied to clipboard'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Icon(Icons.copy, size: 16, color: Colors.grey),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, UserModel user) {
    final local = AppLocalizations.of(context)!;
    final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 64,
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              Text(
                local.delete_user,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                local.delete_user_warning,
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(local.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      // TODO: Implement delete user API call
                      ToastHelper.showCustomToast(
                        context,
                        text: 'User deleted successfully',
                        isError: false,
                      );
                      // Refresh the list
                      context.read<GetUsersCubit>().getAllUsers();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(local.yes_delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color text;
    switch (status) {
      case "Active":
        bg = Colors.green.withOpacity(0.2);
        text = Colors.green;
        break;
      case "Inactive":
        bg = Colors.red.withOpacity(0.2);
        text = Colors.red;
        break;
      default:
        bg = Colors.orange.withOpacity(0.2);
        text = Colors.orange;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(color: text, fontSize: 12)),
    );
  }
}

// Stats Card Widget
class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatsCard({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primary;
    
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(icon, color: cardColor, size: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
