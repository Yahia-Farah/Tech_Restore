import 'package:flutter/material.dart';
import 'custom_toast.dart';

class ToastHelper {
  static void showCustomToast(
      BuildContext context, {
        required String text,
        required bool isError,
        Duration duration = const Duration(seconds: 2),
      }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (_) => CustomToast(text: text, isError: isError),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
