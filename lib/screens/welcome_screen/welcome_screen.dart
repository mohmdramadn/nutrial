import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/screens/login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover),
              color: Colors.grey[800]),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Logo(size: size),
                  SizedBox(height: size.height * 0.05),
                  const _NewUser(),
                  const SizedBox(height: 16),
                  const _AlreadyHaveAccount(),
                ],
              ),
              const _BottomLogo(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.45,
        child: Image.asset(
          'assets/images/logo.png',
        ));
  }
}

class _BottomLogo extends StatelessWidget {
  const _BottomLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/powerBy.png'),
          ],
        ),
      ),
    );
  }
}

class _NewUser extends StatelessWidget {
  const _NewUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.7,
      child: ElevatedButton(
        onPressed: () => Get.toNamed(onBoardingRoute),
        style: ButtonStyle(
          padding:
          MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 13.0,horizontal: 15)),
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
          S.of(context).newUser,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
      ),
    );
  }
}

class _AlreadyHaveAccount extends StatelessWidget {
  const _AlreadyHaveAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.7,
      child: ElevatedButton(
        onPressed: () => Get.to(() => const LoginScreen()),
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 13.0,horizontal: 15)),
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent.withOpacity(0.0)),
          foregroundColor: MaterialStateProperty.all<Color>(
              AppColors.primaryColor.withOpacity(0.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
        child: Text(
          S.of(context).alreadyHaveAccount,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
      ),
    );
  }
}
