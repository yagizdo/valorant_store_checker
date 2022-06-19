import 'package:flutter/material.dart';
import 'package:valorant_daily_store/constants/app_colors.dart';
import 'package:valorant_daily_store/widgets/daily_store/store_item_card.dart';

import '../../models/store_item.dart';

class StoreList extends StatelessWidget {
  const StoreList({Key? key,required this.snapshot}) : super(key: key);
  final AsyncSnapshot<Iterable<StoreItem>> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator(color: white,));
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        var data = snapshot.data!.toList();
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 2.4),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) =>
                StoreItemCard(item: data[index]));
      } else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }
}
