import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/models/account_model.dart';
import 'package:valorant_daily_store/providers/account_provider.dart';
import 'package:valorant_daily_store/widgets/accounts/accounts_list.dart';

import '../constants/app_colors.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: const AccountsList(),
    );
  }
}
