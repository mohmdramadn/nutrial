import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/settings/settings_view_model.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:math' as math;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
        create: (_) => SettingsViewModel(), child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HeaderLogo(),
            SizedBox(height: 35.h),
            const _MainLogo(),
            SizedBox(height: size.height * 0.05),
            const _Settings(),
            SizedBox(height: 40.0.h),
            const _InviteFriend(),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class _MainLogo extends StatelessWidget {
  const _MainLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.settingsTitleBoxColor),
        child: Padding(
          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8),
                child: Icon(
                  Icons.settings_outlined,
                  color: AppColors.navBarBackground,
                  size: 35,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                child: Text(
                  S.of(context).settings,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: MediaQuery.of(context).size.width,
      color: AppColors.settingsHeaderColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: 0.0.w,
          right: 120.0.w,
          top: 30.0.h,
        ),
        child: Image.asset(
          'assets/images/logo_header.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Settings extends StatelessWidget {
  const _Settings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.settingsBoxColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
          child: Column(
            children: [
              _Switch(
                title: S.of(context).appLanguage,
                firstValue: 'EN',
                secondValue: 'عربي',
              ),
              _Switch(
                title: S.of(context).popUpNotification,
                firstValue: '',
                secondValue: '',
              ),
              SizedBox(height: 16.0.h)
            ],
          ),
        ),
      ),
    );
  }
}

class _InviteFriend extends StatelessWidget {
  const _InviteFriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showQrCode = context.select((SettingsViewModel vm) => vm.showQrCode);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.settingsBoxColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: 10.0.h, left: 24.0.w, right: 8.0.w, bottom: 10.0.h),
          child: Column(
            children: [
              InkWell(
                onTap: () =>
                    context.read<SettingsViewModel>().setShowQrCodeState(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).inviteFriend,
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 160.w),
                    showQrCode
                        ? const Icon(
                            Icons.arrow_drop_up_sharp,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.white,
                          ),
                    Container()
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              if (showQrCode)
                Column(
                  children: [
                    Container(
                      height: 180.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Image.asset(
                        'assets/images/qr_code.png',
                        scale: 2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      width: 121.w,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Share App',
                              style: TextStyle(color: AppColors.floatingButton),
                            ),
                            SizedBox(width: 5.w),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: const Icon(
                                Icons.reply,
                                color: AppColors.floatingButton,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _Switch extends StatelessWidget {
  const _Switch({
    Key? key,
    required this.title,
    required this.firstValue,
    required this.secondValue,
  }) : super(key: key);

  final String title;
  final String? firstValue;
  final String? secondValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h, left: 8.0.w, right: 8.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
          ToggleSwitch(
            minWidth: 35.0,
            cornerRadius: 50.0,
            activeBgColors: const [
              [AppColors.floatingButton],
              [AppColors.floatingButton]
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.white,
            inactiveFgColor: Colors.white,
            initialLabelIndex: 0,
            totalSwitches: 2,
            labels: [firstValue!, secondValue!],
            radiusStyle: true,
            onToggle: (index) {},
            minHeight: 25.h,
          ),
        ],
      ),
    );
  }
}
