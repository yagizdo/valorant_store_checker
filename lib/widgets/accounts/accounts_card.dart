import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/models/account_model.dart';
import 'package:valorant_daily_store/screens/daily_market_screen.dart';

import '../../constants/app_colors.dart';
import '../../providers/account_provider.dart';

class AccountCard extends StatefulWidget {
  AccountCard({Key? key, required this.account,required this.index}) : super(key: key);
  Account account;
  int index;

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  // Loading state
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Set loading state to true
        setState(() {
          isLoading = true;
        });

        // init client with account info
        await Provider.of<AccountProvider>(context, listen: false)
            .initClient(widget.account);

        // Set loading state to false
        setState(() {
          isLoading = false;
        });

        // navigate to daily market screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DailyMarketScreen(accountInfo: widget.account)));
      },

      // If loading state is true, show loading indicator else show account name
      child: isLoading
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Account list tile
                SizedBox(
                  width: 150,
                  child: ListTile(
                    title: Text(widget.account.username,
                        style: const TextStyle(color: white)),
                  ),
                ),

                // CircularProgressIndicator
                const SizedBox(
                  height: 20,
                  width: 20,
                  child:
                      CircularProgressIndicator(strokeWidth: 3, color: white),
                ),
              ],
            )
          : ListTile(
              title: Text(widget.account.username,
                  style: const TextStyle(color: white)),
              // delete leading button
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: CupertinoColors.systemRed,
                ),
                onPressed: () {
                // delete account from hive box
                  Provider.of<AccountProvider>(context,listen: false).deleteHive(widget.index);
                },
              ),
            ),
    );
  }
}
