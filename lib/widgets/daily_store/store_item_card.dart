import 'package:flutter/material.dart';

import '../../models/store_item.dart';

class StoreItemCard extends StatelessWidget {
  StoreItemCard({Key? key, required this.item}) : super(key: key);
  StoreItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(item.streamedVideo ?? 'No video');
      },
      child: Column(
        children: [
          Image.network(
            item.displayIcon!,
            scale: 1.5,
          ),
          SizedBox(height: 10),
          Text(
            item.displayName!,
            style: item.displayName!.length <= 15
                ? Theme.of(context).textTheme.headline5
                : Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
