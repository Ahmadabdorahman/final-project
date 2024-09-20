  import 'package:flutter/material.dart';

    // لطباعه الخطا المحتمل للمستخدم اثناء عمليه تسجيل الدخول او انشاء حساب
   showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(text),
      action: SnackBarAction(label: "close", onPressed: () {}),
    ));
 }