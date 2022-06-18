import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Oops! Something went wrong',style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text('Pls try again! ',style: TextStyle(fontSize: 20,color: white),),
          SizedBox(height: 20,),
          Text('If you still get error, Check your account info and internet connection',style: TextStyle(fontSize: 20,color: white),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
