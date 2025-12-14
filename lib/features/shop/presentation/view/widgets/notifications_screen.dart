import 'package:flutter/material.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, String>> notifications = [
    {"title": "New order ", "body": "notification 1."},
    {"title": "New offer ", "body": "notification 2"},
    {"title": "Remember ", "body": "notification 3"},
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Image.asset(AppIcons.arrowBack,color: AppColors.primary,),
        ),
        title: Text(
          local.notification,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Column(
            children: [
              Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    notifications.removeAt(index);
                  });
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  title: Text(item["title"] ?? ""),
                  subtitle: Text(item["body"] ?? ""),
                ),
              ),
              Divider(color: AppColors.white[70]),
            ],
          );
        },
      ),
    );
  }
}
