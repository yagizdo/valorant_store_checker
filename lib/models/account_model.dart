import 'package:hive/hive.dart';
part 'account_model.g.dart';

@HiveType(typeId: 1)
class Account {
  @HiveField(0)
  String username;
  @HiveField(1)
  String password;
  @HiveField(2)
  String region;

  Account(this.username,this.password,this.region);
}