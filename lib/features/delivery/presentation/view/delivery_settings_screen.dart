import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../core/config/di.dart';
import '../../../auth/logout/viewmodel/logout_viewmodel.dart';
import '../../../auth/logout/views/logout_widget.dart';

class DeliverySettingsScreen extends StatefulWidget {
  const DeliverySettingsScreen({super.key});

  @override
  State<DeliverySettingsScreen> createState() => _DeliverySettingsScreenState();
}

class _DeliverySettingsScreenState extends State<DeliverySettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _autoAcceptOrders = false;
  String _workingHours = '9:00 AM - 6:00 PM';
  String _deliveryRadius = '10 km';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications Section
            _buildSectionCard(
              title: 'Notifications',
              icon: Icons.notifications_outlined,
              iconColor: const Color(0xFF3B82F6),
              children: [
                _buildSwitchTile(
                  title: 'Push Notifications',
                  subtitle: 'Receive notifications for new orders and updates',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.schedule, color: Colors.grey),
                  title: const Text('Notification Schedule'),
                  subtitle: const Text(
                    'Customize when to receive notifications',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to notification schedule
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Location & Delivery Section
            _buildSectionCard(
              title: 'Location & Delivery',
              icon: Icons.location_on_outlined,
              iconColor: const Color(0xFF10B981),
              children: [
                _buildSwitchTile(
                  title: 'Location Services',
                  subtitle:
                      'Allow location access for better delivery tracking',
                  value: _locationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _locationEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.access_time, color: Colors.grey),
                  title: const Text('Working Hours'),
                  subtitle: Text(_workingHours),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showWorkingHoursDialog();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey,
                  ),
                  title: const Text('Delivery Radius'),
                  subtitle: Text(_deliveryRadius),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showDeliveryRadiusDialog();
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Order Management Section
            _buildSectionCard(
              title: 'Order Management',
              icon: Icons.inventory_2_outlined,
              iconColor: const Color(0xFF8B5CF6),
              children: [
                _buildSwitchTile(
                  title: 'Auto Accept Orders',
                  subtitle: 'Automatically accept orders within your criteria',
                  value: _autoAcceptOrders,
                  onChanged: (value) {
                    setState(() {
                      _autoAcceptOrders = value;
                    });
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.filter_list, color: Colors.grey),
                  title: const Text('Order Filters'),
                  subtitle: const Text('Set preferences for order types'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to order filters
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Account Section
            _buildSectionCard(
              title: 'Account',
              icon: Icons.person_outline,
              iconColor: const Color(0xFFEF4444),
              children: [
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.grey),
                  title: const Text('Edit Profile'),
                  subtitle: const Text('Update your personal information'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to edit profile
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.grey),
                  title: const Text('Privacy & Security'),
                  subtitle: const Text('Manage your privacy settings'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to privacy settings
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.payment, color: Colors.grey),
                  title: const Text('Payment Methods'),
                  subtitle: const Text('Manage your payment information'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to payment methods
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Support Section
            _buildSectionCard(
              title: 'Support',
              icon: Icons.help_outline,
              iconColor: const Color(0xFF3B82F6),
              children: [
                ListTile(
                  leading: const Icon(Icons.help_center, color: Colors.grey),
                  title: const Text('Help Center'),
                  subtitle: const Text('Find answers to common questions'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to help center
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.chat, color: Colors.grey),
                  title: const Text('Contact Support'),
                  subtitle: const Text('Get help from our support team'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to contact support
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.feedback, color: Colors.grey),
                  title: const Text('Send Feedback'),
                  subtitle: const Text('Help us improve the app'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to feedback
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // About Section
            _buildSectionCard(
              title: 'About',
              icon: Icons.info_outline,
              iconColor: Colors.grey,
              children: [
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.grey),
                  title: const Text('Terms of Service'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to terms
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.grey),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to privacy policy
                  },
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.info, color: Colors.grey),
                  title: Text('App Version'),
                  subtitle: Text('1.0.0'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => BlocProvider(
                          create: (context) => getIt<LogoutViewModel>(),
                          child: const LogoutDialogWidget(),
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  void _showWorkingHoursDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Working Hours'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('9:00 AM - 6:00 PM'),
                  leading: Radio<String>(
                    value: '9:00 AM - 6:00 PM',
                    groupValue: _workingHours,
                    onChanged: (value) {
                      setState(() {
                        _workingHours = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('8:00 AM - 8:00 PM'),
                  leading: Radio<String>(
                    value: '8:00 AM - 8:00 PM',
                    groupValue: _workingHours,
                    onChanged: (value) {
                      setState(() {
                        _workingHours = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('24/7 Available'),
                  leading: Radio<String>(
                    value: '24/7 Available',
                    groupValue: _workingHours,
                    onChanged: (value) {
                      setState(() {
                        _workingHours = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  void _showDeliveryRadiusDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delivery Radius'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('5 km'),
                  leading: Radio<String>(
                    value: '5 km',
                    groupValue: _deliveryRadius,
                    onChanged: (value) {
                      setState(() {
                        _deliveryRadius = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('10 km'),
                  leading: Radio<String>(
                    value: '10 km',
                    groupValue: _deliveryRadius,
                    onChanged: (value) {
                      setState(() {
                        _deliveryRadius = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('20 km'),
                  leading: Radio<String>(
                    value: '20 km',
                    groupValue: _deliveryRadius,
                    onChanged: (value) {
                      setState(() {
                        _deliveryRadius = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('No Limit'),
                  leading: Radio<String>(
                    value: 'No Limit',
                    groupValue: _deliveryRadius,
                    onChanged: (value) {
                      setState(() {
                        _deliveryRadius = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }
}
