import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../models/account_model.dart';
import '../../providers/account_provider.dart';

class AddAccountCard extends StatefulWidget {
  const AddAccountCard({Key? key}) : super(key: key);

  @override
  State<AddAccountCard> createState() => _AddAccountCardState();
}

class _AddAccountCardState extends State<AddAccountCard> {
  @override
  Widget build(BuildContext context) {
    var usernameControl = TextEditingController();
    var passwordControl = TextEditingController();

    var formKey = GlobalKey<FormState>();

    var regions = [
      'NA',
      'EU',
      'KR',
    ];

    var dropdownValue = regions[1];
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(

                // Alert Dialog shape
                child: StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    backgroundColor: black,
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
                              style: TextStyle(color: white),
                              cursorColor: white,
                              validator: (value) {
                                if (value == '') {
                                  return 'Username cant be empty';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: white),
                                labelText: 'username',
                              ),
                            ),

                            // Password
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextFormField(
                                controller: passwordControl,
                                style: TextStyle(color: white),
                                cursorColor: white,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Password cant be empty';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(color: white),
                                  labelText: 'password',
                                ),
                                obscureText: true,
                              ),
                            ),
                            DropdownButton(
                              value: dropdownValue,
                              style: const TextStyle(color: white),
                              dropdownColor: black,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: regions.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            bool validResult = formKey.currentState!.validate();
                            if (validResult == true) {
                              Account newAccount = Account(
                                  usernameControl.text, passwordControl.text, dropdownValue);
                              Provider.of<AccountProvider>(context, listen: false)
                                  .addAccount(newAccount);
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
