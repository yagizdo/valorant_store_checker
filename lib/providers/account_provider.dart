import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:valorant_client/valorant_client.dart';
import 'package:valorant_daily_store/models/store_item.dart';
import 'package:valorant_daily_store/screens/accounts_screen.dart';

import '../models/account_model.dart';

class AccountProvider extends ChangeNotifier {
  // Dio client
  Dio dio = Dio();

  // Valorant Client
  late ValorantClient client;

  // Item UUID List
  List<String> itemsUuids = [];

  // Store Items List
  List<StoreItem> storeItems = [];

  // add account to hive box
  void addAccount(Account newAccount) {
    saveHive(newAccount);
    notifyListeners();
  }

  // create user account and save it to hive
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

  // init client with account info
  Future<void> initClient(Account account) async {
      createUser(account);
      await client.init(true);
      final store = client.playerInterface.getStorefront();
      await store.then((value) => itemsUuids = value?.skinsPanelLayout?.singleItemOffers ?? []);
  }

  // get store items
  Future<List<StoreItem>> getItems() async {
    print(itemsUuids.length);
    storeItems = [];
    for(var s in itemsUuids) {
      storeItems.add(await getStoreItems(s));
  }
    return storeItems;
  }

  // get store item by uuid
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

  // save account to hive
  Future<void> saveHive(Account account) async {
    // Account turunde veri tutacak bir hive box actik
    Box<Account> boxSave = Hive.box<Account>('accounts');
    // Direk account listesi kayit etmek yerine tek tek accountlari kayit ediyoruz.
    // Hive zaten kendi icinde liste gibi bunlara index veriyor
    boxSave.add(account);
    notifyListeners();
  }
}