import 'package:dio/dio.dart';
import 'package:valorant_daily_store/models/store_item.dart';
import 'package:valorant_daily_store/network/api_client.dart';

class DailyStoreClient extends ApiClient {
  Future<StoreItem> getStoreItems(String itemUuid) async {
    late StoreItem items;
    try {
      // Get response
      Response response = await super.dio.get('${super.baseUrl}${itemUuid}');
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
    print(items.displayName);
    return items;
  }
}