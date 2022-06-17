import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/models/account_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:valorant_daily_store/widgets/accounts/accounts_card.dart';
import 'package:valorant_daily_store/widgets/accounts/add_account_card.dart';

import '../../providers/account_provider.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, state, child) {

      // Burada Valuelistenable builder kullanarak hive box i dinliyoruz
      // eger data yok ise sadece add account butonu gosteriliyor. Data var ise listview gosteriliyor
      // Normalde hive icerisinde listenable fonksiyonu yok o bize hive_flutter paketi ile geliyor
      return ValueListenableBuilder(
        valueListenable: Hive.box<Account>('accounts').listenable(),
        builder: (context, Box<Account> box, _) {
          if(box.values.isEmpty) {
            return const AddAccountCard();
          }
          return ListView.builder(
            itemCount: box.values.length + 1,
            itemBuilder: (context,index) {
              // checking if the index item is the last item of the list or not
              if (index == box.values.length) {
                   return const AddAccountCard();
          }
              // Get data
              Account? data = box.getAt(index);
              return AccountCard(account: data!);
            },
          );
        },
      );
    });
  }
}
