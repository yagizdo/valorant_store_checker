import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/store_item.dart';

class StoreItemCard extends StatelessWidget {
  StoreItemCard({Key? key, required this.item}) : super(key: key);
  StoreItem item;

  // Weapon Scale Value Map
  final Map<String, double> _weaponScaleValueMap = {
    'frenzy': 2.5.w,
    'classic': 2.5.w,
    'ghost': 3.0.w,
    'sheriff': 2.7.w,
    'shorty': 3.0.w,
    'marshal': 2.5.w,
    'operator': 2.5.w,
    'stinger': 2.5.w,
    'spectre': 2.w,
    'phantom': 4.0.w,
    'bucky': 4.0.w,
    'ares': 1.5.w,
    'melee': 1.w,
  };

  @override
  Widget build(BuildContext context) {
    String? weaponName = item.displayName;
    String weaponKey = weaponName != null ? weaponName.split(' ')[weaponName.split(' ').length - 1].toLowerCase() : '';

    double scaleValue = _weaponScaleValueMap[weaponKey] ?? 2.3; // eğer key map içinde yoksa 0.0 döndürü

    return Padding(
      padding: EdgeInsets.only(top: 15.w),
      child: Column(
        children: [
          SizedBox(
            height: 10.w,
          ),
          Image.network(
            item.displayIcon!,
            // use the weapon scale value map to scale the image
            // And skins name e.g 'frenzy' is the key but skins name is ' Glitchpop Frenzy'
            // So we need to get skins type e.g 'Glitchpop Frenzy' or 'Prism II Sherrif' and split it
            // and get the skin name so 'frenzy' or 'sheriff and use it as a key to get the scale value
            // and scale the image
            scale: scaleValue,
          ),
          SizedBox(height: 20.w),
          Text(
            item.displayName!,
            style: item.displayName!.length <= 15
                ? Theme.of(context).textTheme.headline5
                : Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
