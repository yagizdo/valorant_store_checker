import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/models/store_item.dart';
import 'package:valorant_daily_store/providers/account_provider.dart';

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
    Provider.of<AccountProvider>(context, listen: false)
        .initClient(widget.accountInfo);
    itemList = Provider.of<AccountProvider>(context, listen: false).getItems();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Market'),
      ),
      body: Consumer<AccountProvider>(builder: (context, state, child) {
        return FutureBuilder<Iterable<StoreItem>>(
          future: itemList,
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<StoreItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                var data = snapshot.data!.toList();
                print(data.length);
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) =>
                        Image.network(data[index].displayIcon!));
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        );
      }),
    );
  }
}
