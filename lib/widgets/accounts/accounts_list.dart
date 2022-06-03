import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/models/account_model.dart';
import 'package:valorant_daily_store/screens/daily_market_screen.dart';
import 'package:valorant_daily_store/widgets/accounts/add_account_card.dart';

import '../../constants/app_colors.dart';
import '../../providers/account_provider.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, state, child) {
      return ListView.builder(
        itemCount: state.accounts.length + 1,
        itemBuilder: (context, index) {
          // checking if the index item is the last item of the list or not
          if (index == state.accounts.length || state.accounts.length == 0) {
            return const AddAccountCard();
          }
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DailyMarketScreen(accountInfo: state.accounts[index])),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: white)),
                child: ListTile(
                  title: Text(
                    state.accounts[index].username,
                    style: TextStyle(color: white),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
