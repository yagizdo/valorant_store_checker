import 'package:hive/hive.dart';
part 'account_model.g.dart';

@HiveType(typeId: 1)
class Account {
  @HiveField(0)
  String username;
  @HiveField(1)
  String password;

  Account(this.username,this.password);
}