import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperFunctions {

  static void navigateToScreen(BuildContext context, dynamic screen){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen)
    );
  }

  static void shiftToScreen(BuildContext context, dynamic screen){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => screen)
    );
  }


  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static bool validateEmail(String email) {
    final RegExp regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }

}