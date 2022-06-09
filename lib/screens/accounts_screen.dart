import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/models/account_model.dart';
import 'package:valorant_daily_store/providers/account_provider.dart';
import 'package:valorant_daily_store/widgets/accounts/accounts_list.dart';
import 'package:valorant_daily_store/widgets/accounts/add_account_card.dart';

import '../constants/app_colors.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: AlertDialog(
                    title: const Text('Add Account'),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [

                            // Username
                            TextFormField(
                              controller: usernameControl,
                              validator: (value) {
                                if (value == '') {
                                  return 'Username cant be empty';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'username',
                              ),
                            ),

                            // Password
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextFormField(
                                controller: passwordControl,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Password cant be empty';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'password',
                                ),
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            bool validResult =
                            formKey.currentState!.validate();
                            if(validResult == true) {
                              Account newAccount = Account(usernameControl.text, passwordControl.text);
                              Provider.of<AccountProvider>(context,listen: false).addAccount(newAccount);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Add')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                    ],
                  ),
                );
              });
        },
      ),
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: const AccountsList(),
    );
  }
}
