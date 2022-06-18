import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/models/store_item.dart';
import 'package:valorant_daily_store/providers/account_provider.dart';
import 'package:valorant_daily_store/widgets/daily_store/store_list.dart';

import '../constants/app_colors.dart';
import '../models/account_model.dart';

class DailyMarketScreen extends StatefulWidget {
  DailyMarketScreen({Key? key, required this.accountInfo}) : super(key: key);
  Account accountInfo;

  @override
  State<DailyMarketScreen> createState() => _DailyMarketScreenState();
}

class _DailyMarketScreenState extends State<DailyMarketScreen> {
  late Future<Iterable<StoreItem>> itemList;

  @override
  void initState() {
    itemList = Provider.of<AccountProvider>(context, listen: false).getItems();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Market : ${widget.accountInfo.username}'),
      ),
      body: Consumer<AccountProvider>(builder: (context, state, child) {
        return state.errorState == true ?
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Oops! Something went wrong',style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text('Pls try again! ',style: TextStyle(fontSize: 20,color: white),),
                  SizedBox(height: 20,),
                  Text('If you still get error, Check your account info and internet connection',style: TextStyle(fontSize: 20,color: white),textAlign: TextAlign.center,),
                ],
              ),
            )
            : FutureBuilder<Iterable<StoreItem>>(
          future: itemList,
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<StoreItem>> snapshot) {
            return StoreList(snapshot: snapshot);
          },
        );
      }),
    );
  }
}
