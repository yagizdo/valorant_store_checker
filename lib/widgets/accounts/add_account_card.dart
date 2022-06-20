import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Center(child: Text('Add your Valorant Account')),
                    content: SizedBox(
                      height: Platform.isMacOS ? 280.h : 180.h,
                      width: 250.w,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            // Username
                            TextFormField(
                              controller: usernameControl,
                              style: const TextStyle(color: white),
                              cursorColor: white,
                              smartQuotesType: SmartQuotesType.disabled,
                              maxLength: 20,
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
                              padding: EdgeInsets.only(top: 15.h),
                              child: TextFormField(
                                controller: passwordControl,
                                style: const TextStyle(color: white),
                                cursorColor: white,
                                smartQuotesType: SmartQuotesType.disabled,
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
      child: const ListTile(
        title: Text(
          'Add Account..',
          style: TextStyle(color: white),
        ),
      ),
    );
  }
}
