import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:toastification/toastification.dart';

class Toasts {
  static void success(BuildContext context, {required String message}) {
    toastification.show(
      context: context,
      alignment: Alignment.bottomCenter,
      title: Text(message),
      icon: Icon(
        Icons.check_circle,
        color: AppTheme.secondaryColor,
      ),
      autoCloseDuration: const Duration(seconds: 5),
      style: ToastificationStyle.flatColored,
      backgroundColor: AppTheme.primaryColor,
      borderSide: BorderSide.none,
      showProgressBar: false,
    );
  }

  static void failure(BuildContext context, {required String message}) {
    toastification.show(
      context: context,
      alignment: Alignment.bottomCenter,
      title: Text(message),
      icon: Icon(
        FlutterRemix.close_circle_line,
        color: Colors.redAccent[300],
      ),
      autoCloseDuration: const Duration(seconds: 5),
      style: ToastificationStyle.flatColored,
      backgroundColor: Colors.red.shade100,
      borderSide: BorderSide.none,
      showProgressBar: false,
    );
  }
}
