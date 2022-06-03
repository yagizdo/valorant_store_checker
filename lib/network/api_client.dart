import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio();

  final String baseUrl = 'https://valorant-api.com/v1/weapons/skinlevels/';
}