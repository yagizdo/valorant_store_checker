import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../models/account_model.dart';
import '../../providers/account_provider.dart';

class AddAccountCard extends StatelessWidget {
  const AddAccountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usernameControl = TextEditingController();
    var passwordControl = TextEditingController();

    var formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () {
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
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: ListTile(
          title: Text(
            'Add Account..',
            style: TextStyle(color: white),
          ),
        ),
      ),
    );
  }
}
