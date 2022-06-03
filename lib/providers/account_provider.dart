import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorant_client/valorant_client.dart';
import 'package:valorant_daily_store/models/store_item.dart';
import 'package:valorant_daily_store/screens/accounts_screen.dart';

import '../models/account_model.dart';

class AccountProvider extends ChangeNotifier {
  List<Account> accounts = [];
  Dio dio = Dio();
  late ValorantClient client;
  List<String> itemsUuids = [];
  List<StoreItem> storeItems = [];

  UnmodifiableListView<Account> get allAccounts =>
      UnmodifiableListView(accounts);

  UnmodifiableListView<StoreItem> get allStoreItems =>
      UnmodifiableListView(storeItems);

  get userAccount => client;

  void addAccount(Account newAccount) {
    accounts.add(newAccount);
    notifyListeners();
  }

  void createUser(Account account) async {
    client = ValorantClient(
      UserDetails(
          userName: account.username, password: account.password, region: Region.eu),
      callback: Callback(
        onError: (String error) {
          print(error);
        },
        onRequestError: (DioError error) {
          print(error.message);
        },
      ),
    );
}

  void initClient(Account account) async {
      createUser(account);
      await client.init(true);
      final store = client.playerInterface.getStorefront();
      await store.then((value) => itemsUuids = value?.skinsPanelLayout?.singleItemOffers ?? []);
    notifyListeners();
  }

  Future<List<StoreItem>> getItems() async {
    print(itemsUuids.length);
    storeItems = [];
    for(var s in itemsUuids) {
      storeItems.add(await getStoreItems(s));
  }
    notifyListeners();
    return storeItems;
  }

  Future<StoreItem> getStoreItems(String itemUuid) async {
    late StoreItem items;
    try {
      // Get response
      Response response = await dio.get('https://valorant-api.com/v1/weapons/skinlevels/${itemUuid}');;
      items = StoreItem.fromJson(response.data['data']);
    } on DioError catch (e) {
      if (e. response != null) {
        print('STATUS: ${e.response?.statusCode}');
      } else {
// Error due to setting up or sending the request
        print( 'Error sending request!');
        print(e.message);
      }
    }
    return items;
  }
}