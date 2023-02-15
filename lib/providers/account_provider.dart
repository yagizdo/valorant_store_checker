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

  // String error
  bool errorState = false;

  // User Region
  late Region region;

  // Error status code
  List<String> errorStatusCode = [];

  // add account to hive box
  void addAccount(Account newAccount) {
    saveHive(newAccount);
    notifyListeners();
  }

  // create user account and save it to hive
  void createUser(Account account) async {
    account.region ==  'NA' ? region = Region.na : account.region == 'EU' ? region = Region.eu : account.region == 'KR' ? region = Region.ko : region = Region.eu;
    notifyListeners();
    print('user region is: ${account.region} : provider region ${region}');
    client = ValorantClient(
      UserDetails(
          userName: account.username, password: account.password, region: region),
      shouldPersistSession: false,
      callback: Callback(
        onError: (String error) {
          errorState = true;
          errorStatusCode.add(error);
          notifyListeners();
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

      // create user account and save it to hive
      createUser(account);

      // client init
      await client.init(true);

      // update error state
      errorState = false;

      // get items uuids
      final store = client.playerInterface.getStorefront();
      final store2 = client.playerInterface.getStoreOffers();

      // get item skins by uuids
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

  // delete account on hive box
  void deleteHive(int index) {
    Box<Account> boxDelete = Hive.box<Account>('accounts');
    boxDelete.deleteAt(index);
    notifyListeners();
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