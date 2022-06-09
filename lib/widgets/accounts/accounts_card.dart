import 'package:flutter/material.dart';
import 'package:valorant_daily_store/models/account_model.dart';

import '../../constants/app_colors.dart';

class AccountCard extends StatelessWidget {
  AccountCard({Key? key, required this.account}) : super(key: key);
  Account account;
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(account.username,style: TextStyle(color: white)),);
  }
}
