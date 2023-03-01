import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/routes/routes_names.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.isLogin,
    required this.nextSession,
  }) : super(key: key);

  final bool isLogin;
  final String nextSession;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuItem(
          title: S.of(context).myAccount,
          //TODO add screens
          screenToNavigate: null,
          color: AppColors.primaryDarkColor,
          isLoggedIn: isLogin,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.013),
        _MenuItem(
          title: S.of(context).mySessions,
          isLoggedIn: isLogin,
          screenToNavigate: sessionsRoute,
          color: AppColors.primaryDarkColor3,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.013),
        _MenuItem(
          title: S.of(context).calories,
          isLoggedIn: isLogin,
          screenToNavigate: null,
          color: AppColors.primaryLightColor,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.013),
        _MenuItem(
          title: S.of(context).caloriesCalculator,
          isLoggedIn: isLogin,
          screenToNavigate: null,
          color: AppColors.primaryLightColor,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.013),
        _MenuItem(
          title: S.of(context).myOtherCalories,
          isLoggedIn: isLogin,
          screenToNavigate: null,
          color: AppColors.primaryLightColor,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.013),
        isLogin
            ? GestureDetector(
                onTap: () => Get.toNamed(loginRoute),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.errorColor,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        S.of(context).logout,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    Key? key,
    required this.title,
    required this.isLoggedIn,
    required this.screenToNavigate,
    this.color,
  }) : super(key: key);

  final String title;
  final String? screenToNavigate;
  final bool isLoggedIn;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: screenToNavigate == null
          ? () {}
          : () {
              if (isLoggedIn) {
                //TODO change to named route
                Get.toNamed(screenToNavigate!);
              } else {
                Get.toNamed(loginRoute);
              }
            },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color ?? AppColors.primaryDarkColor),
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
