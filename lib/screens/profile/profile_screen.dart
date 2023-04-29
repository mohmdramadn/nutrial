import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/components/logo.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/profile/profile_components/profile_details_items.dart';
import 'package:nutrial/screens/profile/profile_components/profile_menu_items.dart';
import 'package:nutrial/screens/profile/profile_components/profile_percentage_items.dart';
import 'package:nutrial/screens/profile/profile_view_model.dart';
import 'package:nutrial/services/app_language.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
        create: (_) => ProfileViewModel(
              firebaseService: context.read<FirebaseService>(),
              messageService: context.read<MessageService>(),
              connectionService: context.read<ConnectionService>(),
              language: context.read<AppLanguage>(),
            ),
        child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  String nextSession = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().initGetProfileAsync();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = context.watch<ProfileViewModel>().isLoading;
    var isLoggedIn = context.watch<ProfileViewModel>().isLoggedIn;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Logo(),
              if (!isLoggedIn) SizedBox(height: 200.h),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : !isLoggedIn
                      ? const _LogInContainer()
                      : _ProfileDetails(nextSession: nextSession),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogInContainer extends StatelessWidget {
  const _LogInContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.withOpacity(0.7),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0.h),
            child: Text(
              S.of(context).notLoggedIn,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: const _LoginButton(),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: ElevatedButton(
        onPressed: () => context.read<ProfileViewModel>().navigateToLogin(),
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
        child: Text(
          S.of(context).login,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  const _ProfileDetails({
    Key? key,
    required this.nextSession,
  }) : super(key: key);

  final String nextSession;

  @override
  Widget build(BuildContext context) {
    var userData = context.select((ProfileViewModel vm) => vm.user);
    var showMenu = context.select((ProfileViewModel vm) => vm.showProfileMenu);
    var isLoggedIn = context.watch<ProfileViewModel>().isLoggedIn;
    var isArabic = context.watch<ProfileViewModel>().isArabic;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.865,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _WelcomeHeader(name: userData?.fullName ?? ''),
            const _ProfileHeader(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.013),
            if (showMenu)
              ProfileMenu(
                isLogin: isLoggedIn,
                nextSession: nextSession,
                logout: () =>
                    context.read<ProfileViewModel>().logoutActionAsync(),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            ProfileDetailsItem(
              title: S.of(context).id,
              value: userData?.username ?? '',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ProfileDetailsItem(
              title: S.of(context).name,
              value: userData?.fullName ?? '',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ProfileDetailsItem(
              title: S.of(context).ageTitle,
              value: userData?.age ?? '',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            ProfileDetailsItem(
              title: S.of(context).height,
              value: '${userData?.height} cm',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            ProfileDetailsItem(
              title: S.of(context).nextSession,
              value: '15/04/2022',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            const _LastBodyCompTitle(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ProfilePercentageItem(
              title: S.of(context).totalWeight,
              value: '72.4 k.g',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ProfilePercentageItem(
              title: S.of(context).fatsPercentage,
              value: '${userData?.fatsPercentage ?? ''} %',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ProfilePercentageItem(
              title: S.of(context).musclesPercentage,
              value: '${userData?.musclesPercentage ?? ''} %',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ProfilePercentageItem(
              title: S.of(context).waterPercentage,
              value: '${userData?.waterPercentage ?? ''} %',
              onTap: () {},
              isArabic: isArabic,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            const _UpdateProfileButton(),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}

class _LastBodyCompTitle extends StatelessWidget {
  const _LastBodyCompTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isArabic = context.watch<ProfileViewModel>().isArabic;

    return Padding(
      padding: isArabic
          ? EdgeInsets.only(left: 180.0.w)
          : EdgeInsets.only(right: 120.0.w),
      child: Container(
        height: 25.h,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.orangeTextColor)),
        ),
        child: Text(
          S.of(context).lastBodyComp,
          style: TextStyle(
              color: AppColors.orangeTextColor,
              fontSize: 15.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _UpdateProfileButton extends StatelessWidget {
  const _UpdateProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: AppColors.redColorLight,
          ),
          child: Text(
            S.of(context).updateProfile,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.w700,
            ),
          )),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<ProfileViewModel>().setShowProfileMenuState(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.orangeColor,
        ),
        child: Center(
          child: Text(
            S.of(context).profileMenu.toUpperCase(),
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: AppColors.backgroundColor,
                    radius: 28,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 40.w,
                  top: 48.h,
                  bottom: 100.h,
                  right: 15.w,
                  child: const CircleAvatar(
                    radius: 28,
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  text: '${S.of(context).welcome} ',
                  style: TextStyle(
                    color: AppColors.yellowTextColor,
                    fontSize: 16.sp,
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic,
                  ),
                  children: [
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
