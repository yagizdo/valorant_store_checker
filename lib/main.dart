import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/providers/account_provider.dart';

import 'app.dart';

Future<void> main() async {
  // Hive init
  await Hive.initFlutter();

  // Open Accounts Box
  await Hive.openBox('accounts');

  runApp(
    ChangeNotifierProvider<AccountProvider>(
      create: (BuildContext context) => AccountProvider(),
      child: MyApp(),
    ),
  );
}
