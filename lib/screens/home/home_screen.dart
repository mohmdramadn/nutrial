import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/models/profile_model.dart';
import 'package:nutrial/screens/home/home_components/home_details_items.dart';
import 'package:nutrial/screens/home/home_components/profile_menu_items.dart';
import 'package:nutrial/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (_) => HomeViewModel(), child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final UserProfileModel _userProfileModel = UserProfileModel();
  String nextSession = '';

  //TODO change to dynamic variable from DB
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    var showMenu = context.select((HomeViewModel vm) => vm.showProfileMenu);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const _Logo(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.865,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _WelcomeHeader(userProfileModel: _userProfileModel),
                        const _ProfileHeader(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.013),
                        if (showMenu)
                          ProfileMenu(
                              isLogin: isLogin, nextSession: nextSession),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        //TODO add dynamic values
                        HomeDetailsItem(
                          title: S.of(context).id,
                          value: 'DMAHER',
                          onTap: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        HomeDetailsItem(
                          title: S.of(context).name,
                          value: 'David Maher',
                          onTap: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        HomeDetailsItem(
                          title: S.of(context).ageTitle,
                          value: '32',
                          onTap: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        HomeDetailsItem(
                          title: S.of(context).height,
                          value: '173 cm',
                          onTap: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        HomeDetailsItem(
                          title: S.of(context).nextSession,
                          value: '15/04/2022',
                          onTap: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        const _LastBodyCompTitle(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        HomeDetailsItem(
                          title: S.of(context).totalWeight,
                          value: '72.4 k.g',
                          onTap: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        HomeDetailsItem(
                          title: S.of(context).fatsPercentage,
                          value: '19.5 %',
                          onTap: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        const _MusclePercentage(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        HomeDetailsItem(
                          title: S.of(context).waterPercentage,
                          value: '19.5 %',
                          onTap: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        const _UpdateProfileButton(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.065),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MusclePercentage extends StatelessWidget {
  const _MusclePercentage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            padding: EdgeInsets.only(left: 25.0.w),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).musclesPercentage,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 28.w),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '33.7 %',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
    return Padding(
      padding: EdgeInsets.only(left: 50.0.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 25.h,
          decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.orangeTextColor)),
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
      onTap: () => context.read<HomeViewModel>().setShowProfileMenuState(),
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
    required UserProfileModel userProfileModel,
  })  : _userProfileModel = userProfileModel,
        super(key: key);

  final UserProfileModel _userProfileModel;

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
                  top: 40.h,
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
                  text: S.of(context).welcome,
                  style: const TextStyle(
                    color: AppColors.yellowTextColor,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic,
                  ),
                  children: const [
                    TextSpan(
                      text: ' David Maher',
                      style: TextStyle(
                          color: AppColors.yellowTextColor,
                          fontSize: 18,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
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

class _Logo extends StatelessWidget {
  const _Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width,
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12.0.w),
            child: Image.asset(
              'assets/images/logo_header.png',
              height: MediaQuery.of(context).size.height * 0.13,
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.fitWidth,
            ),
          )),
    );
  }
}
