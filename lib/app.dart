import 'package:flutter/material.dart';
import 'package:valorant_daily_store/constants/app_colors.dart';
import 'package:valorant_daily_store/screens/accounts_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accounts',
      theme: AppTheme().dailyStoreTheme,
      home: const AccountsScreen(),
    );
  }
}