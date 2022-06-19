import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Platform.isMacOS ? desktopLayout() : mobileLayout();
  }

  Widget desktopLayout(){
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
          ?
      // LOADING STATE
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Account list tile
          SizedBox(
            width: widget.account.username.length >= 9 ? 220.w : 100.w,
            child: ListTile(
              title: Text(widget.account.username,
                  style: TextStyle(color: white, fontSize: 15.sp)),
            ),
          ),

          // CircularProgressIndicator
          SizedBox(
            height: 20.h,
            width: 20.w,
            child:
            CircularProgressIndicator(strokeWidth: 3, color: white),
          ),
        ],
      )
      // DEFAULT STATE
          : ListTile(
        title: Text(widget.account.username,
            style: TextStyle(color: white, fontSize: 9.sp)),
        // delete leading button
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: CupertinoColors.systemRed,
          ),
          onPressed: () {
            showAlertDialog(context);
          },
        ),
      ),
    );
  }

  Widget mobileLayout(){
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
            width: widget.account.username.length >= 9 ? 220.w : 100.w,
            child: ListTile(
              title: Text(widget.account.username,
                  style: TextStyle(color: white, fontSize: 15.sp)),
            ),
          ),

          // CircularProgressIndicator
          SizedBox(
            height: 20.h,
            width: 20.w,
            child:
            CircularProgressIndicator(strokeWidth: 3, color: white),
          ),
        ],
      )
          : ListTile(
        title: Text(widget.account.username,
            style: TextStyle(color: white, fontSize: 15.sp)),
        // delete leading button
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: CupertinoColors.systemRed,
          ),
          onPressed: () {
            showAlertDialog(context);
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: const TextStyle(color: white)),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    // delete button
    Widget deleteButton = SizedBox(
      width: 100.w,
      height: 25.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(CupertinoColors.destructiveRed),
          foregroundColor: MaterialStateProperty.all(CupertinoColors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                )
            )
        ),
        child: Text("Delete"),
        onPressed:  () {
          // delete account from hive box
          Provider.of<AccountProvider>(context,listen: false).deleteHive(widget.index);
          Navigator.pop(context);
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: black,
      title: Text("Delete Account", style: TextStyle(color: CupertinoColors.systemRed)),
      content: Text("Are you sure?", style: TextStyle(color: white)),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
