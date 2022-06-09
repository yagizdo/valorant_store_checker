import 'package:flutter/material.dart';
import 'package:valorant_daily_store/models/account_model.dart';
import 'package:valorant_daily_store/screens/daily_market_screen.dart';

import '../../constants/app_colors.dart';

class AccountCard extends StatelessWidget {
  AccountCard({Key? key, required this.account}) : super(key: key);
  Account account;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => DailyMarketScreen(accountInfo: account)));
      print('tiklandi');
    },icon: ListTile(title: Text(account.username,style: TextStyle(color: white)),));
  }
}
