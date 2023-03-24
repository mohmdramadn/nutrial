import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/settings/settings_view_model.dart';
import 'package:nutrial/services/app_language.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
        create: (_) => SettingsViewModel(
              language: context.read<AppLanguage>(),
            ),
        child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<SettingsViewModel>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HeaderLogo(),
            SizedBox(height: 35.h),
            Stack(
              children: [
                Column(
                  children: [
                    const _MainLogo(),
                    SizedBox(height: size.height * 0.05),
                    const _Settings(),
                    SizedBox(height: 40.0.h),
                    const _InviteFriend(),
                  ],
                ),
                Visibility(
                  visible: vm.isLoading,
                  child: const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryDarkColor),
                  ),
                )
              ],
            ),
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
              const _Switch(),
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
                            Text(
                              S.of(context).shareApp,
                              style: const TextStyle(
                                  color: AppColors.floatingButton),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isEnglish = context.watch<SettingsViewModel>().isEnglish;

    return Padding(
      padding: EdgeInsets.only(top: 16.0.h, left: 8.0.w, right: 8.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
            child: Text(
              S.of(context).appLanguage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
          FlutterSwitch(
            width: 100.w,
            height: 40.h,
            valueFontSize: 16.0.sp,
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            inactiveText: Language.english,
            activeText: Language.arabic,
            inactiveTextColor: AppColors.floatingButton,
            activeTextColor: AppColors.floatingButton,
            toggleColor: AppColors.floatingButton,
            toggleSize: 25.0.sp,
            value: isEnglish,
            borderRadius: 30.0,
            padding: 8.0,
            showOnOff: true,
            onToggle: (val) => context
                .read<SettingsViewModel>()
                .onLanguageChangedActionAsync(),
          ),
        ],
      ),
    );
  }
}
