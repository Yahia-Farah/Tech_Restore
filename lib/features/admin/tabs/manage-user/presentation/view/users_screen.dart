import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/data/models/user_model.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/get_users_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/states/get_users_states.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

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
            
            // Filter users based on search query
            final filteredUsers = users.where((user) {
              final query = _searchQuery.toLowerCase();
              final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim().toLowerCase();
              final email = (user.email ?? '').toLowerCase();
              return fullName.contains(query) || email.contains(query);
            }).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "User Management",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Search bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search users...",
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => _searchQuery = val);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Table card
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Column(
                      children: [
                        // 👇 Scroll only table, not footer
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              // Header row
                              Container(
                                color: Colors.grey[100],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 8,
                                ),
                                child: Row(
                                  children: const [
                                    SizedBox(width: 150, child: Text("Name")),
                                    SizedBox(width: 220, child: Text("Email")),
                                    SizedBox(width: 100, child: Text("Status")),
                                    SizedBox(width: 120, child: Text("Phone")),
                                    SizedBox(width: 100, child: Text("Role")),
                                    SizedBox(width: 150, child: Text("Actions")),
                                  ],
                                ),
                              ),

                              // Filtered Users rows
                              if (filteredUsers.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('No users found'),
                                )
                              else
                                ...filteredUsers.map((user) => _buildUserRow(user)),
                            ],
                          ),
                        ),
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
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          SizedBox(width: 150, child: Text(fullName.isEmpty ? 'N/A' : fullName)),
          SizedBox(width: 220, child: Text(user.email ?? 'N/A')),
          SizedBox(width: 100, child: _buildStatusChip(status)),
          SizedBox(width: 120, child: Text(user.phone ?? 'N/A')),
          SizedBox(width: 100, child: Text(user.role ?? 'N/A')),

          // Actions
          SizedBox(
            width: 150,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                  onPressed: () {},
                ),
                if (!(user.activate ?? false))
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () {},
                  ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
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
