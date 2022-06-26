import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:valorant_daily_store/providers/account_provider.dart';

import '../constants/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Oops! Something went wrong',style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Consumer<AccountProvider>(
            builder: (context, state,child) {
              return Text('Error Detail : ${state.errorStatusCode[0]}',style: TextStyle(fontSize: 18.sp,color: white,fontWeight: FontWeight.bold),);
            }
          ),
          SizedBox(height: 20,),
          Text('Pls try again! ',style: TextStyle(fontSize: 20,color: white),),
          SizedBox(height: 20,),
          Text('If you still get error, Check your internet connection',style: TextStyle(fontSize: 20,color: white),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
