import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinearProgressIndicatorApp extends StatelessWidget {
  const LinearProgressIndicatorApp({
    super.key,
    required this.consumedCaloriesPercentage,
    required this.color,
  });

  final double consumedCaloriesPercentage;
  final AlwaysStoppedAnimation<Color> color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 20.0.w, right: 25.w, top: 7.h, bottom: 7.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.h,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white.withOpacity(0.6),
              valueColor: color,
              value: consumedCaloriesPercentage,
            ),
          ),
        ],
      ),
    );
  }
}
