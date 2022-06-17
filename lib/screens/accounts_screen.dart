import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:valorant_daily_store/widgets/accounts/accounts_list.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  var usernameControl = TextEditingController();
  var passwordControl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: const AccountsList(),
    );
  }
}
