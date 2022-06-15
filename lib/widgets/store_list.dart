import 'package:flutter/material.dart';

import '../models/store_item.dart';

class StoreList extends StatelessWidget {
  const StoreList({Key? key,required this.snapshot}) : super(key: key);
  final AsyncSnapshot<Iterable<StoreItem>> snapshot;

  @override
  Widget build(BuildContext context) {
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
  }
}
