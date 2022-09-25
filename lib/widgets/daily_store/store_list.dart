import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_daily_store/constants/app_colors.dart';
import 'package:valorant_daily_store/widgets/daily_store/store_item_card.dart';

import '../../models/store_item.dart';

class StoreList extends StatelessWidget {
  const StoreList({Key? key, required this.snapshot}) : super(key: key);
  final AsyncSnapshot<Iterable<StoreItem>> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
          child: CircularProgressIndicator(
        color: white,
      ));
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        print('snapshot error : ${snapshot.error}');
        return const Text(
          'List Snapshot error',
          style: TextStyle(color: white),
        );
      } else if (snapshot.hasData) {
        var data = snapshot.data!.toList();
        return Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return StoreItemCard(item: data[index]);
              },
            ));
      } else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }
}
