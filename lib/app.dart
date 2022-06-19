import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_daily_store/constants/app_colors.dart';
import 'package:valorant_daily_store/screens/accounts_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => MaterialApp(
        title: 'Accounts',
        theme: AppTheme().dailyStoreTheme,
        home: const AccountsScreen(),
      ),
    );
  }
}