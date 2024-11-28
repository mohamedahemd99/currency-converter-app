import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateToStartDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
