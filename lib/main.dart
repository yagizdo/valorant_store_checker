import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/providers/account_provider.dart';

import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AccountProvider>(
      create: (BuildContext context) => AccountProvider(),
      child: MyApp(),
    ),
  );
}
