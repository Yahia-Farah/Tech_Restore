import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/notifications/notification_model.dart';
import '../../viewmodel/notifications_cubit.dart';
import '../../viewmodel/notifications_state.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsCubit>().fetchNotifications();
    });
  }

  String _formatTime(String? timestamp, Locale locale) {
    if (timestamp == null || timestamp.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (locale.languageCode == 'ar') {
        if (difference.inDays > 0) {
          return 'منذ ${_toArabicNumerals(difference.inDays.toString())} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
        } else if (difference.inHours > 0) {
          return 'منذ ${_toArabicNumerals(difference.inHours.toString())} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}';
        } else if (difference.inMinutes > 0) {
          return 'منذ ${_toArabicNumerals(difference.inMinutes.toString())} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'}';
        } else {
          return 'الآن';
        }
      } else {
        if (difference.inDays > 0) {
          return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
        } else if (difference.inHours > 0) {
          return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
        } else if (difference.inMinutes > 0) {
          return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
        } else {
          return 'Just now';
        }
      }
    } catch (e) {
      return timestamp;
    }
  }

  String _toArabicNumerals(String text) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    String result = text;
    for (int i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], arabic[i]);
    }
    return result;
  }

  String _formatFullDateTime(String? timestamp, Locale locale) {
    if (timestamp == null || timestamp.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(timestamp);

      if (locale.languageCode == 'ar') {
        final year = _toArabicNumerals(dateTime.year.toString());
        final month = _toArabicNumerals(
          dateTime.month.toString().padLeft(2, '0'),
        );
        final day = _toArabicNumerals(dateTime.day.toString().padLeft(2, '0'));
        _toArabicNumerals(
          dateTime.hour.toString().padLeft(2, '0'),
        );
        final minute = _toArabicNumerals(
          dateTime.minute.toString().padLeft(2, '0'),
        );
        final period = dateTime.hour >= 12 ? 'م' : 'ص';
        final displayHour =
            dateTime.hour > 12
                ? dateTime.hour - 12
                : (dateTime.hour == 0 ? 12 : dateTime.hour);
        final displayHourStr = _toArabicNumerals(displayHour.toString());

        return '$year/$month/$day - $displayHourStr:$minute $period';
      } else {
        final year = dateTime.year;
        final month = dateTime.month.toString().padLeft(2, '0');
        final day = dateTime.day.toString().padLeft(2, '0');
        final hour =
            dateTime.hour > 12
                ? dateTime.hour - 12
                : (dateTime.hour == 0 ? 12 : dateTime.hour);
        final minute = dateTime.minute.toString().padLeft(2, '0');
        final period = dateTime.hour >= 12 ? 'PM' : 'AM';

        return '$year/$month/$day - $hour:$minute $period';
      }
    } catch (e) {
      return timestamp;
    }
  }

  void _showNotificationDetails(
    BuildContext context,
    NotificationModel notification,
    Locale locale,
    AppLocalizations local,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final isRTL = locale.languageCode == 'ar';
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.green[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    local.notification,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notification.id != null) ...[
                    Text(
                      '${local.id}: ${notification.id}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    local.message,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notification.message ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    local.date,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _formatFullDateTime(notification.timestamp, locale),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text(
                  local.close,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isRTL = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Image.asset(AppIcons.arrowBack, color: AppColors.white),
        ),
        title: Text(
          local.notifications,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NotificationsLoading || state is NotificationsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NotificationsCubit>().fetchNotifications();
                    },
                    child: Text(local.retry),
                  ),
                ],
              ),
            );
          }

          if (state is NotificationsLoaded) {
            final notifications = state.notifications;

            if (notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      local.noNotifications,
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<NotificationsCubit>().fetchNotifications();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Dismissible(
                    key: Key(notification.id ?? index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment:
                          isRTL ? Alignment.centerLeft : Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    onDismissed: (direction) {
                      if (notification.id != null) {
                        context.read<NotificationsCubit>().deleteNotification(
                          notification.id!,
                        );
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          _showNotificationDetails(
                            context,
                            notification,
                            locale,
                            local,
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          title: Text(
                            notification.message ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              _formatTime(notification.timestamp, locale),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.notifications_active_outlined,
                              color: Colors.green[700],
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
