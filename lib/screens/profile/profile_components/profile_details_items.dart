import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';

class ProfileDetailsItem extends StatelessWidget {
  const ProfileDetailsItem({
    Key? key,
    required this.title,
    required this.value,
    required this.onTap,
    required this.isArabic,
  }) : super(key: key);

  final String title;
  final String value;
  final Function() onTap;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.primaryLightColor2),
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: isArabic
                ? EdgeInsets.only(right: 25.0.w)
                : EdgeInsets.only(left: 25.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:EdgeInsets.only(right: 5.0.w,left: 2.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: isArabic
                //         ? CrossAxisAlignment.end
                //         : CrossAxisAlignment.start,
                //     children: [
                //       Expanded(
                //         child: Text(
                //           value,
                //           style: TextStyle(
                //             fontSize: 14.sp,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
