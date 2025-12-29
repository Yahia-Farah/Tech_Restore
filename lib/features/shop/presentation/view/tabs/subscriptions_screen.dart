import 'package:flutter/material.dart';
import 'dart:async';
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
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  bool _isScrollingRight = true;
  bool _isUserScrolling = false;

  String _getCurrency(AppLocalizations local) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? 'ج.م' : 'EGP';
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.isScrollingNotifier.value) {
      if (!_isUserScrolling) {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
      }
    } else {
      if (_isUserScrolling) {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 2), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      }
    }
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_scrollController.hasClients || _isUserScrolling) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;

      if (_isScrollingRight) {
        if (currentScroll >= maxScroll) {
          _isScrollingRight = false;
        } else {
          _scrollController.jumpTo(currentScroll + 2);
        }
      } else {
        if (currentScroll <= 0) {
          _isScrollingRight = true;
        } else {
          _scrollController.jumpTo(currentScroll - 2);
        }
      }
    });
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
              crossAxisAlignment:
                  isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                  style: TextStyle(fontSize: 14, color: Colors.black54),
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
    return GestureDetector(
      onPanStart: (_) {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
      },
      onPanEnd: (_) {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 2), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      },
      onPanCancel: () {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 2), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
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
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isRTL,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
      ),
      child: Column(
        crossAxisAlignment:
            isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
            ],
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
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(AppLocalizations local, bool isRTL) {
    final price = int.parse(_selectedSubscriptionType);
    final duration = int.parse(_selectedDuration);
    final totalPrice = price * duration;
    final periodText = duration == 1 ? local.month : local.months;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      local.subscribeNow,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      local.subscriptionsSubtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
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
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(color: AppColors.primary, width: 4),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                  children: [
                    Text(
                      '$totalPrice ${_getCurrency(local)}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '$price × $duration $periodText',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
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
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required VoidCallback onTap,
    required bool isRTL,
  }) {
    return Column(
      crossAxisAlignment:
          isRTL ? CrossAxisAlignment.start : CrossAxisAlignment.end,
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
              mainAxisAlignment:
                  isRTL
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.spaceBetween,
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
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
        gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
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
            local: local,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            title: local.subscriptionHistory,
            content: local.noPreviousSubscriptions,
            isRTL: isRTL,
            local: local,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required bool isRTL,
    AppLocalizations? local,
  }) {
    final isCurrentSubscription =
        local != null && title == local.currentSubscription;
    final icon = isCurrentSubscription ? Icons.card_membership : Icons.history;
    final color = isCurrentSubscription ? Colors.blue : Colors.purple;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
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
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    '${local.subscriptionTypeCommission} (1000 $currency / ${local.month})',
                  ),
                  onTap: () {
                    setState(() => _selectedSubscriptionType = '1000');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    '${local.subscriptionTypeCommission} (2000 $currency / ${local.month})',
                  ),
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
      builder:
          (context) => Container(
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
