import 'package:flutter/material.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  String _selectedDuration = '1';
  String _selectedSubscriptionType = '1000';
  
  String _getCurrency(AppLocalizations local) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? 'ج.م' : 'EGP';
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isRTL = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(local, isRTL),
              const SizedBox(height: 24),
              _buildFeatureCards(local, isRTL),
              const SizedBox(height: 32),
              _buildSubscriptionCard(local, isRTL),
              const SizedBox(height: 24),
              _buildSubscriptionInfoCards(local, isRTL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations local, bool isRTL) {
    return Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  local.subscriptionsTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  local.subscriptionsSubtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: isRTL ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCards(AppLocalizations local, bool isRTL) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        children: [
          _buildFeatureCard(
            icon: Icons.storefront,
            title: local.fullManagementTitle,
            description: local.fullManagementDescription,
            isRTL: isRTL,
          ),
          const SizedBox(width: 12),
          _buildFeatureCard(
            icon: Icons.headset_mic,
            title: local.support247Title,
            description: local.support247Description,
            isRTL: isRTL,
          ),
          const SizedBox(width: 12),
          _buildFeatureCard(
            icon: Icons.settings,
            title: local.automaticUpdatesTitle,
            description: local.automaticUpdatesDescription,
            isRTL: isRTL,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isRTL,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFDCFFD6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 26,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(AppLocalizations local, bool isRTL) {
    final price = int.parse(_selectedSubscriptionType);
    final duration = int.parse(_selectedDuration);
    final totalPrice = price * duration;
    final periodText = duration == 1 ? local.month : local.months;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFFD6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF4CAF50),
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                local.subscribeNow,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildDropdownField(
              label: local.subscriptionType,
              value: _formatSubscriptionType(local),
              onTap: () => _showSubscriptionTypePicker(local, isRTL),
              isRTL: isRTL,
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: local.duration,
              value: '$duration $periodText',
              onTap: () => _showDurationPicker(local, isRTL),
              isRTL: isRTL,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color(0xFFDCFFD6),
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$totalPrice ${_getCurrency(local)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$price × $duration $periodText',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: _buildPaymentButton(
                    icon: Icons.monetization_on,
                    label: local.cash,
                    color: Colors.orange,
                    isRTL: isRTL,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPaymentButton(
                    icon: Icons.credit_card,
                    label: local.byCard,
                    color: Colors.purple,
                    isRTL: isRTL,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required VoidCallback onTap,
    required bool isRTL,
  }) {
    return Column(
      crossAxisAlignment: isRTL ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: isRTL ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceBetween,
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentButton({
    required IconData icon,
    required String label,
    required Color color,
    required bool isRTL,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionInfoCards(AppLocalizations local, bool isRTL) {
    return Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Expanded(
          child: _buildInfoCard(
            title: local.currentSubscription,
            content: local.noActiveSubscription,
            isRTL: isRTL,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            title: local.subscriptionHistory,
            content: local.noPreviousSubscriptions,
            isRTL: isRTL,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required bool isRTL,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: isRTL ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSubscriptionType(AppLocalizations local) {
    final currency = _getCurrency(local);
    return '${local.subscriptionTypeCommission} ($_selectedSubscriptionType $currency / ${local.month})';
  }

  void _showSubscriptionTypePicker(AppLocalizations local, bool isRTL) {
    final currency = _getCurrency(local);
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('${local.subscriptionTypeCommission} (1000 $currency / ${local.month})'),
              onTap: () {
                setState(() => _selectedSubscriptionType = '1000');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('${local.subscriptionTypeCommission} (2000 $currency / ${local.month})'),
              onTap: () {
                setState(() => _selectedSubscriptionType = '2000');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDurationPicker(AppLocalizations local, bool isRTL) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('1 ${local.month}'),
              onTap: () {
                setState(() => _selectedDuration = '1');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('3 ${local.months}'),
              onTap: () {
                setState(() => _selectedDuration = '3');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('6 ${local.months}'),
              onTap: () {
                setState(() => _selectedDuration = '6');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('12 ${local.months}'),
              onTap: () {
                setState(() => _selectedDuration = '12');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
